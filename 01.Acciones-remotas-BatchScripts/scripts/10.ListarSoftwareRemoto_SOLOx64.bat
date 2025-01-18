@echo off
title Listar y desinstalar software equipo remoto para arquitecturas x64
echo.
echo  Establecer los datos del equipo remoto.
echo.
echo  + IP o hostname del equipo remoto:
set /p equipo=
echo.
echo  + Dominio o hostname:
set /p dominio=
echo.
echo  + Usuario administrador local o de dominio:
set /p usuario=
echo.
echo  + Password de administrador local o de dominio:
set /p passw=
:menu
cls
echo.
echo  1. Listar software remoto (reg.exe)
echo  2. Listar software remoto (wmic)
echo  3. Desinstalar software remoto (wmic)
echo  4. Salir
echo.
echo Elige una opcion:
set /p opc=
if %opc%==1 goto listarSoftwareReg
if %opc%==2 goto listarSoftwareWMIC
if %opc%==3 goto desinstalarSfotwareRemoto
if %opc%==4 goto salir

:listarSoftwareReg
psexec \\%equipo% -u %dominio%\%usuario% -p %passw% reg query HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall /S | find "DisplayName"
pause
goto menu

:listarSoftwareWMIC
psexec \\%equipo% -u %dominio%\%usuario% -p %passw% wmic product get name,version,vendor
pause
echo.
echo Desinstalar alguno de la lista anterior? s/n
set/p opc=
if %opc%==s goto desinstalar
if %opc%==n goto menu

:desinstalarSfotwareRemoto
echo  + Nombre exacto del software que deseas desinstalar?
set /p software=
psexec \\%equipo% -u %dominio%\%usuario% -p %passw% wmic product where name="%software%" call uninstall
echo.
echo Seguir desinstalando otro software? s/n
set/p opc=
if %opc%==s goto desinstalar
if %opc%==n goto menu

:salir
exit