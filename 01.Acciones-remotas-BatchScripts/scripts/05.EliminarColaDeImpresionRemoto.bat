@echo off
title Eliminar trabajos de cola de impresión
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
echo  Deteniendo el servicio de impresion remoto de %equipo%... 
psexec \\%equipo% -u %dominio%\%usuario% -p %passw%  net stop spooler

echo  Eliminando cola de documentos de %equipo%...
psexec \\%equipo% -u %dominio%\%usuario% -p %passw% del /F /Q %systemroot%\system32\spool\printers\*.spl
psexec \\%equipo% -u %dominio%\%usuario% -p %passw% del /F /Q %systemroot%\system32\spool\printers\*.shd

echo  Iniciando servicio de impresion...
psexec \\%equipo% -u %dominio%\%usuario% -p %passw% net start spooler
pause
exit