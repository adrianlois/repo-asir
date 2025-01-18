@echo off
title Reparación MDAC
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

IF NOT EXIST %systemroot%\SysWoW64\regsvr32.exe goto :salir

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

:salir