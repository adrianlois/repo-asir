@echo off
title Administracion de recursos compartidos y cuotas
rem Ejercicios ASIR - IMSO
cls
rem --------------
rem CREAR USUARIOS
rem --------------
net user wadmin abc123. /add
net localgroup administradores wadmin /add
net user wuser01 abc123. /add
net user wuser02 abc123. /add
net user wservidor abc123. /add
net user wremoto abc123. /add

rem -----------------
rem CREAR DIRECTORIOS
rem -----------------
mkdir c:\compServidor
mkdir c:\compWuser01
mkdir c:\compWuser02
mkdir c:\compAsistencia
rem Ocultar la carpeta c:\compAsistencia
attrib +H c:\compAsistencia

rem ------------------
rem COMPARTIR CARPETAS
rem ------------------
rem Ayuda: recursoCompartido=unidad:ruta [/GRANT:usuario,[READ | CHANGE | FULL]]
net share compServidor=c:\compServidor /cache:programs /grant:wservidor,FULL /grant:wadmin,FULLL
net share compWuser01=c:\compWuser01 /cache:programs /grant:wuser01,FULL /grant:wadmin,FULLL
net share compWuser02=c:\compWuser02 /cache:programs /grant:wuser02,FULL /grant:wadmin,FULLL
net share compAsistencia=c:\compAsistencia /cache:programs /grant:wremoto,FULL /grant:wadmin,FULLL
rem la única diferencia entre /cache:automatic a /cache:programs es que esta última se "optimiza para rendimiento"

rem ------------------------------------------------
rem CONFIGURACIÓN ESCRITORIO PARA EL USUARIO WREMOTO
rem ------------------------------------------------
rem Habilitar terminal server en modo de conexión segura
reg add "HKLM\SYSTEM\ControlSet001\Control\Terminal Server\WinStations\RDP-Tcp" /v UserAuthentication /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f

rem añadir al grupo de terminal server el usuario wremoto
net localgroup "Usuarios de escritorio remoto" wremoto /add

rem añadir regla de entrada en el firewall para permitir accesos RDP por el puerto lógico 3389
netsh advfirewall firewall add rule name="RDP_3389" dir=in action=allow protocol=TCP localport=3389

rem ---------------------------------------------------
rem ESTABLECER PERMISOS NTFS A LAS CARPETAS COMPARTIDAS
rem ---------------------------------------------------
rem /inheritance:r quita todas las ACE heredadas
rem (OI)(CI) los permisos lo tomará la carpeta y lo herederon las subcarpetas y archivos
rem (R,W) permisos de lectura y escritura
icacls c:\compServidor /inheritance:r /grant wservidor:(OI)(CI)(R,W) /grant wadmin:(OI)(CI)(F)
icacls c:\compWuser01 /inheritance:r /grant wuser01:(OI)(CI)(M) /grant wadmin:(OI)(CI)(F)
icacls c:\compWuser02 /inheritance:r /grant wuser02:(OI)(CI)(M) /grant wadmin:(OI)(CI)(F)
icacls c:\compAsistencia /inheritance:r /grant wremoto:(OI)(CI)(R,W) /grant wadmin:(OI)(CI)(F)

rem ---------------------
rem ESTABLECER LAS CUOTAS
rem ---------------------
rem enforce, habilitamos las cuotas para la unidad c:
fsutil quota enforce c:

rem la primera cuota será la soft -avisa pero deja seguir almacenando hasta que se llega a la cuota hard- y la siguiente la hard
rem cuota wadmin: 25GB (soft 22GB)
fsutil quota modify c: 23622320128 26843545600 wadmin

rem cuota wuser01: 10GB  (soft 7GB)
fsutil quota modify c: 10737418240 10737418240 wuser01

rem cuota wuser02: 10GB (soft 7GB)
fsutil quota modify c: 10737418240 10737418240 wuser02

rem cuota wservidor: 1GB (soft 700MB)
fsutil quota modify c: 734003200 1073741824 wservidor

rem cuota wremoto: 1GB (soft 700MB)
fsutil quota modify c: 734003200 1073741824 wremoto