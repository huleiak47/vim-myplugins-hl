set HOME=%USERPROFILE%

if exist %HOME%\_vimrc del %HOME%\_vimrc
if exist %HOME%\.vimrc del %HOME%\.vimrc

mklink %HOME%\.vimrc %~dp0.vimrc
if %ERRORLEVEL% NEQ 0 goto LINKERR

goto END

: LINKERR
copy /Y .vimrc %HOME%

:END

