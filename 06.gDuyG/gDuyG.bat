@echo off
color 3F
title gDuyG - Gestion de usuarios y grupos

rem Ejercicios ASIR - IMSO

rem expansión retrasada hará que las variables dentro de un archivo por lotes se expandan en el momento de la ejecución en lugar de al tiempo de análisis
setlocal enabledelayedexpansion

rem parametros disponibles
rem Menu principal
if "%1" == "" goto menu
if "%1" == "/menu" goto menu
if "%1" == "-m" goto menu
rem 1. Crear usuarios
if "%1" == "/crearu" goto crear_usuarios
if "%1" == "-cu" goto crear_usuarios
rem 2. Eliminar usuarios
if "%1" == "/eliminaru" goto eliminar_usuarios
if "%1" == "-eu" goto eliminar_usuarios
rem 3. Crear usuarios en su grupo de turnos sin asignar a usuarios
if "%1" == "/crearug" goto crear_usuarios_grupos
if "%1" == "-cug" goto crear_usuarios_grupos
rem 4. Crear grupos de turnos asignado a usuarios previamente creados
if "%1" == "/creargau" goto crear_grupos_asignado_usuarios
if "%1" == "-cgau" goto crear_grupos_asignado_usuarios
rem 5. Eliminar los grupos de turnos
if "%1" == "/eliminargt" goto eliminar_grupos_turnos
if "%1" == "-egt" goto eliminar_grupos_turnos
rem 6. Mostrar usuarios y grupos
if "%1" == "/mostrar" goto mostrar
if "%1" == "-m" goto mostrar
rem 7. Ayuda
if "%1" == "/ayuda" goto ayuda
if "%1" == "-?" goto ayuda

:menu
cls
rem banner menu principal
echo.
echo                  ,---,                            ,----..    
echo                .'  .' `\                         /   /   \   
echo              ,---.'     \          ,--,         :   :     :  
echo     ,----._,.:   :  .`\  :       ,'_ /:         .   :  ;. /  
echo    /   /  ' /:   : :  '  :  .--. :  : :     .--,.   ; /--`   
echo   :   :     ::   ' '  ;  :,'_ /: :  . :   /_ ./:;   : ;  __  
echo   :   : .\  .'   : ;  .  ::  ' : :  . ., ' , ' ::   : :.' .' 
echo   .   ; ';  ::   : :  :  ':  : ' :  : /___/ \: :.   : '_.' : 
echo   '   .   . :'   : : /  ; :  : : ;  ; :.  \  ' :'   ; : \  : 
echo    `---`-': ::   : '` ,/  '  :  `--'   \\  ;   :'   : '/  .' 
echo    .'__/\_: :;   :  .'    :  ,      .-./ \  \  ;:   :    /   
echo    :   :    ::   ,.'       `--`----'      :  \  \\   \ .'    
echo     \   \  / '---'                         \  ' ; `---`      
echo      `--`-'                                 `--`             
echo.
echo ____________________________________________________________________
echo.
echo    1. Crear usuarios
echo    2. Eliminar usuarios
echo    3. Crear usuarios en su grupo de turnos SIN asignar a usuarios
echo    4. Crear grupos de turnos asignado a usuarios PREVIAMENTE creados
echo    5. Eliminar los grupos de turnos
echo    6. Mostrar usuarios y grupos
echo    7. Ayuda
echo    8. Salir
echo ____________________________________________________________________
echo.
echo.
rem parametros opcionales choice - countdown /T:10 opcion por defecto /D:3
choice /M "Seleccione una opcion: " /C:12345678

if errorlevel 8 goto salir
if errorlevel 7 goto ayuda
if errorlevel 6 goto mostrar
if errorlevel 5 goto eliminar_grupos_turnos
if errorlevel 4 goto crear_grupos_asignado_usuarios
if errorlevel 3 goto crear_usuarios_grupos_sinasignar
if errorlevel 2 goto eliminar_usuarios
if errorlevel 1 goto crear_usuarios

:crear_usuarios
cls
setlocal enabledelayedexpansion
rem creando usuarios, condicionando su cargo y turno horario

rem comprobamos antes de crear los usuarios si el fichero passwords_usuarios.txt existe, si existe lo borramos.
if exist passwords_usuarios.txt del passwords_usuarios.txt

