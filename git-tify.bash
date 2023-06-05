#! /usr/bin/env bash

################################################################################
##
## This file is part of RaSt git-gnu-project.
##
## RaSt git-gnu-project is to  manage a directory as a Git  repository and a GNU
## package.
##
## Copyright (C)  2023  Ralf Stephan
##
## RaSt git-gnu-project is free software:  you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by the Free
## Software Foundation, either version 3 of the License, or (at your option) any
## later version.
##
## RaSt git-gnu-project is  distributed in the hope that it  will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
## FITNESS FOR  A PARTICULAR PURPOSE.   See the  GNU General Public  License for
## more details.
##
## You should have received a copy of  the GNU General Public License along with
## this program.  If not, see <https://www.gnu.org/licenses/>.
##
################################################################################



################################################################################
##
## $Date: 2023-06-05 12:11:58.1852606000 +00:00:00 $
##
################################################################################



################################################################################
##
## git-tify.bash (git-gnu-project)
##
## NAME
##
## git-tify.bash - manage a directory as a Git repository
##
## LIBRARY                                      (For sections 2, 3, and 9 only.)
##
## SYNOPSIS
##
## git-tify.bash repository-path repository-name ???
##
## DESCRIPTION
##
## ???
##
## ARGUMENTS
##
## repository-path - path to the directory
##
## repository-name - name of the repository
##
## ???
##
## OPTIONS
##
## ???
##
## CONTEXT                                       (For section 9 functions only.)
##
## IMPLEMENTATION NOTES
##
## RETURN VALUES         (For sections 2, 3, and 9 function return values only.)
##
## ENVIRONMENT                               (For sections 1, 6, 7, and 8 only.)
##
## FILES
##
## git-tify.bash - this script
##
## EXIT STATUS                                  (For sections 1, 6, and 8 only.)
##
## EXAMPLES
##
## git-tify.bash /home/user/john_dow/repositories/ foobar
##
## DIAGNOSTICS  (For sections 1, 4, 6, 7, 8, and 9 printf/stderr messages only.)
##
## ERRORS                     (For sections 2, 3, 4, and 9 errno settings only.)
##
## SEE ALSO
##
## STANDARDS
##
## HISTORY
##
## AUTHORS
##
## Ralf Stephan <me@ralf-stephan.name>
##
## CAVEATS
##
## BUGS
##
## SECURITY CONSIDERATIONS
##
## TESTS
##
## See section TESTS below.
##
################################################################################



################################################################################
##
## Global constants.
##
################################################################################



################################################################################
##
## Global variables.
##
################################################################################
##
## command line argument $1 : repository-path - path to the directory
##
declare repository_path='';
##
## command line argument S2 : repository-name - name of the repository
##
declare repository_name='';
##
## command line argument $3 : user name
##
declare user_name='';
##
## command line argument $4 : user email
##
declare user_email='';
##
## command line argument $5 : how a merge is handled
##
## git merge --ff-only : merge.ff = only
## git merge --ff      : merge.ff = true
## git merge --no-ff   : merge.ff = false
##
declare merge_ff='';
##
## command line argument $6 : how a pull is handled
##
## git pull --ff-only : pull.ff = only
## git pull --ff      : pull.ff = true
## git pull --no-ff   : pull.ff = false
##
declare pull_ff='';
##
## command line argument ??? : how a rebase is handled
##
## git pull --rebase='false'       : pull.rebase = false
## git pull --rebase='true'        : pull.rebase = true
## git pull --rebase='interactive' : pull.rebase = interactive
## git pull --rebase='merges'      : pull.rebase = merges
##
declare pull_rebase=''; # unused



################################################################################
##
## Get the command line arguments.
##
################################################################################
##
## Check number of arguments.
##
if (( 6 == "${#}" )); then
  :;
else
  echo 'Error: wrong number of arguments.';
  exit 1;
fi
##
## command line argument $1 : repository-path - path to the directory
##
repository_path="${1}";
repository_path="$( echo "${repository_path}" | sed 's/[/]*$//g' )";
##
## command line argument S2 : repository-name - name of the repository
##
repository_name="${2}";
##
## command line argument $3 : user name
##
user_name="${3}";
##
## command line argument $4 : user email
##
user_email="${4}";
##
## command line argument $5 : how a merge is handled
##
merge_ff="${5}";
##
## command line argument $6 : how a pull is handled
##
pull_ff="${6}";



################################################################################
##
## See if we can create a new Git repository.  If OK, then change working
## directory and create the new directory.
##
################################################################################
##
## See if there is the directory $repository_path.
##
if [[ -d "${repository_path}/" ]]; then
  :;
else
  echo "Error: directory '${repository_path}/' does not exist.";
  exit 1;
fi
##
cd "${repository_path}/";
##
## See if there is a directory $repository_name is directory $repository_path.
##
if [[ -d "./${repository_name}/" ]]; then
  echo "Error: directory '${repository_path}/${repository_name}/' does exist.";
  exit 1;
else
  :;
fi
##
mkdir "./${repository_name}/";
##
cd "./${repository_name}/";



################################################################################
##
## Create and initialize an empty Git repository in the working directory.
##
################################################################################
##
echo "Info: create and initialize an empty repository in '${repository_path}/${repository_name}/'. ...";
##
git init --initial-branch='master' --template='' './';
##
echo '... done';



################################################################################
##
## Configure the Git repository.
##
################################################################################
##
echo "Info: configuring repository '${repository_path}/${repository_name}/'. ...";
##
git config --global user.name  "${user_name}";
##
git config          user.name  "${user_name}";
##
git config --global user.email "${user_email}";
##
git config          user.email "${user_email}";
##
git config --global merge.ff   "${merge_ff}";
##
git config          merge.ff   "${merge_ff}";
##
git config --global pull.ff    "${pull_ff}";
##
git config          pull.ff    "${pull_ff}";
##
declare git_remote='';
for git_remote in "${!GIT_REMOTES[@]}"; do
  git remote add "${git_remote}" "${GIT_REMOTES[${git_remote}]}";
done;
##
echo '... done';



################################################################################
##
## TESTS
##
################################################################################



################################################################################
##
## Exit the shell.
##
################################################################################

exit 0;
