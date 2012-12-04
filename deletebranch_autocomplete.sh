#!/usr/bin/env bash

_deletebranch_autocomplete()
{
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local running=`git for-each-ref --format='%(refname:short)' --sort='refname:short' refs/heads`
    COMPREPLY=( $(compgen -W "${running}" -- ${cur}) )
    return 0
}

complete -F _deletebranch_autocomplete deletebranch.sh
