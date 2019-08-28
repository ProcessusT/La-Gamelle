@echo off
cls
echo ****************************************
echo Sauvegarde des conteneurs docker by Proc
echo ****************************************
SETLOCAL EnableDelayedExpansion

REM Recuperation des id des conteneurs
for /f "tokens=*" %%a in ('docker ps -q') do ( 

echo.
echo.
echo.
REM Recuperation des noms des conteneurs
for /f %%b in ('docker inspect --format="{{.Name}}" %%a') do (

set container_name=%%b
set container_name=!container_name:~1!
echo Sauvegarde en cours du conteneur : !container_name!

set mydate=%date:~6,4%%date:~3,2%%date:~0,2%
set commit_name=!container_name!_commit_!mydate!
echo Le commit porte le nom : !commit_name!

REM Commit des conteneurs
for /f %%c in ('docker commit -p !container_name! !commit_name!') do (

echo Exportation du commit en cours...
docker save -o !commit_name!.tar !commit_name!
echo !commit_name! a ete exporte !
echo Suppression du commit dans Docker...
docker image rm !commit_name!
echo Suppression effectuee.

)
)
)


echo.
echo.
echo Fin du script
pause