ECHO OFF
SETLOCAL DisableDelayedExpansion
FOR /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  SET "DEL=%%a"
)

SET arg1=%1
SET arg2=%2
 
IF %arg1% EQU SETUP_BOX (
    CALL :COLOR_TEXT 0a "[FABRICO]"
    CALL :COLOR_TEXT 0a "--------------------------------------------------"
    CALL :GOTO_FABRICO
    REM -------------------------------------------------------------------
    CALL :NPM_INSTALL
    CALL :SETUP_BOX
    CALL :BUILD
    CALL :LINK
    REM -------------------------------------------------------------------
    CALL :EXIT_FABRICO
    CALL :COLOR_TEXT 0a "[SEED-CA-NETCORE-MICROSERVICES]"
    CALL :COLOR_TEXT 0a "--------------------------------------------------"
    CALL :GOTO_SEED
    REM -------------------------------------------------------------------
    CALL :NPM_INSTALL
    CALL :SETUP_BOX
    CALL :BUILD
    CALL :LINK
    REM -------------------------------------------------------------------
    CALL :EXIT_SEED
    CALL :COLOR_TEXT 0a "[FABRICO-CLI]"
    CALL :COLOR_TEXT 0a "--------------------------------------------------"
    CALL :GOTO_FABRICO_CLI
    REM -------------------------------------------------------------------
    CALL :NPM_INSTALL
    CALL :SETUP_BOX
    CALL :BUILD
    CALL :LINK
    REM -------------------------------------------------------------------
    CALL :EXIT_FABRICO_CLI
)
IF %arg1% EQU BUILD (
    CALL :COLOR_TEXT 0a "[FABRICO]"
    CALL :COLOR_TEXT 0a "--------------------------------------------------"
    CALL :GOTO_FABRICO
    REM -------------------------------------------------------------------
    CALL :BUILD
    REM -------------------------------------------------------------------
    CALL :EXIT_FABRICO
    CALL :COLOR_TEXT 0a "[SEED-CA-NETCORE-MICROSERVICES]"
    CALL :COLOR_TEXT 0a "--------------------------------------------------"
    CALL :GOTO_SEED
    REM -------------------------------------------------------------------
    CALL :BUILD
    REM -------------------------------------------------------------------
    CALL :EXIT_SEED
    CALL :COLOR_TEXT 0a "[FABRICO-CLI]"
    CALL :COLOR_TEXT 0a "--------------------------------------------------"
    CALL :GOTO_FABRICO_CLI
    REM -------------------------------------------------------------------
    CALL :BUILD
    REM -------------------------------------------------------------------
    CALL :EXIT_FABRICO_CLI
)
IF %arg1% EQU TEST (
    CALL :COLOR_TEXT 0a "[FABRICO]"
    CALL :COLOR_TEXT 0a "--------------------------------------------------"
    CALL :GOTO_FABRICO
    REM -------------------------------------------------------------------
    CALL :TEST
    REM -------------------------------------------------------------------
    CALL :EXIT_FABRICO
    CALL :COLOR_TEXT 0a "[FABRICO-CLI]"
    CALL :COLOR_TEXT 0a "--------------------------------------------------"
    CALL :GOTO_FABRICO_CLI
    REM -------------------------------------------------------------------
    CALL :TEST
    REM -------------------------------------------------------------------
    CALL :EXIT_FABRICO_CLI
    CALL :COLOR_TEXT 0a "[SEED-CA-NETCORE-MICROSERVICES]"
    CALL :COLOR_TEXT 0a "--------------------------------------------------"
    CALL :GOTO_SEED
    REM -------------------------------------------------------------------
    CALL :TEST
    REM -------------------------------------------------------------------
    CALL :EXIT_SEED
)
IF %arg1% EQU GIT_PUSH (
    CALL :COLOR_TEXT 0a "[WORKSPACE]"
    CALL :COLOR_TEXT 0a "--------------------------------------------------"
    REM -------------------------------------------------------------------
    CALL :GIT_PUSH
    REM -------------------------------------------------------------------
    CALL :COLOR_TEXT 0a "[FABRICO]"
    CALL :COLOR_TEXT 0a "--------------------------------------------------"
    CALL :GOTO_FABRICO
    REM -------------------------------------------------------------------
    CALL :GIT_PUSH
    REM -------------------------------------------------------------------
    CALL :EXIT_FABRICO
    CALL :COLOR_TEXT 0a "[FABRICO-CLI]"
    CALL :COLOR_TEXT 0a "--------------------------------------------------"
    CALL :GOTO_FABRICO_CLI
    REM -------------------------------------------------------------------
    CALL :GIT_PUSH
    REM -------------------------------------------------------------------
    CALL :EXIT_FABRICO_CLI
    CALL :COLOR_TEXT 0a "[SEED-CA-NETCORE-MICROSERVICES]"
    CALL :COLOR_TEXT 0a "--------------------------------------------------"
    CALL :GOTO_SEED
    REM -------------------------------------------------------------------
    CALL :GIT_PUSH
    REM -------------------------------------------------------------------
    CALL :EXIT_SEED
    ECHO %arg2%
)
IF %arg1% EQU GIT_PUSH_AMEND (
    CALL :COLOR_TEXT 0a "[WORKSPACE]"
    CALL :COLOR_TEXT 0a "--------------------------------------------------"
    REM -------------------------------------------------------------------
    CALL :GIT_PUSH_AMEND
    REM -------------------------------------------------------------------
    CALL :COLOR_TEXT 0a "[FABRICO]"
    CALL :COLOR_TEXT 0a "--------------------------------------------------"
    CALL :GOTO_FABRICO
    REM -------------------------------------------------------------------
    CALL :GIT_PUSH_AMEND
    REM -------------------------------------------------------------------
    CALL :EXIT_FABRICO
    CALL :COLOR_TEXT 0a "[FABRICO-CLI]"
    CALL :COLOR_TEXT 0a "--------------------------------------------------"
    CALL :GOTO_FABRICO_CLI
    REM -------------------------------------------------------------------
    CALL :GIT_PUSH_AMEND
    REM -------------------------------------------------------------------
    CALL :EXIT_FABRICO_CLI
    CALL :COLOR_TEXT 0a "[SEED-CA-NETCORE-MICROSERVICES]"
    CALL :COLOR_TEXT 0a "--------------------------------------------------"
    CALL :GOTO_SEED
    REM -------------------------------------------------------------------
    CALL :GIT_PUSH_AMEND
    REM -------------------------------------------------------------------
    CALL :EXIT_SEED
)
IF %arg1% EQU GIT_CLEAN_RESET (
    CALL :COLOR_TEXT 0a "[WORKSPACE]"
    CALL :COLOR_TEXT 0a "--------------------------------------------------"
    CALL :GIT_CLEAN_RESET
    CALL :COLOR_TEXT 0a "[FABRICO]"
    CALL :COLOR_TEXT 0a "--------------------------------------------------"
    CALL :GOTO_FABRICO
    REM -------------------------------------------------------------------
    CALL :GIT_CLEAN_RESET
    REM -------------------------------------------------------------------
    CALL :EXIT_FABRICO
    CALL :COLOR_TEXT 0a "[FABRICO-CLI]"
    CALL :COLOR_TEXT 0a "--------------------------------------------------"
    CALL :GOTO_FABRICO_CLI
    REM -------------------------------------------------------------------
    CALL :GIT_CLEAN_RESET
    REM -------------------------------------------------------------------
    CALL :EXIT_FABRICO_CLI
    CALL :COLOR_TEXT 0a "[SEED-CA-NETCORE-MICROSERVICES]"
    CALL :COLOR_TEXT 0a "--------------------------------------------------"
    CALL :GOTO_SEED
    REM -------------------------------------------------------------------
    CALL :GIT_CLEAN_RESET
    REM -------------------------------------------------------------------
    CALL :EXIT_SEED
)

