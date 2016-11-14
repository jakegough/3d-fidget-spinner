@echo off
SET SCRIPT_MODE=1

call knob.608.build.bat

call spinner.608.3s.dogbone.build.bat

call spinner.608.3s.build.bat
call spinner.608.3s.fatty.build.bat

call spinner.608.4y.build.bat
call spinner.608.4y.fatty.build.bat

call spinner.608.5t.build.bat
call spinner.608.5t.fatty.build.bat

call spinner.608.bearing-fit-test.build.bat

echo.
pause