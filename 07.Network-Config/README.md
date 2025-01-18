# Network Config
Automatizar una configuración de red local

1. Crear un proceso por lotes que cumpla los siguientes requisitos:
2. Configurar la red, pidiendo de forma interactiva los datos necesarios para la configuración
3. (Téngase en cuenta que la configuración podrá ser estática o dinámica):
Configuración dinámica? Configuración estática?
Ip, mask, Gw, dns1, dns2
4. Pasarle mediante un parámetro un fichero que contenga la configuración para todos los equipos (El fichero podrá tener un formato similar al siguiente)
```
NombreEquipo;ip;mascara;gw;dns1
```

![Network Config](https://raw.githubusercontent.com/adrianlois/Network-Config/master/screenshots/NetworkConfig_menu.png)

![Network Config](https://github.com/adrianlois/Network-Config/blob/master/screenshots/NetworkConfig_fichero_como_parametro.png)

![Network Config](https://github.com/adrianlois/Network-Config/blob/master/screenshots/NetworkConfig_mostrar_configRed.png)
