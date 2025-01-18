@echo off
title Cerrar sesiones remotas RDP

:consultar
echo  + Introduce la IP o Nombre del servidor a consultar
echo.
set /p ip=
echo.
qwinsta /server:%ip%
echo.

:cerrarSes
echo  + Introduce el ID de la sesion a cerrar
echo.
set /p id=
echo.
rwinsta /server:%ip% %id% 
pause
echo.
echo Quieres cerrar alguna otra sesion?: s/n
set /p resp=
if %resp%==s (goto cerrarSes) else (goto salir)

:salir
exit