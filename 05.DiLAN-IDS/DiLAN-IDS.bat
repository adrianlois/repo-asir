@echo off
:menu
del fichero*.tmp
cls
title DiLAN - v1.0 (2010)
color 0A
echo.
echo  _____ _____ _               _   _      _____ _____   _____ 
echo |  __ \_   _| |        /\   | \ | |    |_   _|  __ \ / ____|
echo | |  | || | | |       /  \  |  \| |______| | | |  | | (___  
echo | |  | || | | |      / /\ \ | . ` |______| | | |  | |\___ \ 
echo | |__| || |_| |____ / ____ \| |\  |     _| |_| |__| |____) |
echo |_____/_____|______/_/    \_\_| \_|    |_____|_____/|_____/
echo.
echo Para poder ejecutar ciertas funciones de esta aplicacion
echo necesita ejecutar DiLAN como Administrador
echo.
echo [+] El nombre de su equipo es: [ %computername% ]
echo [+] Su usuario actual es: [ %username% ]
echo.
echo ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
echo ºÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»º
echo ºº          DiLAN - v1.0 (2010)              ºº
echo ºº   Deteccion de Intrusos de Red Local      ºº
echo ºÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼º
echo ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
echo.
echo    1. Escanear toda la red de clase C (1-254)
echo    2. Escanear un rago determinado de clase C
echo    3. Consulta address MAC de la tabla ARP
echo    4. Consulta una direccion IP determinada
echo    5. Consulta NETSTAT
echo    6. ¿Qué es DiLAN?
echo    7. Salir
echo.
echo Pulse el numero correspondiente para la accion requerida:
set /p opc=
if %opc%==1 goto scantotal
if %opc%==2 goto scanrango
if %opc%==3 goto arp
if %opc%==4 goto ping
if %opc%==5 goto netstat
if %opc%==6 goto queesdilan
if %opc%==7 goto salir

:si
goto menu
:no
del fichero.tmp
exit

:scantotal
cls
echo ============================
echo Escaneo de toda la Red local
echo ============================
echo ( Para volver al Menu principal, escriba: salir )
echo.
echo Introduzca los 3 primeros octetos de la IP
echo (Ejemplo: 172.16.1)
set /p ip=
if %ip%==salir goto menu
cls
echo -----------------------------------------------
echo [Escaneando toda la Red de area local (%ip%)]
echo -----------------------------------------------
echo Por favor espere un momento...
echo.
FOR /L %%a IN (1,1,254) DO (
echo [ ESCANEANDO IP %%a de 254 ] - [%ip%.%%a]
ping -w 50 -n 1 %ip%.%%a | find "Respuesta" && @ECHO IP Conectada --- [%ip%.%%a] >> fichero1.tmp
ping -w 50 -n 1 %ip%.%%a | find "agotado" && @ECHO IP Sin Respuesta --- [%ip%.%%a] >>fichero2.tmp
)
cls
if exist fichero*.tmp (
echo ----------------------------
echo [OK] IPS listadas con Exito!
echo ----------------------------
echo.
echo ++++++++++++++++++++
echo ++ IPs Conectadas ++
echo ++++++++++++++++++++
echo.
type fichero1.tmp
echo.
echo _________________________________________________________
echo.
echo +++++++++++++++++++++++
echo ++ IPs Sin Respuesta ++
echo +++++++++++++++++++++++
echo.
type fichero2.tmp
del fichero*.tmp
) else (
echo --------------------------
echo [ERROR] IPs No encontradas
echo --------------------------
echo.
echo Intentelo de nuevo o vuelva a introducir una direccion IP valida
del fichero*.tmp
)
echo.
echo _________________________________________________________
echo.
echo    1. Volver a escanear toda la red local
echo    2. Volver al Menu principal
echo.
echo Pulse el numero correspondiente para la accion requerida:
set/p opc=
if %opc%==1 goto scantotal
if %opc%==2 goto menu

:scanrango
cls
echo ---------------------------------
echo Introduce un rango de IP clase C
echo ---------------------------------
echo ( Para volver al Menu principal, escriba: salir )
echo.
echo Introduzca los 3 primeros octetos de la IP
echo (Ejemplo: 172.16.1)
set /p ip=
if %ip%==salir goto menu
echo.
echo Desde [MAX. 254]
set /p r=
if %r%==salir goto menu
echo Desde %r%, hasta:
set /p h=
if %h%==salir goto menu
cls
echo.
echo -------------------------------------------------------------------
echo [Escaneando rango de IPs: Desde %r% hasta %h% de la red (%ip%.0)]
echo -------------------------------------------------------------------
echo Por favor espere un momento...
echo.
FOR /L %%a IN (%r%,1,%h%) DO (
echo [ ESCANEANDO IP %%a de %h% ] - [%ip%.%%a]
ping -w 50 -n 1 %ip%.%%a | find "Respuesta" && @ECHO IP Conectada --- [%ip%.%%a] >> fichero1.tmp
ping -w 50 -n 1 %ip%.%%a | find "agotado" && @ECHO IP Sin Respuesta --- [%ip%.%%a] >>fichero2.tmp
)
cls
if exist fichero*.tmp (
echo ----------------------------
echo [OK] IPs listadas con Exito!
echo ----------------------------
echo.
echo ++++++++++++++++++++
echo ++ IPs Conectadas ++
echo ++++++++++++++++++++
echo.
type fichero1.tmp
echo.
echo _________________________________________________________
echo.
echo +++++++++++++++++++++++
echo ++ IPs Sin Respuesta ++
echo +++++++++++++++++++++++
echo.
type fichero2.tmp
del fichero*.tmp
) else (
echo --------------------------
echo [ERROR] IPs No encontradas
echo --------------------------
echo.
echo Intentelo de nuevo o vuelva a introducir una IP valida
del fichero*.tmp
)
echo.
echo _________________________________________________________
echo.
echo    1. Volver a escanear otro rango
echo    2. Volver al Menu principal
echo.
echo Pulse el numero correspondiente para la accion requerida:
set/p opc=
if %opc%==1 goto scanrango
if %opc%==2 goto menu

:arp
cls
echo ====================
echo Menu de la tabla ARP
echo ====================
echo    1. Consultar tabla ARP
echo    2. Borrar todos los host asociados a la tabla ARP actual
echo    3. Volver al Menu principal
echo.
echo Pulse el numero correspondiente para la accion requerida:
set/p opc=
if %opc%==1 goto arpactu
if %opc%==2 goto arpborra
if %opc%==3 goto menu
:arpactu
cls
echo --------------------------
echo Mostrando tabla ARP actual
echo --------------------------
arp -a
echo _________________________________________________________
echo.
echo    1. Volver al Menu ARP
echo    2. Volver al Menu principal
echo.
echo Pulse el numero correspondiente para la accion requerida:
set/p opc=
if %opc%==1 goto arp
if %opc%==2 goto menu
:arpborra
cls
echo --------------------
echo Borrado de tabla ARP
echo --------------------
arp -d *
echo _________________________________________________________
echo.
echo    1. Volver al Menu ARP
echo    2. Volver al Menu principal
echo.
echo Pulse el numero correspondiente para la accion requerida:
set/p opc=
if %opc%==1 goto arp
if %opc%==2 goto menu

:netstat
cls
echo =============
echo Menu NETSTAT
echo =============
echo.
echo    1. Muestra detallada NETSTAT
echo    2. Especifique un protocolo a mostrar en NETSTAT
echo    3. Volver al Menu principal
set/p opc=
if %opc%==1 goto detalladanetstat
if %opc%==2 goto protonetstat
if %opc%==3 goto menu
:detalladanetstat
cls
netstat -noab
echo _________________________________________________________
netstat -r
echo _________________________________________________________
netstat -s
echo _________________________________________________________
echo.
echo    1. Volver al Menu NETSTAT
echo    2. Volver al Menu principal
echo.
echo Pulse el numero correspondiente para la accion requerida:
set/p opc=
if %opc%==1 goto netstat
if %opc%==2 goto menu
:protonetstat
cls
echo ---------------------------------
echo Analizar un protocolo determinado 
echo ---------------------------------
echo ( Para volver al Menu principal, escriba: salir )
echo.
echo Especifique un protocolo a anlizar:
echo (Ejemplo: TCP, UDP, TCPv6 o UDPv6)
set/p proto=
if %proto%==salir goto menu
if %proto%==%proto% goto protonetstatmostrar
:protonetstatmostrar
netstat -a -p %proto%
echo _________________________________________________________
echo.
echo    1. Volver a analizar un protocolo con NETSTAT
echo    2. Volver al Menu NETSTAT
echo    3. Volver al Menu principal
echo.
echo Pulse el numero correspondiente para la accion requerida:
set/p opc=
if %opc%==1 goto protonetstat
if %opc%==2 goto netstat
if %opc%==3 goto menu

:ping
cls
echo ======================================================
echo Consultar la respuesta de una direccion IP determinada
echo ======================================================
echo ( Para volver al Menu principal, escriba: salir )
echo.
echo Si la IP introducida, no muestra nada en pantalla, 
echo significa que no esta respondiendo a la solicitud de echo ICMP, ping.
echo.
echo Introduzca la direccion IP a consultar:
set/p pingip=
echo.
if %pingip%==salir goto menu
ping %pingip% | find "TTL" && @ECHO   +++++ { La IP [%pingip%] Responde al Ping } +++++
echo _________________________________________________________
echo.
echo    1. Volver a consultar una IP determinada
echo    2. Volver al Menu principal
echo.
echo Pulse el numero correspondiente para la accion requerida:
set/p opc=
if %opc%==1 goto ping
if %opc%==2 goto menu

:queesdilan
cls
echo.
echo [ ¿ Que es DiLAN ? ]
echo --------------------
echo DiLAN (Detection Intrusion Local Area Network) es una herramienta 
echo para escanear y consultar las IPs activas de una red de área local
echo.
echo  +-------------------+
echo  + DiLAN v1.0 - 2011 +
echo  +-------------------+
echo.
echo Deseas volver al Menu principal? (S/N)
set/p var=
if %var%==s goto si
if %var%==n goto no

:salir
del fichero*.tmp
exit
