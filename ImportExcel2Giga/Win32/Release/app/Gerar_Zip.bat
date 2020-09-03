@echo off
set /p versao=Versao: 
cd "D:\Documentos\Gigatron\GPProjetos_Delphi\ImportGigaProject\ImportExcel2Giga\Win32\Release\app"
"C:\Program Files\WinRAR\WinRAR.exe" a "Distributable\ImportExcel2Giga_1.5.0.%versao%.rar" ImportExcel2Giga.exe fbclient.dll