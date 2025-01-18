@echo off
title Administracion de recursos compartidos y cuotas
rem Ejercicios ASIR - IMSO
cls
setlocal enabledelayedexpansion

rem Estableciendo en una variable el path en el que se trabajará
set ruta="j:\aula"

rem Redireccionar resultado grupo a un fichero
net localgroup manana > grupo_manana.txt
net localgroup tarde > grupo_tarde.txt
net localgroup jefesDepartamento > grupo_jefesDepartamento.txt

rem Todos los usuarios del grupo tendrán permiso total sobre la carpeta común de cada grupo.
rem Cada usuario tendrá un espacio máximo limitado de 15GB excepto el Jefe de departamento que será de 50GB

rem Opción1: Cada usuario será propietario de su carpeta teniendo control total y ningún otro usuario, excepto 
rem 		 el Jefe de Departamento que podrá ver el contenido (opcional: podrá añadir pero nunca borrar contenidos).

rem habilitamos la gestión de cuotas para la variable %ruta%
fsutil quota enforce %ruta%

rem recorer los ficheros de texto redirecionados del resultado de localgroup, estableciendo permisos en la carpeta de cada usuario 
rem en su carpeta correspondiente estableciendo como propietario al propio usuario y otorgando permisos de control total para el 
rem propio usuario, para el administrador del sistema y para el grupo jefesDepartamento solamente poder añadir-leer-ejecutar (AD,RX).
rem (OI)(CI) herencia que afecta a carpeta, subcarpetas y ficheros
for /f "tokens=1-3 skip=6" %%i in (grupo_manana.txt) do (
	if not "%%i %%j %%k" == "Se ha completado" (
		mkdir %ruta%\manana\%%i
		icacls %ruta%\manana\%%i /setowner %%i /Q
		icacls %ruta%\manana\%%i /inheritance:r /grant:%%i:(OI)(CI)(F) /grant:jefesDepartamento:(OI)(CI)(AD,RX) /grant:wadmin:(OI)(CI)(F) /Q
		net share compartido_manana_%%i=%ruta%\manana\%%i /cache:programs /grant:%%i,Full /grant:jefesDepartamento:(OI)(CI)(F) /grant:wadmin,Full
		fsutil quota modify %ruta%\manana\%%i 13958643712 16106127360  %%i
	)
)

for /f "tokens=1-3 skip=6" %%i in (grupo_tarde.txt) do (
	if not "%%i %%j %%k" == "Se ha completado" (
		mkdir %ruta%\tarde\%%i
		icacls %ruta%\tarde\%%i /setowner %%i /Q
		icacls %ruta%\tarde\%%i /inheritance:r /grant:%%i:(OI)(CI)(F) /grant:jefesDepartamento:(OI)(CI)(AD,RX) /grant:wadmin:(OI)(CI)(F) /Q
		net share compartido_tarde_%%i=%ruta%\tarde\%%i /cache:programs /grant:%%i,Full /grant:wadmin,Full
		fsutil quota modify %ruta%\tarde\%%i 13958643712 16106127360  %%i
	)
)

for /f "tokens=1-3 skip=6" %%i in (grupo_jefesDepartamento.txt) do (
	if not "%%i %%j %%k" == "Se ha completado" (
		mkdir %ruta%\jefatura\%%i
		icacls %ruta%\jefatura\%%i /setowner %%i /Q
		icacls %ruta%\jefatura\%%i /inheritance:r /grant:%%i:(OI)(CI)(F) /grant:wadmin:(OI)(CI)(F) /Q
		net share compartido_tarde_%%i=%ruta%\jefatura\%%i /cache:programs /grant:%%i,Full /grant:wadmin,Full
		fsutil quota modify %ruta%\jefatura\%%i 49392123904 53687091200  %%i
	)
)


rem -----------------------
rem CREACION DE DIRECTORIOS
rem -----------------------
mkdir %ruta%\manana\comun
mkdir %ruta%\tarde\comun
mkdir %ruta%\jefatura\comun
mkdir %ruta%\jefatura\administrador
mkdir %ruta%\jefatura\recursos\entregas
mkdir %ruta%\jefatura\recursos\intercambio


rem ----------------------
rem ACLs PERMISOS CARPETAS
rem ----------------------
rem \manana\comun: los usuarios del grupo manana podrán añadir y leer (RD,AD), los jefes de departamento podrán añadir, leer y ejecutar, en la raíz tendrán control total
rem inheritance:r quita todas las ACE (Access Control Entry) heredadas
icacls %ruta%\manana /inheritance:r /grant manana:(RD,AD) /grant jefesDepartamento:(OI)(F) /grant wadmin:(OI)(CI)(F) /Q
icacls %ruta%\manana\comun /inheritance:r /grant manana:(OI)(CI)(RD) /grant jefesDepartamento:(OI)(CI)(AD,RX) /grant wadmin:(OI)(CI)(F) /Q
rem el grupo tarde será propietario de su comun.
icacls %ruta%\manana\comun /setowner manana /Q

