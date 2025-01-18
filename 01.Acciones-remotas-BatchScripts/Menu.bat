@echo off
title Acciones en equipos remotos
echo.
echo  -- Establecer los datos del equipo remoto --
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

:menu
cls
echo.
echo  Acciones en equipos remotos de una misma red de dominio
echo.
echo  ------------------------------------------
echo    1.  Ejecutar CMD Remota
echo    2.  Listar software remoto (reg.exe)
echo    3.  Listar software remoto (wmic)
echo    4.  Desinstalar software remoto (wmic)
echo    5.  Eliminar trabajos de impresión
echo    6.  Cambiar configuración de red IP
echo    7.  Listar y finalizar procesos
echo    8.  Consultar sesiones remotas RDP
echo    9.  Cerrar sesiones remotas RDP
echo    10. Detener y deshabilitar servicios
echo    11. Iniciar y habilitar servicios
echo    12. Envío de Mensajes (msg)
echo    13. Información equipo
echo    14. Predeterminar impresoras
echo    15. Reparar MDAC (local)
echo    16. Salir
echo  ------------------------------------------
echo.
echo Elige una opcion:
set /p opc=
if %opc%==1 goto ejecutarCMDRemoto
if %opc%==2 goto listarSoftwareReg
if %opc%==3 goto listarSoftwareWmic
if %opc%==4 goto desinstalarSfotwareRemoto
if %opc%==5 goto eliminarColaImpresionRemoto
if %opc%==6 goto cambiarIPEquipoRemoto
if %opc%==7 goto listarFinalizarProcesosRemoto
if %opc%==8 goto consulstarSessionesRemoto
if %opc%==9 goto cerrarSesionRemoto
if %opc%==10 goto detenerDeshabilitarServiciosRemoto
if %opc%==11 goto iniciarHabilitarServiciosRemoto
if %opc%==12 goto msgRemoto
if %opc%==13 goto infoRemoto
if %opc%==14 goto predeterminarImpresoraRemoto
if %opc%==15 goto repararMDAC
if %opc%==16 goto salir

:ejecutarCMDRemoto
psexec \\%equipo% -u %dominio%\%usuario% -p %passw% -s cmd.exe
echo.
goto menu

:listarSoftwareReg
psexec \\%equipo% -u %dominio%\%usuario% -p %passw% reg query HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall /S | find "DisplayName"
pause
goto menu

:listarSoftwareWmic
psexec \\%equipo% -u %dominio%\%usuario% -p %passw% wmic product get name,version,vendor
pause
echo.
goto menu

:desinstalarSfotwareRemoto
echo  + Nombre exacto del software que deseas desinstalar?
set /p software=
psexec \\%equipo% -u %dominio%\%usuario% -p %passw% wmic product where name="%software%" call uninstall
echo.
pause
goto menu

:eliminarColaImpresionRemoto
echo.
echo  Deteniendo el servicio de impresion remoto de %equipo%... 
psexec \\%equipo% -u %dominio%\%usuario% -p %passw%  net stop spooler
echo  Eliminando cola de documentos de %equipo%...
psexec \\%equipo% -u %dominio%\%usuario% -p %passw% del /F /Q %systemroot%\system32\spool\printers\*.spl
psexec \\%equipo% -u %dominio%\%usuario% -p %passw% del /F /Q %systemroot%\system32\spool\printers\*.shd
echo  Iniciando servicio de impresion...
psexec \\%equipo% -u %dominio%\%usuario% -p %passw% net start spooler
pause
goto menu

:cambiarIPEquipoRemoto
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
psexec \\%ipremota% -u %dominio%\%usuario% -p %passw% -s netsh interface ip set address name="%interfaz%" source=static %ipnueva% %mascara% %gateway% 1
psexec \\%ipremota% -u %dominio%\%usuario% -p %passw% -s netsh interface ipv4 set dnsservers name="%interfaz%" static %dns1% primary
psexec \\%ipremota% -u %dominio%\%usuario% -p %passw% -s netsh interface ipv4 add dnsservers name="%interfaz%" address=%dns2% index=2
pause
goto menu

