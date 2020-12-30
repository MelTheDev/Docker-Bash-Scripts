#!/usr/bin/env bash
#Mel - 30/12/2020

DOCKER_DIR='path_to_docker_compose_dir'

cd $DOCKER_DIR

function startDocker()
{
    if docker-compose ps | grep 'Exit' &> /dev/null; then

    echo "Some docker containers are not running"
    echo "Stopping all.."
    docker stop $(docker ps -qa)
	sleep 1
	echo "Starting.."
    docker-compose -f docker-compose.dev.yml up -d
else

    echo "All services up!"

fi
}

function stopDocker()
{
    echo "Stopping all docker services"
    docker stop $(docker ps -qa)
    echo "Docker Stopped!"
}

PS3='Please enter your choice: '
options=("Start Docker" "Stop Docker")
select opt in "${options[@]}"
do
    case $opt in
        "Start Docker")
            startDocker
            break
            ;;
        "Stop Docker")
            stopDocker
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done