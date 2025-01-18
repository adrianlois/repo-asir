@echo off
title Listar y finilizar procesos de equipos remotos

echo  + IP o hostname del equipo remoto:
set /p equipo=
echo.
echo  + Usuario administrador local:
set /p usuario=
echo.
echo  + Password administrador local:
set /p passw=
echo.
echo Lista de procesos del equipo %equipo%
echo.
tasklist /s %equipo% /u %dominio%\%usuario% /p %passw%
echo.
echo  + Indica el nombre del proceso a finalizar
echo.
taskkill /s %equipo% /u %dominio%\%usuario% /p %passw% /im explorer.exe
exit