:listarFinalizarProcesosRemoto
echo Lista de procesos del equipo %equipo%
echo.
tasklist /s %equipo% /u %dominio%\%usuario% /p %passw%
echo.
echo  + Indica el nombre del proceso a finalizar
echo.
taskkill /s %equipo% /u %dominio%\%usuario% /p %passw% /im explorer.exe
pause
goto menu

:consulstarSessionesRemoto
echo  + Introduce la IP o Nombre del servidor a consultar
echo.
set /p ip=
echo.
qwinsta /server:%ip%
echo.
pause
goto menu

:cerrarSesionRemoto
echo  + Introduce el ID de la sesion a cerrar o finalizar
echo.
set /p id=
echo.
rwinsta /server:%ip% %id% 
echo.
pause
goto menu

:detenerDeshabilitarServiciosRemoto
echo  + Introduce el nombre del servicio a detener y deshabilitar en el equipo remoto (ej. firewall: mpssvc):
set /p srv=
echo.
psexec \\%equipo% -u %dominio%\%usuario% -p %passw% -s sc stop %srv% | sc config %srv% start= disabled
echo.
pause
goto menu

:iniciarHabilitarServiciosRemoto
echo  + Introduce el nombre del servicio a iniciar y habilitar en el equipo remoto (ej. firewall: mpssvc):
set /p srv=
echo.
psexec \\%equipo% -u %dominio%\%usuario% -p %passw% -s sc start %srv% | sc config %srv% start= auto
echo.
pause
goto menu

:msgRemoto
echo  + Equipo remoto:
set /p equipo=
echo.
echo  + Mensaje a enviar:
set /p mensaje=
echo.
psexec \\%equipo% msg * %mensaje%
echo.
pause
goto menu

:infoRemoto
echo  + Escribe el hostname del equipo remoto:
set /p equipo=
echo.
systeminfo /s %equipo% | findstr "Nombre Modelo based total"
wmic bios get serialnumber
echo.
pause
goto menu

:predeterminarImpresoraRemoto
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
goto menu

:repararMDAC
@echo off

regsvr32 msjet40.dll /s
regsvr32 msjtes40.dll /i /s
regsvr32 msjetoledb40.dll /s
regsvr32 mswstr10.dll /s
regsvr32 msjint40.dll /s
regsvr32 msjter40.dll /s
regsvr32 MSJINT35.DLL /s
regsvr32 MSJET35.DLL /s
regsvr32 MSJT4JLT.DLL /s
regsvr32 MSJTER35.DLL /s

