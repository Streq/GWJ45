#!/bin/bash
./sh/require_clean_work_tree.sh || exit "$?"
git checkout develop || exit "$?" 
git pull || exit "$?" 
git checkout main || exit "$?" 
git pull || exit "$?" 
git merge develop --commit -m"$1" --log || exit "$?" 
git push || exit "$?"
git checkout develop || exit "$?"
#./sh/export.sh || exit "$?"
#./sh/increment_version.sh "$@"
#./sh/export_to_gh_pages.sh