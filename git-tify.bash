#! /usr/bin/env -S bash -e

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
## git-tify.bash repository-path repository-name user-name user-email merge-ff
##   pull-ff tracked-repositories project-name package-name git-files
##
## DESCRIPTION
##
## Manage a directory as a Git repository.
##
## Step 1: See if we can create a new Git repository.
##
## Step 2: Create and initialize an empty Git repository.
##
## Step 3: Configure the Git repository.
##
## Step 4: Initial commit of the repository.
##
## Step 5: Create und commit Git configuration files.
##
## Step 6: Cleanup and optimize the repository.
##
## ARGUMENTS
##
## repository-path      - path to the directory
##
## repository-name      - name of the repository
##
## user-name            - name of the user
##
## user-email           - email of the user
##
## merge-ff             - how a merge is handled
##
## pull-ff              - how a pull is handled
##
## tracked-repositories - set of tracked repositories
##
## project-name         - name of the project
##
## package-name         - name of the package
##
## git-files            - Git configuration files
##
## OPTIONS
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
## git-tify.bash           - this script
##
## config.inc.bash         - used configuration file
##
## config.inc.bash.example - example configuration file
##
## EXIT STATUS                                  (For sections 1, 6, and 8 only.)
##
## EXAMPLES
##
## ./git-tify.bash \
##   '/home/user/JohnDow/repositories/' \
##   'foobar' \
##   'John Dow' \
##   'john.dow@example.com' \
##   'false' \
##   'false' \
##   'github.com,git@github.com-JohnDow:JohnDow;gitlab.com,git@gitlab.com-JohnDow:JohnDow;example.com,ssh://JohnDow@example.com/home/JohnDow/repositories' \
##   'JD' \
##   'foobar' \
##   '.gitattributes;.gitignore;.gitkeep;.gitmodules;.mailmap'
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
## command line argument $1  : repository-path      - path to the directory
##
declare repository_path='';
##
## command line argument S2  : repository-name      - name of the repository
##
declare repository_name='';
##
## command line argument $3  : user-name            - name of the user
##
declare user_name='';
##
## command line argument $4  : user-email           - email of the user
##
declare user_email='';
##
## command line argument $5  : merge-ff             - how a merge is handled
##
## git merge --ff-only : merge.ff = only
## git merge --ff      : merge.ff = true
## git merge --no-ff   : merge.ff = false
##
declare merge_ff='';
##
## command line argument $6  : pull-ff              - how a pull is handled
##
## git pull --ff-only : pull.ff = only
## git pull --ff      : pull.ff = true
## git pull --no-ff   : pull.ff = false
##
declare pull_ff='';
##
## command line argument $7  : tracked-repositories - set of tracked repositories
##
declare -a tracked_repositories=();
##
## command line argument $8  : project-name         - name of the project
##
declare project_name='';
##
## command line argument $9  : package-name         - name of the package
##
declare package_name='';
##
## command line argument $10 : git-files            - Git configuration files
##
declare -a git_files=();



## command line argument ??? : pull_rebase          - how a rebase is handled
##
## git pull --rebase='false'       : pull.rebase = false
## git pull --rebase='true'        : pull.rebase = true
## git pull --rebase='interactive' : pull.rebase = interactive
## git pull --rebase='merges'      : pull.rebase = merges
##
declare pull_rebase=''; # unused



################################################################################
##
## Get content of configuration file.
##
################################################################################
#
if [[ -f './config.inc.bash' ]]; then
  source './config.inc.bash';
else
  :;
fi



################################################################################
##
## Get the command line arguments.
##
################################################################################
##
## Check number of arguments.
##
if (( 10 == "${#}" )); then
  :;
else
  echo 'Error: wrong number of arguments.';
  exit 1;
fi
##
## command line argument $1  : repository-path      - path to the directory
##
repository_path="${1}";
repository_path="$( echo "${repository_path}" | sed 's/[/]*$//g' )";
                                                                                #echo "repository_path : '${repository_path}'";
##
## command line argument S2  : repository-name      - name of the repository
##
repository_name="${2}";
                                                                                #echo "repository_name : '${repository_name}'";
##
## command line argument $3  : user-name            - name of the user
##
user_name="${3}";
                                                                                #echo "user_name       : '${user_name}'";
##
## command line argument $4  : user-email           - email of the user
##
user_email="${4}";
                                                                                #echo "user_email      : '${user_email}'";
##
## command line argument $5  : merge-ff             - how a merge is handled
##
merge_ff="${5}";
                                                                                #echo "merge_ff        : '${merge_ff}'";
##
## command line argument $6  : pull-ff              - how a pull is handled
##
pull_ff="${6}";
                                                                                #echo "pull_ff         : '${pull_ff}'";
##
## command line argument $7  : tracked_repositories - set of tracked repositories
##
IFS=';' read -a 'tracked_repositories' -r <<< "${7}";
                                                                                #echo "tracked_repositories         : '${tracked_repositories[@]}' (${#tracked_repositories[@]})";
##
## command line argument $8  : project-name         - name of the project
##
project_name="${8}";
                                                                                #echo "project_name    : '${project_name}'";
##
## command line argument $9  : package-name         - name of the package
##
package_name="${9}";
                                                                                #echo "package_name    : '${package_name}'";
##
## command line argument $10 : git-files            - Git configuration files
##
IFS=';' read -a 'git_files' -r <<< "${10}";
                                                                                #echo "git_files       : '${git_files[@]}' (${#git_files[@]})";



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
declare tracked_repository='';
declare -a key_value=();
for tracked_repository in "${tracked_repositories[@]}"; do
  key_value=();
  IFS=',' read -a 'key_value' -r <<< "${tracked_repository}";
  git remote add "${key_value[0]}" "${key_value[1]}";
done;
##
echo '... done';



################################################################################
##
## Initial commit of the repository.
##
################################################################################
##
echo "Info: committing as initial commit '${REPOSITORY}'. ...";
##
git commit --allow-empty --message="$( echo "Initial commit of ${project_name} ${package_name}." | fold --spaces --width='50' )";
##
echo '... done';



################################################################################
##
## Create und commit Git configuration files.
##
################################################################################
##
echo "Info: creating git configuration files in '${REPOSITORY}'. ...";
##
declare git_file='';
for git_file in "${git_files[@]}"; do
  touch "./${git_file}";
  git add "./${git_file}";
  git commit --message="$( echo "Add Git configuration file." | fold --spaces  --width='50' )

$( echo "* ${git_file}: add configuration file." | fold --spaces  --width='72' )";
done
##
echo '... done';



################################################################################
##
## Cleanup and optimize the repository.
##
################################################################################
##
echo "Info: cleaning and optimizing '${REPOSITORY}'. ...";
##
git gc;
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