regsvr32 "%CommonProgramFiles%\Microsoft Shared\DAO\DAO350.DLL" /s
regsvr32 "%CommonProgramFiles%\Microsoft Shared\DAO\dao360.dll" /s
regsvr32 "%CommonProgramFiles%\System\ado\msader15.dll" /s
regsvr32 "%CommonProgramFiles%\System\ado\msado15.dll" /s
regsvr32 "%CommonProgramFiles%\System\ado\msadomd.dll" /s
regsvr32 "%CommonProgramFiles%\System\ado\msador15.dll" /s
regsvr32 "%CommonProgramFiles%\System\ado\msadox.dll" /s
regsvr32 "%CommonProgramFiles%\System\ado\msadrh15.dll" /s
regsvr32 "%CommonProgramFiles%\System\ado\msjro.dll" /s
regsvr32 "%CommonProgramFiles%\System\msadc\msadce.dll" /s
regsvr32 "%CommonProgramFiles%\System\msadc\msadcer.dll" /s
regsvr32 "%CommonProgramFiles%\System\msadc\msadcf.dll" /s
regsvr32 "%CommonProgramFiles%\System\msadc\msadcfr.dll" /s
regsvr32 "%CommonProgramFiles%\System\msadc\msadco.dll" /s
regsvr32 "%CommonProgramFiles%\System\msadc\msadcor.dll" /s
regsvr32 "%CommonProgramFiles%\System\msadc\msadcs.dll" /s
regsvr32 "%CommonProgramFiles%\System\msadc\msadds.dll" /s
regsvr32 "%CommonProgramFiles%\System\msadc\msaddsr.dll" /s
regsvr32 "%CommonProgramFiles%\System\msadc\msdaprst.dll" /s
regsvr32 "%CommonProgramFiles%\System\msadc\msdarem.dll" /s
regsvr32 "%CommonProgramFiles%\System\msadc\msdaremr.dll" /s
regsvr32 "%CommonProgramFiles%\System\msadc\msdfmap.dll" /s
regsvr32 "%CommonProgramFiles%\System\Ole DB\msdadc.dll" /s
regsvr32 "%CommonProgramFiles%\System\Ole DB\msdaenum.dll" /s
regsvr32 "%CommonProgramFiles%\System\Ole DB\msdaer.dll" /s
regsvr32 "%CommonProgramFiles%\System\Ole DB\MSDAERR.DLL" /s
regsvr32 "%CommonProgramFiles%\System\Ole DB\MSDAIPP.DLL" /s
regsvr32 "%CommonProgramFiles%\System\Ole DB\msdaora.dll" /s
regsvr32 "%CommonProgramFiles%\System\Ole DB\msdaorar.dll" /s
regsvr32 "%CommonProgramFiles%\System\Ole DB\msdaosp.dll" /s
regsvr32 "%CommonProgramFiles%\System\Ole DB\MSDAPML.DLL" /s
regsvr32 "%CommonProgramFiles%\System\Ole DB\msdaps.dll" /s
regsvr32 "%CommonProgramFiles%\System\Ole DB\msdasc.dll" /s
regsvr32 "%CommonProgramFiles%\System\Ole DB\msdasql.dll" /s
regsvr32 "%CommonProgramFiles%\System\Ole DB\msdasqlr.dll" /s
regsvr32 "%CommonProgramFiles%\System\Ole DB\MSDATL2.DLL" /s
regsvr32 "%CommonProgramFiles%\System\Ole DB\msdatl3.dll" /s
regsvr32 "%CommonProgramFiles%\System\Ole DB\msdatt.dll" /s
regsvr32 "%CommonProgramFiles%\System\Ole DB\msdaurl.dll" /s
regsvr32 "%CommonProgramFiles%\System\Ole DB\MSDMENG.DLL" /s
regsvr32 "%CommonProgramFiles%\System\Ole DB\MSDMINE.DLL" /s
regsvr32 "%CommonProgramFiles%\System\Ole DB\MSJTOR35.DLL" /s
regsvr32 "%CommonProgramFiles%\System\Ole DB\MSMDCB80.DLL" /s
regsvr32 "%CommonProgramFiles%\System\Ole DB\MSMDGD80.DLL" /s
regsvr32 "%CommonProgramFiles%\System\Ole DB\MSMDUN80.DLL" /s
regsvr32 "%CommonProgramFiles%\System\Ole DB\MSOLAP80.DLL" /s
regsvr32 "%CommonProgramFiles%\System\Ole DB\MSOLUI80.DLL" /s
regsvr32 "%CommonProgramFiles%\System\Ole DB\msxactps.dll" /s
regsvr32 "%CommonProgramFiles%\System\Ole DB\oledb32.dll" /s
regsvr32 "%CommonProgramFiles%\System\Ole DB\oledb32r.dll" /s
regsvr32 "%CommonProgramFiles%\System\Ole DB\OLEDB32X.DLL" /s
regsvr32 "%CommonProgramFiles%\System\Ole DB\sqloledb.dll" /s
regsvr32 "%CommonProgramFiles%\System\Ole DB\sqlxmlx.dll" /s

IF NOT EXIST %systemroot%\SysWoW64\regsvr32.exe goto menu

