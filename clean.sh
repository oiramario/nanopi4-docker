#!/bin/bash
#
#set -x

source scripts/functions/common.sh


DISTRO=$(pwd)/distro
[ -d $DISTRO ] && rm -rf $DISTRO


clear_docker()
{
    # stop containers
    info_msg "stop rk3399 containers"
    var=$(docker ps -a | grep "rk3399" | awk '{print $1 }')
    [ -n "$var" ] && docker stop $var

    info_msg "stop exited containers"
    var=$(docker ps -a | grep "Exited" | awk '{print $1 }')
    [ -n "$var" ] && docker stop $var

    info_msg "remove rk3399 containers"
    var=$(docker ps -a | grep "rk3399" | awk '{print $1 }')
    [ -n "$var" ] && docker rm $var

    info_msg "remove exited containers"
    var=$(docker ps -a | grep "Exited" | awk '{print $1 }')
    [ -n "$var" ] && docker rm $var

    # remove images
    info_msg "remove none images"
    var=$(docker images | grep "none" | awk '{print $3}')
    [ -n "$var" ] && docker rmi $var
}


clear_packages()
{
    # clear packages
    info_msg "clear packages"
    rm -vf $(pwd)/packages/*
}


help()
{
	echo
	info_msg "Usage:"
	info_msg "	clean.sh [target]"
	echo
	info_msg "Example:"
	info_msg "	clean.sh docker"
	info_msg "	clean.sh packages"
	info_msg "	clean.sh all"
	echo
}


######################################################################################
TARGET="$1"
case "$TARGET" in
	docker)
		clear_docker
		;;
	packages)
		clear_packages
		;;
	all)
		clear_docker
		clear_packages
		;;
	*)
		error_msg "Unsupported target: $TARGET"
		help
		exit -1
		;;
esac
