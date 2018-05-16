@echo off

if not "%1"=="" goto :crack
echo 请将libTDMaster.dll拖动到该批处理文件
pause>nul
goto :end



:crack
taskkill /f /t /im StudentMain.exe
taskkill /f /t /im PhantosysClientService.exe
taskkill /f /t /im MasterHelper.exe

del /f "C:\Program Files (x86)\Phantosys\PhantosysCloud v5.0 2014 standard\libTDMaster.dll"
copy %1 "C:\Program Files (x86)\Phantosys\PhantosysCloud v5.0 2014 standard\libTDMaster.dll"

"C:\Program Files (x86)\Phantosys\PhantosysCloud v5.0 2014 standard\StudentMain.exe"
echo 上面如果成功复制文件，则表示成功了。
ping 127.0.0.1 > nul
:end