%systemroot%\SysWoW64\regsvr32.exe msjet40.dll /s
%systemroot%\SysWoW64\regsvr32.exe msjtes40.dll /i /s
%systemroot%\SysWoW64\regsvr32.exe msjetoledb40.dll /s
%systemroot%\SysWoW64\regsvr32.exe mswstr10.dll /s
%systemroot%\SysWoW64\regsvr32.exe msjint40.dll /s
%systemroot%\SysWoW64\regsvr32.exe msjter40.dll /s
%systemroot%\SysWoW64\regsvr32.exe MSJINT35.DLL /s
%systemroot%\SysWoW64\regsvr32.exe MSJET35.DLL /s
%systemroot%\SysWoW64\regsvr32.exe MSJT4JLT.DLL /s
%systemroot%\SysWoW64\regsvr32.exe MSJTER35.DLL /s

%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\Microsoft Shared\DAO\DAO350.DLL" /s
%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\Microsoft Shared\DAO\dao360.dll" /s
%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\System\ado\msader15.dll" /s
%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\System\ado\msado15.dll" /s
%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\System\ado\msadomd.dll" /s
%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\System\ado\msador15.dll" /s
%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\System\ado\msadox.dll" /s
%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\System\ado\msadrh15.dll" /s
%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\System\ado\msjro.dll" /s
%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\System\msadc\msadce.dll" /s
%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\System\msadc\msadcer.dll" /s
%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\System\msadc\msadcf.dll" /s
%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\System\msadc\msadcfr.dll" /s
%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\System\msadc\msadco.dll" /s
%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\System\msadc\msadcor.dll" /s
%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\System\msadc\msadcs.dll" /s
%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\System\msadc\msadds.dll" /s
%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\System\msadc\msaddsr.dll" /s
%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\System\msadc\msdaprst.dll" /s
%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\System\msadc\msdarem.dll" /s
%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\System\msadc\msdaremr.dll" /s
%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\System\msadc\msdfmap.dll" /s
%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\System\Ole DB\msdadc.dll" /s
%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\System\Ole DB\msdaenum.dll" /s
%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\System\Ole DB\msdaer.dll" /s
%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\System\Ole DB\MSDAERR.DLL" /s
%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\System\Ole DB\MSDAIPP.DLL" /s
%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\System\Ole DB\msdaora.dll" /s
%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\System\Ole DB\msdaorar.dll" /s
%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\System\Ole DB\msdaosp.dll" /s
%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\System\Ole DB\MSDAPML.DLL" /s
%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\System\Ole DB\msdaps.dll" /s
%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\System\Ole DB\msdasc.dll" /s
%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\System\Ole DB\msdasql.dll" /s
%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\System\Ole DB\msdasqlr.dll" /s
%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\System\Ole DB\MSDATL2.DLL" /s
%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\System\Ole DB\msdatl3.dll" /s
%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\System\Ole DB\msdatt.dll" /s
%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\System\Ole DB\msdaurl.dll" /s
%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\System\Ole DB\MSDMENG.DLL" /s
%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\System\Ole DB\MSDMINE.DLL" /s
%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\System\Ole DB\MSJTOR35.DLL" /s
%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\System\Ole DB\MSMDCB80.DLL" /s
%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\System\Ole DB\MSMDGD80.DLL" /s
%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\System\Ole DB\MSMDUN80.DLL" /s
%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\System\Ole DB\MSOLAP80.DLL" /s
%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\System\Ole DB\MSOLUI80.DLL" /s
%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\System\Ole DB\msxactps.dll" /s
%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\System\Ole DB\oledb32.dll" /s
%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\System\Ole DB\oledb32r.dll" /s
%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\System\Ole DB\OLEDB32X.DLL" /s
%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\System\Ole DB\sqloledb.dll" /s
%systemroot%\SysWoW64\regsvr32.exe "%CommonProgramFiles(x86)%\System\Ole DB\sqlxmlx.dll" /s
goto menu

:salir