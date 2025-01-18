@echo off
title Ejecutar CMD remota
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
echo.
psexec \\%equipo% -u %dominio%\%usuario% -p %passw% -s cmd.exe