for /f "eol=# delims=; tokens=1-5" %%i in (empleados.txt) do (
	set apellido1=%%i
	set apellido2=%%j
	set nombre=%%k
	set cargo=%%l
	set turno=%%m
	set login=!nombre!!apellido1:~0,1!!apellido2:~0,1!
	set passw=!nombre!!apellido1:~0,2!!apellido2:~0,2!
	set "manana=7:00 a 15:00"
	set "tarde=15:00 a 23:00"
	set "administrativo=Administrativo"
	set "jefedepartamento=Jefe Departamento"

	if "!cargo!" == "!administrativo!" (
		if "!turno!" == "!manana!" net user !login! !passw! /y /times:L-V,7AM-3PM /logonpasswordchg:yes /fullname:"!nombre! !apellido1! !apellido2!" /add
		if "!turno!" == "!tarde!" net user !login! !passw! /y /times:L-V,3PM-11PM /logonpasswordchg:yes /fullname:"!nombre! !apellido1! !apellido2!" /add
	) else (
		if "!cargo!" == "!jefedepartamento!" net user !login! !passw! /y /times:L-V,7AM-11PM /logonpasswordchg:yes /fullname:"!nombre! !apellido1! !apellido2!" /add
	)
	echo La password de !login! es !passw! >> passwords_usuarios.txt
)
rem findstr /R "^La contrase" tpass.tmp >> passwords_usuarios.txt
cls
echo.
echo ______ USUARIOS LOCALES de %computername% CREADOS ______
echo.
pause
goto mostrar

:eliminar_usuarios
cls
setlocal enabledelayedexpansion

rem comprobamos antes de crear los usuarios si el fichero passwords_usuarios.txt existe, si existe lo borramos.
if exist passwords_usuarios.txt del passwords_usuarios.txt

rem eliminando usuarios locales
for /f "eol=# delims=; tokens=1-5" %%i in (empleados.txt) do (
	set apellido1=%%i
	set apellido2=%%j
	set nombre=%%k
	set login=!nombre!!apellido1:~0,1!!apellido2:~0,1!
	net user !login! /delete
	echo !login!
)
echo.
echo ______ USUARIOS LOCALES de %computername% ELIMINADOS ______
echo.
pause
goto mostrar
echo.

rem "crear_usuarios_grupos" es lo mismo que "crear_usuarios" con la diferencia de que a mayores SOLO se crean los grupos de turnos
:crear_usuarios_grupos_sinasignar
cls
setlocal enabledelayedexpansion
rem creando grupos
net localgroup Manana /add
net localgroup Tarde /add

rem como los "Jefes" deben ser administradores locales, se añade el grupo de Jefes al grupo de administradores locales, de ese modo, 
rem si en un futuro se incorpora más personal a la empresa en el departamento de Jefes, no tiene por que añadirse directamente ese 
rem usuario al grupo administradores y solamente meterlo en el grupo Jefes que ya está incluído en el grupo administradores.
net localgroup Jefes /add
net localgroup "Administradores" "Jefes" /add

rem comprobamos antes de crear los usuarios si el fichero passwords_usuarios.txt existe, si existe lo borramos.
if exist passwords_usuarios.txt del passwords_usuarios.txt

rem creando usuarios con sus caracteristicas de cambiar la password en el proximo inicio de sesión y 
rem el turno disponible para iniciar sesión en el sistema.
for /f "eol=# delims=; tokens=1-5" %%i in (empleados.txt) do (
	set apellido1=%%i
	set apellido2=%%j
	set nombre=%%k
	set cargo=%%l
	set turno=%%m
	set login=!nombre!!apellido1:~0,1!!apellido2:~0,1!
	set passw=!nombre!!apellido1:~0,2!!apellido2:~0,2!
	set "manana=7:00 a 15:00"
	set "tarde=15:00 a 23:00"
	set "administrativo=Administrativo"
	set "jefedepartamento=Jefe Departamento"
	
	if "!cargo!" == "!administrativo!" (
		if "!turno!" == "!manana!" net user !login! !passw! /y /times:L-V,7AM-3PM /logonpasswordchg:yes /fullname:"!nombre! !apellido1! !apellido2!" /add
		if "!turno!" == "!tarde!" net user !login! !passw! /y /times:L-V,3PM-11PM /logonpasswordchg:yes /fullname:"!nombre! !apellido1! !apellido2!" /add
	) else (
		if "!cargo!" == "!jefedepartamento!" net user !login! !passw! /y /times:L-V,7AM-11PM /logonpasswordchg:yes /fullname:"!nombre! !apellido1! !apellido2!" /add
	)
	echo La password de !login! es !passw! >> passwords_usuarios.txt
)
cls
echo.
echo ______ USUARIOS LOCALES de %computername% CREADOS ______
echo.
pause
goto mostrar

rem "crear_grupos_asignado_usuarios" crear los grupos y asigna a los usuarios que previamente ya están creados con "crear_usuarios"
:crear_grupos_asignado_usuarios
cls
setlocal enabledelayedexpansion
rem creando grupos
net localgroup Manana /add
net localgroup Tarde /add

rem como los "Jefes" deben ser administradores locales, se añade el grupo de Jefes al grupo de administradores locales, de ese modo, 
rem si en un futuro se incorpora más personal a la empresa en el departamento de Jefes, no tiene por que añadirse directamente ese 
rem usuario al grupo administradores y solamente meterlo en el grupo Jefes que ya está incluído en el grupo administradores.
net localgroup Jefes /add
net localgroup "Administradores" "Jefes" /add

