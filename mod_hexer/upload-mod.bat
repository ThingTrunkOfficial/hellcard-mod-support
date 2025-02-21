@echo off

if x%1==x goto USAGE
if x%2==x goto USAGE

set steamcmd="C:\steamcmd\steamcmd.exe"
set workshop_item_conf="C:\mod_hexer\workshop-item.vdf"

set login=%~1
set pass=%~2

%steamcmd% +login "%login%" "%pass%" +workshop_build_item %workshop_item_conf% +quit

goto END

:USAGE

echo.
echo Missing arguments
echo.
echo USAGE:
echo.    %~0 username password
echo.
echo where
echo.    username         Name of your steam account
echo.    password         Your steam password
echo.

:END
