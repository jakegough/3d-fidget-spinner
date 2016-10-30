@echo off

SET "OPENSCAD_EXE=C:\Program Files\OpenSCAD\openscad.exe"
SET INPUT_FILE=%1
SET INPUT_FILE_NAME_ONLY=%~n1
SET OUTPUT_FILE=%~n1.stl

"%OPENSCAD_EXE%" -o "%OUTPUT_FILE%" %INPUT_FILE%

echo.
echo.
echo.
echo.
echo Exported %INPUT_FILE_NAME_ONLY%
pause