@echo off
cd /d %~dp0
SET CONDA_SHLVL=

TITLE KoboldAI - Updater
SET /P M=<loader.settings
IF %M%==1 GOTO drivemap
IF %M%==2 GOTO subfolder
IF %M%==3 GOTO drivemap_B

:subfolder
SET TEMP=%~DP0MINICONDA3
SET TMP=%~DP0MINICONDA3
call miniconda3\condabin\activate
GOTO GIT

:drivemap
subst K: miniconda3 >nul
SET TEMP=K:\
SET TMP=K:\
call K:\python\condabin\activate
GOTO GIT

:drivemap_B
subst B: miniconda3 >nul
SET TEMP=B:\
SET TMP=B:\
call B:\python\condabin\activate
GOTO GIT

:GIT
rem ECHO 1. KoboldAI Main (The Official stable version of KoboldAI)
rem ECHO 2. KoboldAI United (Development Version, new features but may break at any time)
rem SET /P V=Enter your desired version or type your own GIT URL:
rem IF %V%==1 (
rem SET origin=https://github.com/koboldai/koboldai-client
rem SET branch=main
rem ) ELSE (
rem		IF %V%==2 (
rem			SET origin=https://github.com/henk717/koboldai
rem			SET branch=united
rem		) ELSE (
rem			SET origin=%v%
rem			SET /P branch=Specify the GIT Branch:
rem		)
rem )
SET origin=https://github.com/gd1551/kai-fork
SET branch=united

git init     
git remote remove origin
git remote add origin %origin%    
git fetch --all
git checkout %branch% -f
git reset --hard origin/%branch%
git submodule update --init --recursive
IF %M%==1 umamba.exe install --no-shortcuts -r K:\python\ -n base -f "%~dp0\environments\huggingface.yml" -y --always-copy
IF %M%==2 umamba.exe install --no-shortcuts -r miniconda3 -n base -f environments\huggingface.yml -y --always-copy
IF %M%==3 umamba.exe install --no-shortcuts -r B:\python\ -n base -f "%~dp0\environments\huggingface.yml" -y --always-copy


%windir%\system32\timeout -t 10