EXIT

:GIT_PUSH
    git add -A
    git commit -m %arg2%
    git push -f origin master
    EXIT /B
:GIT_PUSH_AMEND
    git commit --amend -m %arg2%
    git push -f origin master
    EXIT /B
:GIT_CLEAN_RESET
    git clean -d -fx
    git reset --hard
    EXIT /B
:NPM_INSTALL
    CALL npm install
    EXIT /B
:GOTO_FABRICO_CLI
    cd ../fabrico-cli
    EXIT /B
:EXIT_FABRICO_CLI
    cd ../fabrico-workspace
    EXIT /B
:GOTO_FABRICO
    cd ../fabrico
    EXIT /B
:EXIT_FABRICO
    cd ../fabrico-workspace
    EXIT /B
:GOTO_SEED
    cd ../seed-ca-netcore-microservices
    EXIT /B
:EXIT_SEED
    cd ../fabrico-workspace
    EXIT /B
:SETUP_BOX
    CALL :COLOR_TEXT 0b "starting setup box"
    CALL npm run setup.box
    CALL :COLOR_TEXT 0b "completed setup box"
    EXIT /B
:BUILD
    CALL :COLOR_TEXT 0b "starting build"
    CALL npm run build
    CALL :COLOR_TEXT 0b "completed build"
    EXIT /B
:BUILD_TEST
    CALL :COLOR_TEXT 0b "starting build.test"
    CALL npm run build.test
    CALL :COLOR_TEXT 0b "completed build.test"
    EXIT /B
:LINK
    CALL :COLOR_TEXT 0b "starting linking"
    CALL npm run link
    CALL :COLOR_TEXT 0b "completed linking"
    EXIT /B
:TEST
    CALL :COLOR_TEXT 0b "starting test execution"
    CALL npm run test
    CALL :COLOR_TEXT 0b "completed test execution"
    EXIT /B
:COLOR_TEXT
    ECHO OFF
    <NUL SET /p .=. > "%~2"
    FINDSTR /v /a:%1 /R "^$" "%~2" nul
    ECHO(%DEL%%DEL%%DEL%
    DEL "%~2" > NUL 2>&1
    EXIT /B