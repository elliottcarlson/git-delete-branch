#!/usr/bin/env bash

# Ensure a branch name was given 
if [ $# -lt 1 ]; then 
    echo "Error in $0 - Invalid argument count" 
    echo "Syntax: $0 branch_name [...]" 
    exit 
fi 

# Loop through the branches
for i in $@; do
    # Check if branch exists locally 
    if ( ! git show-ref --verify --quiet refs/heads/$i ); then 
        echo "Local branch does not exist" 
    else 
        echo -e $(git show --pretty=format:"$i branch last updated: %cr" $i -- | head -n 1)\\n

        if ( ! git branch --merged | grep -c --silent $i ); then
            bold=`tput bold`
            normal=`tput sgr0`
            echo "${bold}Warning${normal}: Branch has not been merged in to master yet!"
        fi

        echo "Are you sure you want to delete the local $i branch? <Y>es or <N>o" 
        read -s -n1 REPLY 
        case $REPLY in 
            y | Y) 
                echo "Deleting..." 
                git branch -d $i >/dev/null 
                if [ $? -ne 0 ]; then 
                    echo "Unable to delete local branch. Aborting." 
                    exit 
                else 
                    echo "Local branch $i deleted." 
                fi 
                ;; 
            *) 
                echo "Skipping deletion of local branch." 
                ;; 
        esac 
    fi 
 
    # Check if branch exists remotely 
    if ( ! git show-ref --verify --quiet refs/remotes/origin/$i); then 
        echo "Remote branch does not exist." 
    else 
        echo "Are you sure you want to delete the remote $i branch? <Y>es or <N>o" 
        read -s -n1 REPLY 
        case $REPLY in 
            y | Y) 
                echo "Deleting..." 
                git push --quiet origin :$i 
                if [ $? -ne 0 ]; then 
                    echo "Unable to delete remote branch. Aborting." 
                    exit 
                else 
                    echo "Remote branch $i deleted." 
                fi 
                ;; 
            *) 
                echo "Skipping deletion of remote branch." 
                ;; 
        esac 
    fi
done
