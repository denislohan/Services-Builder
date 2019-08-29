#!/bin/sh

project=''
service=''
for sr in $1
    do
        while read line;
            do
                if [[ "$line" == '__'* ]];
                    then #this is a service 
                        line=`echo "$line" | sed -e 's/^..//g'`
                        dir=`echo "$line" | cut -d':' -f 1`
                        filename=`echo "$line" | cut -d':' -f 2 | sed -e 's/\ //g'`
                        mkdir -p ~/services/$project/$service/$dir
                        # go in the project
                        # copy the file of $
                        echo "creating file $filename in the $dir folder"
                elif [[ "$line" == 'Service'* ]];
                    then
                        service=`echo "$line" | cut -d':' -f 2 | sed -e 's/\ //g'`
                        mkdir -p ~/services/$project/$service
                elif [[ "$line" == "Project"* ]];
                    then
                        project=`echo "$line" | cut -d':' -f 2| sed -e 's/\ //g'`
                        #create an npm project for service $s
                         mkdir -p ~/services/$project
                        # cd ~/
                fi
            done < $sr                    
    done