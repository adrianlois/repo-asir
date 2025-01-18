@echo off
title Cambiar configuración de red en equipo remoto
echo.
echo  + Introduce la IP del equipo Remoto:
set /p ipremota=
echo.
echo  + Introduce la nueva IP a establecer:
set /p ipnueva=
echo.
echo  + Introduce la mascara correspondiente:
set /p mascara=
echo.
echo  + Introduce la Gateway correspondiente:
set /p gateway=
echo.
echo  + Introduce la DNS primaria:
set /p dns1=
echo.
echo  + Introduce la DNS alternativa:
set /p dns2=
echo.
echo  + Introduce el nombre de la interfaz: Ej: Conexión de área local o Ethernet
set /p interfaz=
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
psexec \\%ipremota% -u %dominio%\%usuario% -p %passw% -s netsh interface ip set address name="%interfaz%" source=static %ipnueva% %mascara% %gateway% 1
psexec \\%ipremota% -u %dominio%\%usuario% -p %passw% -s netsh interface ipv4 set dnsservers name="%interfaz%" static %dns1% primary
psexec \\%ipremota% -u %dominio%\%usuario% -p %passw% -s netsh interface ipv4 add dnsservers name="%interfaz%" address=%dns2% index=2
pause
exit