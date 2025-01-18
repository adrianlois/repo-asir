@echo off
title Detener y deshabilitar servicios remotos
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
echo  + Introduce el nombre del servicio a detener y deshabilitar en el equipo remoto (ej. firewall: mpssvc):
set /p srv=
echo.
psexec \\%equipoRemoto% -u %dominio%\%usuario% -p %passw% -s sc start %srv% | sc config %srv% start= auto
pause