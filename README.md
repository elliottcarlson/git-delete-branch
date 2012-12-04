Delete local and remote git branches.
=====================================

Delete one or more branches both locally and remotely.

Usage:

		$ deletebranch.sh [branchname1] [branchnameX]

Example output:

		$ deletebranch.sh [branchname]
		[branchname] branch last updated: 8 weeks ago
		
		Are you sure you want to delete the local [branchname] branch? <Y>es or <N>o
		Deleting...
		Local branch [branchname] deleted.
		Are you sure you want to delete the remote [branchname] branch? <Y>es or <N>o
		Deleting...
		Remote branch [branchname] deleted.
		$

Add git branch tab completion.
==============================

Included is an additional bash script to add tab completion of branch names. You can either
run it in the current environment for the current terminal session, or by adding it to your
.bashrc file.

Current terminal session:

		$ . ./deletebranch_autocomplete.sh

.bashrc line:

		source /path/to/deletebranch_autocomplete.sh

Once you have added the autocompletion script, you can simply type deletebranch.sh and then press
TAB twice to list the branches available or to complete the branch name you have started to type.
