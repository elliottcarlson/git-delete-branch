Delete local and remote git branches.
=====================================

Delete one or more branches both locally and remotely.

Usage:

	$ git delete-branch [branchname1] [branchnameX]

Example output:

	$ git delete-branch [branchname]
	[branchname] branch last updated: 8 weeks ago
		
	Are you sure you want to delete the local [branchname] branch? <Y>es or <N>o
	Deleting...
	Local branch [branchname] deleted.
	Are you sure you want to delete the remote [branchname] branch? <Y>es or <N>o
	Deleting...
	Remote branch [branchname] deleted.
	$

Installation.
=============

Simply copy this script into a directory on your path (/usr/local/bin for example) and then 
give it executable permissions (```chmod 755 /usr/local/bin/git-delete-branch```).

Optional git branch tab completion.
===================================

This depends on the standard ```git-completion.sh``` script available commonly on the Internet.
Just add this to the file and get auto-completion of branch names.

```bash
    _git_delete_branch ()
    {
        __git_complete_strategy && return
        __gitcomp_nl "$(__git_refs)"
    }
```
