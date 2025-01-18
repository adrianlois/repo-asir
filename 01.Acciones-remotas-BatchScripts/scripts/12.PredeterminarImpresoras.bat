@echo off
title Predeterminar impresora por usuario
echo  + Escribir el nombre de impresora a predeterminar en el sistema
echo.
cd c:\Windows\System32\Printing_Admin_Scripts\es-ES
cscript prnmngr.vbs -l | find "Nombre de impresora"
echo.
set /p imp=
RUNDLL32 PRINTUI.DLL,PrintUIEntry /y /n "%impresora%"
echo.
echo Impresora "%impresora%" predeterminada correctamente.
echo.
pause
exit