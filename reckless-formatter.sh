#!/bin/bash

_checkfordevices(){
    for usbDrive in /dev/sd*
        do
            if [ $usbDrive == "/dev/sd*" ];
            then
            echo "No drive attached."
            echo "Exiting"
            exit
            fi
        echo "At least one drive attached."
    done
}

function _checkforlock(){
    if [ -e /tmp/usbWipe.lock ];
        then
        echo "Already running"
        exit
    fi
}

function _createlock(){
    echo "Starting"
    touch /tmp/usbWipe.lock
}

function _removelock(){
    echo "Cleaning up temp file"
    rm /tmp/usbWipe.lock
    echo "Done"
}

function _wipeDrive(){
    echo "Wiping data on $1"
    sudo sgdisk -Z "$1"
}

function _formatDrive(){
    echo "Formatting $1 to EXFAT"
    mkfs.exfat -n "Drive Name Here" "$1"
}

function _mountDrive(){
    echo "Mounting $1 to /media/$2"
    mkdir /media/"$2"
    mount "$1" /media/"$2"
}

function _writeInfo(){
    echo "Writing info to /media/$1/info.txt"
    echo "Add Info Here" >> /media/"$1"/info.txt
}

function _unmountDrive(){
    echo "Unmounting /media/$1"
    umount /media/"$1"
    echo "Removing /media/$1"
    rmdir /media/"$1"
}

#Script Start

function _runscript(){
    echo "Waiting 5 seconds for user to pull if they regret their decision."
    sleep 5
    
    _checkfordevices
    _checkforlock
    _createlock

    for usbDrive in /dev/sd*
        do
        uniqueIdentifier=$RANDOM

        _wipeDrive $usbDrive
        _formatDrive $usbDrive
        _mountDrive $usbDrive $uniqueIdentifier
        _writeInfo $uniqueIdentifier
        _unmountDrive $uniqueIdentifier
    done

    _removelock
}

_runscript 