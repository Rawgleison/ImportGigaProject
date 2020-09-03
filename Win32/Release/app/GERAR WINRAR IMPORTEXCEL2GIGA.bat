echo off
cls
del ImportExcel2Giga.exe
rename ImportGiga2Giga.exe ImportExcel2Giga.exe
set /p versao=Digite a versao:
"c:\Program Files (x86)\WinRAR\WinRAR.exe" a -r- ImportExcel2Giga_%versao%.rar ImportExcel2Giga.exe