@echo off
color 3F
title Network Config
rem Ejercicios ASIR - IMSO
rem Se comprueba si se pasa o no un fichero de configuracion como parametro
if "%1" == "" (goto menu) else (goto config_automatic_network)

:menu
cls
rem banner menu principal
echo.
echo    _   _      _                      _     
echo   : \ : :    : :                    : :    
echo   :  \: : ___: :___      _____  _ __: : __ 
echo   : . ` :/ _ \ __\ \ /\ / / _ \: '__: :/ / 
echo   : :\  :  __/ :_ \ V  V / (_) : :  :   :  
echo   :_: \_:\___:\__: \_/\_/ \___/:_:_ :_:\_\ 
echo             / ____:           / _(_)       
echo            : :     ___  _ __ : :_ _  __ _  
echo            : :    / _ \: '_ \:  _: :/ _` : 
echo            : :___: (_) : : : : : : : (_: : 
echo             \_____\___/:_: :_:_: :_:\__, : 
echo                                      __/ : 
echo                                     :___/ 
echo.
echo __________________________________
echo.
echo    1. Configuracion IP estatica
echo    2. Configuracion IP dinamica
echo    3. Configuracion DNS
echo    4. Consultar configuraciones
echo    5. Salir
echo __________________________________
echo.

rem parametros opcionales choice - countdown /T:10 opcion por defecto /D:3
choice /M "Seleccione una opcion: " /C:12345

if errorlevel 5 goto salir
if errorlevel 4 goto consultar_config
if errorlevel 3 goto config_dns
if errorlevel 2 goto config_ip_dhcp
if errorlevel 1 goto config_ip_static

:config_ip_dhcp
cls
rem configuracion de red automatica por dhcp
echo Introduzca el nombre de la interface... (por defecto: Ethernet)
set /p interface=
netsh interface ipv4 set address name="%interface%" source=dhcp
netsh interface ipv4 set dnsserver name="%interface%"  source=dhcp
echo.
echo.
echo La configuracion IP de la interface %interface% se configuro de forma automatica.
echo.
pause
goto menu
echo.

:config_ip_static
cls
rem configuracion de red estatica solicitando interactivamente los valores de configuracion de red
echo Introduzca el nombre de la interface... (por defecto: Ethernet)
set /p interface=
echo.
echo Introduzca la direccion IP del host...
set /p direccion=
echo.
echo Introduzca la mascara de red...
set /p mascara=
echo.
echo Introduzca la puerta de enlace...
set /p gateway=
netsh interface ipv4 set address "%interface%" static %direccion% %mascara% %gateway%
echo.
echo La configuracion IP de la interface %interface% se establecieron correctmante.
echo.
pause
goto menu
echo.

:config_dns
cls
rem configuracion de direcciones DNS estatica solicitando interactivamente los valores
echo Introduzca el nombre de la interface... (por defecto: Ethernet)
set /p interface=
echo.
echo Introduzca la direccion DNS primaria...
set /p dns1=
echo.
echo Introduzca la direccion DNS alternativa...
set /p dns2=
netsh interface ipv4 set dnsservers "%interface%" static %dns1% primary
netsh interface ipv4 add dnsservers "%interface%" %dns2% index=2
echo.
echo Los DNS se establecieron correctamente.
echo.
pause
goto menu
echo.

:consultar_config
cls
rem solictar la interface a consultar y mostrar la configuracion de red actual
echo Introduzca el nombre de la interface a consultar... (por defecto: Ethernet)
set /p interface=
netsh interface ipv4 show address %interface% > config_ip
netsh interface ipv4 show dns %interface% >> config_ip
echo.
echo ______________CONFIGURACION DE RED ACTUAL - INTERFACE: %interface%_________________
echo.
type config_ip
echo ________________________________________________________________________________
del config_ip
echo.
pause
goto menu
echo.

:config_automatic_network
cls
rem configuracion de ip pasando un fichero como parametro
set equipo=%computername%
findstr /I /R "^%equipo%:" %1 >tmp.cnf

for /f "eol=# delims=; tokens=1-6" %%i in (tmp.cnf) do (
	set interface=%%j
	set ip=%%k
	set mask=%%l
	set gw=%%m
	set dns1=%%n
	set dns2=%%o

	netsh interface ipv4 set address name="%interface%" source=static address=%ip% mask=%mask% gateway=%gw%
	netsh interface ipv4 set dnsservers "%interface%" static %dns1% primary
	netsh interface ipv4 add dnsservers "%interface%" %dns2% index=2
)
del tmp.cnf
cls
echo.
rem añadir un tiempo de espera para darle tiempo al equipo a establecer la nueva configuración de red.
echo   La direccion IP fue cambiada correctamente 
echo   IMPORTANTE! Espere unos 5 segundos, antes de continuar.
echo. 
pause
rem mostrar el cambio de IP para el equipo correspondiente-actual
netsh interface ipv4 show address "Ethernet" > config_ip
netsh interface ipv4 show dns "Ethernet" >> config_ip
echo.
echo ______________ CONFIGURACION DE RED ACTUAL - EQUIPO: %computername% _________________
echo.
type config_ip
echo ________________________________________________________________________________
del config_ip
echo.
pause

rem segundo ejemplo igual que lo anterior de diferente formam, quizás un método menos "óptimo" en redimiento.

rem for /f "eol=# delims=; tokens=1-6" %%i in (%1) do (
rem	if %%i == %computername% (
rem		set interface=%%j
rem		set ip=%%k
rem		set mask=%%l
rem		set gw=%%m
rem		set dns1=%%n
rem		set dns2=%%o
rem		netsh interface ipv4 set address "%interface%" static %ip% %mask% %gw%
rem		netsh interface ipv4 set dnsservers "%interface%" static %dns1% primary
rem		netsh interface ipv4 add dnsservers "%interface%" %dns2% index=2
rem	echo.
rem	echo Queda establecida la configuracion de red del equipo %%i
rem	echo.
rem	pause
rem	goto salir
rem )
rem echo.
rem echo El nombre de equipo no corresponde a este equipo.
rem echo.
rem pause
rem goto salir

:salir
rem salir limpiando pantalla y estebleciendo los colores de consola por defecto
color 0F
cls
