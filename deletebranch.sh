#!/usr/bin/env bash

# Ensure a branch name was given 
if [ $# -ne 1 ]; then 
    echo "Error in $0 - Invalid argument count" 
    echo "Syntax: $0 branch_name" 
    exit 
fi 
 
# Check if branch exists locally 
if ( ! git show-ref --verify --quiet refs/heads/$1 ); then 
    echo "Local branch does not exist" 
else 
    echo -e $(git show --pretty=format:"$1 branch last updated: %cr" $1 -- | head -n 1)\\n

    echo "Are you sure you want to delete the local $1 branch? <Y>es or <N>o" 
    read -s -n1 REPLY 
    case $REPLY in 
        y | Y) 
            echo "Deleting..." 
            git branch -d $1 >/dev/null 
            if [ $? -ne 0 ]; then 
                echo "Unable to delete local branch. Aborting." 
                exit 
            else 
                echo "Local branch $1 deleted." 
            fi 
            ;; 
        *) 
            echo "Skipping deletion of local branch." 
            exit 
            ;; 
    esac 
 
fi 
 
# Check if branch exists remotely 
if ( ! git show-ref --verify --quiet refs/remotes/origin/$1); then 
    echo "Remote branch does not exist." 
else 
    echo "Are you sure you want to delete the remote $1 branch? <Y>es or <N>o" 
    read -s -n1 REPLY 
    case $REPLY in 
        y | Y) 
            echo "Deleting..." 
            git push --quiet origin :$1 
            if [ $? -ne 0 ]; then 
                echo "Unable to delete remote branch. Aborting." 
                exit 
            else 
                echo "Remote branch $1 deleted." 
            fi 
            ;; 
        *) 
            echo "Skipping deletion of remote branch." 
            ;; 
    esac 
fi