rem \manana\tarde: los usuarios del grupo tarde podrán añadir, los jefes de departamento podrán añadir, leer y ejecutar.
icacls %ruta%\tarde /inheritance:r /grant tarde:(RD,AD) /grant jefesDepartamento:(OI)(F) /grant wadmin:(OI)(CI)(F) /Q
icacls %ruta%\tarde\comun /inheritance:r /grant tarde:(OI)(CI)(RD,AD) /grant jefesDepartamento:(OI)(CI)(AD,RX) /grant wadmin:(OI)(CI)(F) /Q
rem el grupo tarde será propietario de su comun.
icacls %ruta%\tarde\comun /setowner tarde /Q

rem En Jefatura sólo tendrá acceso el Jefe de Departamento no teniendo permiso ninguno los demás usuarios.
icacls %ruta%\jefatura /inheritance:r /deny manana:(F) /deny tarde:(F) /grant jefesDepartamento:(RD) /grant wadmin:(OI)(CI)(F) /Q
icacls %ruta%\jefatura /setowner jefesDepartamento /Q

rem Aplicaciones: Lectura para todos los usuarios, y control total para el Jefe de Departamento
icacls %ruta%\jefatura\recursos\aplicaciones /grant tarde:(OI)(CI)(RX) /grant manana:(OI)(CI)(RX) /grant jefesDepartamento:(OI)(CI)(F) /grant wadmin:(OI)(CI)(F) /Q
icacls %ruta%\jefatura\recursos\aplicaciones /setowner jefesDepartamento /Q
net share comp_recur_aplicaciones=%ruta%\jefatura\recursos\aplicaciones /cache:programs /grant:tarde,full /grant:manana,full /grant:jefesDepartamento,full /grant:wadmin,full

rem Entregas: Permisos para añadir a todos los usuarios y control total para Jefe de Departamento
icacls %ruta%\jefatura\recursos\entregas /grant tarde:(OI)(CI)(AD) /grant manana:(OI)(CI)(AD) /grant jefesDepartamento:(OI)(CI)(F) /grant wadmin:(OI)(CI)(F) /Q
icacls %ruta%\jefatura\recursos\entregas /setowner jefesDepartamento /Q

rem Intercambio: Permiso de modificación para todos.
icacls %ruta%\jefatura\recursos\intercambio /grant tarde:(OI)(CI)(M) /grant manana:(OI)(CI)(M) /grant jefesDepartamento:(OI)(CI)(F) /grant wadmin:(OI)(CI)(F) /Q
icacls %ruta%\recursos\intercambio /setowner jefesDepartamento /Q


rem --------------------
rem CARPETAS COMPARTIDAS
rem --------------------
rem Las carpetas deberán ser accesibles desde cualquier equipo de la red Deberá permitirse un acceso permanente, 
rem incluso sin red a la carpeta de cada usuarios desde los equipos de la red.
net share comp_manana_comun=%ruta%\manana\comun /cache:programs /grant:manana,full /grant:jefesDepartamento,full /grant:wadmin,full
net share comp_tarde_comun=%ruta%\tarde\comun /cache:programs /grant:tarde,full /grant:jefesDepartamento,full /grant:wadmin,full
net share comp_jefatura=%ruta%\jefatura /cache:programs /grant:jefesDepartamento,full /grant:wadmin,full
net share comp_recur_entregas=%ruta%\jefatura\recursos\entregas /cache:programs /grant:tarde,full /grant:manana,full /grant:jefesDepartamento,full /grant:wadmin,full
net share comp_recur_intercambio=%ruta%\jefatura\recursos\intercambio /cache:programs /grant:tarde,full /grant:manana,full /grant:jefesDepartamento,full /grant:wadmin,full

rem la única diferencia entre /cache:automatic a /cache:programs es que esta última se "optimiza para rendimiento"

rem --------------
rem AYUDA PERMISOS
rem --------------
rem  N - sin acceso
rem  F - acceso total
rem  M - acceso de modificación
rem  RX - acceso de lectura y ejecución
rem  R - acceso de sólo lectura
rem  W - acceso de sólo escritura
rem  D - acceso de eliminación
rem  DE - eliminar
rem  RC - control de lectura
rem  WDAC - escribir DAC
rem  WO - escribir propietario
rem  S - sincronizar
rem  AS - acceso al sistema de seguridad
rem  MA - máximo permitido
rem  GR - lectura genérica
rem  GW - escritura genérica
rem  GE - ejecución genérica
rem  GA - todo genérico
rem  RD - leer datos/lista de directorio
rem  WD - escribir datos/agregar archivo
rem  AD - anexar datos/agregar subdirectorio
rem  REA - leer atributos extendidos
rem  WEA - escribir atributos extendidos
rem  X - ejecutar/atravesar
rem  DC - eliminar secundario
rem  RA - leer atributos
rem  WA - escribir atributos
rem (OI) - herencia de objeto
rem (CI) - herencia de contenedor
rem (IO) - sólo herencia
rem (NP) - no propagar herencia
rem (I) - permiso heredado del contenedor principal