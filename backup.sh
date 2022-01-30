#!/bin/bash

## Author:Brycen Medart
## Project: remote-backup-script
## URL:https://treantlabs.com
## Version: 1.0
## License: MIT Licence

## Save Location Variable
tar_save_location="$1"

## Name for tar.gz file
tar_file_name="$2"

## Remote server username
remote_username="pi"

## Remote IP address or server name
remote_server="192.168.1.121"

## Remote server folder / file for backup 
remote_directory="/media/PIPLEX/Shows/" 

## TAR Commands
tar_options=zcfv

## Is there resources on the remote server to compress? 0 - no, 1 - yes
resources_available=0

 #If not a directory
 if [ -d $tar_save_location ]; then

    #CD into directory 
    cd $tar_save_location

    if [ $resources_available == 0 ]; then

    mkdir $tar_file_name
    rsync -avzhe $remote_username@$remote_server:$remote_directory ./$tar_file_name

    else

    #SSH into remote server and backup folder to file
    ssh $remote_username@$remote_server tar $tar_options"P"  - $remote_directory > $tar_file_name.tar.gz && echo "Backup Complete"
   
    fi
    
fi

read -n 1 -r -s -p $'Press enter to continue...\n'