rem esta es la única parte que cambia en comparación con "crear_usuarios_grupos", esta parte asigna a los usuarios a sus grupos
for /f "eol=# delims=; tokens=1-5" %%i in (empleados.txt) do (
	set apellido1=%%i
	set apellido2=%%j
	set nombre=%%k
	set cargo=%%l
	set turno=%%m
	set login=!nombre!!apellido1:~0,1!!apellido2:~0,1!
	set "manana=7:00 a 15:00"
	set "tarde=15:00 a 23:00"
	set "matarde=7:00 a 23:00"
	
	if "!turno!" equ "!manana!"  (net localgroup "Manana" "!login!" /add)
	if "!turno!" equ "!tarde!"   (net localgroup "Tarde"  "!login!" /add)
	if "!turno!" equ "!matarde!" (net localgroup "Jefes"  "!login!" /add)
)
pause
echo.
echo ______ GRUPOS Y USUARIOS LOCALES de %computername% CREADOS Y ASIGNADOS ______
echo.
pause
goto mostrar

:eliminar_grupos_turnos
cls
rem eliminado grupos locales
net localgroup Manana /delete
net localgroup Tarde /delete
net localgroup Jefes /delete
echo.
echo ______ GRUPOS LOCALES de %computername% ELIMINADOS ______
echo.
pause
goto mostrar
echo.

:mostrar
cls
rem con findstr estilizaremos la salida a un fichero para 
rem visualizarlo mejor en pantalla en el momento de mostrar los usuarios
rem con el parámetro skip= en el for eliminaremos las primeras líneas indicadas del fichero que se le pasa

rem mostrar lista de usuarios locales actuales
net user > usuarios_lista_temp

	for /F "skip=4 delims=" %%i in (usuarios_lista_temp) do (
		echo %%i >> usuarios_lista_temp2
	findstr /v /R "^Se ha completado" usuarios_lista_temp2 > usuarios_lista
	)
del usuarios_lista_temp
del usuarios_lista_temp2
echo.
echo.
echo ______ USUARIOS LOCALES de %computername% ______
echo.
type usuarios_lista
del usuarios_lista

rem mostrar lista de grupos locales actuales
net localgroup > grupos_lista_temp

	for /F "skip=4 delims=" %%i in (grupos_lista_temp) do (
		echo %%i >> grupos_lista_temp2
	findstr /v /R "^Se ha completado" grupos_lista_temp2 > grupos_lista
	)
del grupos_lista_temp
del grupos_lista_temp2
echo.
echo.
echo ______ GRUPOS LOCALES de %computername% ______
echo.
type grupos_lista
del grupos_lista

rem mostrar lista de usuarios del grupo manana
net localgroup manana > grupo_manana_lista_temp

	for /F "skip=6 delims=" %%i in (grupo_manana_lista_temp) do (
		echo %%i >> grupo_manana_lista_temp2
	findstr /v /R "^Se ha completado" grupo_manana_lista_temp2 > grupo_manana_lista
	)
del grupo_manana_lista_temp
del grupo_manana_lista_temp2
echo.
echo.
echo ______ GRUPO LOCAL MANANA de %computername% ______
echo.
type grupo_manana_lista
del grupo_manana_lista

rem mostrar lista de usuarios del grupo tarde
net localgroup tarde > grupo_tarde_lista_temp

	for /F "skip=6 delims=" %%i in (grupo_tarde_lista_temp) do (
		echo %%i >> grupo_tarde_lista_temp2
	findstr /v /R "^Se ha completado" grupo_tarde_lista_temp2 > grupo_tarde_lista
	)
del grupo_tarde_lista_temp
del grupo_tarde_lista_temp2
echo.
echo.
echo ______ GRUPO LOCAL TARDE de %computername% ______
echo.
type grupo_tarde_lista
del grupo_tarde_lista

rem mostrar lista de usuarios del grupo jefes
net localgroup jefes > grupo_jefes_lista_temp

	for /F "skip=6 delims=" %%i in (grupo_jefes_lista_temp) do (
		echo %%i >> grupo_jefes_lista_temp2
	findstr /v /R "^Se ha completado" grupo_jefes_lista_temp2 > grupo_jefes_lista
	)
del grupo_jefes_lista_temp
del grupo_jefes_lista_temp2
echo.
echo.
echo ______ GRUPO LOCAL JEFES de %computername% ______
echo.
type grupo_jefes_lista
del grupo_jefes_lista
echo.
echo.
pause
goto menu

:ayuda
cls
rem mostrar ayuda de gDuyG
type gDuyG_ayuda
echo.
pause
goto menu

:salir
rem salir de gDuyG limpiando pantalla y estableciendo los colores de consola por defecto
color 0F
cls
