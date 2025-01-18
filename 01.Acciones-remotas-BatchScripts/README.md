# Acciones remotas Batch Scripts
Batchfiles Processing - Acciones en equipos remotos

**recursos**: Es necesario incluir en una variable de entorno de Windows el binario PsExec.exe

```
https://docs.microsoft.com/en-us/sysinternals/downloads/psexec
```

**Menu.bat**: Es un menú con todas las acciones remotas en un mismo proceso por lotes. Es necesario establecer los datos del equipo remoto en el que se realizarán las acciones seleccionadas en el menú. 

**scripts**: Su contenido está formado por los procesos por lotes individuales de las mismas acciones remotas que se incluyen en Menu.bat, con la finalidad de ejecutarlas por separado.

- 01.CambiarIPEquipoRemoto.bat
- 02.CerrarSesionesServidores.bat
- 03.DetenerDeshabilitarServiciosRemotos.bat
- 04.EjecutarCMDRemota.bat
- 05.EliminarColaDeImpresionRemoto.bat
- 06.EnviarMensajeEquipoRemoto.bat
- 07.IniciarHabilitarServiciosRemotos.bat
- 08.ListarFinalizarProcesosRemotos.bat
- 10.ListarSoftwareRemoto_SOLOx64.bat
- 11.OSVersionRemoto.bat
- 12.PredeterminarImpresoras.bat
- 13.Reparacion_MDAC.bat