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
## $Date: 2023-06-07 08:13:01.1005513000 +00:00:00 $
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
## git-tify.bash [--repository-path=<path to the directory>]
## [--repository-name=<name of the repository>] [--user-name=<name of the user>]
## [--user-email=<email of the user>] [--merge-ff=<how a merge is handled>]
## [--pull-ff=<how a pull is handled>]
## [--tracked-repository=<repository to track>]
## [--project-name=<name of the project>] [--package-name=<name of the package>]
## [--git-file=<Git configuration file>]
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
## OPTIONS
##
## --repository-path=<path to the directory>
##
##   set path to the directory
##
## --repository-name=<name of the repository>
##
##   set name of the repository
##
## --user-name=<name of the user>
##
##   set name of the user locally and globally
##
## --user-email=<email of the user>
##
##   set email of the user locally and globally
##
## --merge-ff=<how a merge is handled>
##
##   set how a merge is handled
##
##   only
##   true
##   false
##
## --pull-ff=<how a pull is handled>
##
##   set how a pull is handled
##
##   only
##   true
##   false
##
## --tracked-repository=<repository to track>
##
##   add repository to track
##
##   The string  is composed of  the remote name  followed by the  ',' character
##   followed by the remote URL.
##
## --project-name=<name of the project>
##
##   set name of the project
##
## --package-name=<name of the package>
##
##   set name of the package
##
## --git-file=<Git configuration file>
##
##   add Git configuration file
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
## --repository-path='/home/user/JohnDow/repositories/' \
## --repository-name='foobar' \
## --user-name='John Dow' \
## --user-email='john.dow@example.com' \
## --merge-ff='false' \
## --pull-ff'false' \
## --tracked-repository='github.com,git@github.com-JohnDow:JohnDow' \
## --tracked-repository='gitlab.com,git@gitlab.com-JohnDow:JohnDow;example.com' \
## --tracked-repository='example.com,ssh://JohnDow@example.com/home/JohnDow/repositories/foobar/' \
## --project-name'JD' \
## --package-name='foobar' \
## --git-file='.gitattributes' \
## --git-file='.gitignore' \
## --git-file='.gitkeep' \
## --git-file='.gitmodules' \
## --git-file='.mailmap'
##
## For how to use the configuration file config.inc.bash see the file itself.
##
## DIAGNOSTICS  (For sections 1, 4, 6, 7, 8, and 9 printf/stderr messages only.)
##
## ERRORS                     (For sections 2, 3, 4, and 9 errno settings only.)
##
## SEE ALSO
##
## You can get git-gnu-project from <https://github.com/RaStBh/git-gnu-project>
## or <https://gitlab.com/RaStBh/git-gnu-project>.
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
## repository-path      - path to the directory
##
declare repository_path='';
##
## repository-name      - name of the repository
##
declare repository_name='';
##
## user-name            - name of the user
##
declare user_name='';
##
## user-email           - email of the user
##
declare user_email='';
##
## merge-ff             - how a merge is handled
##
## git merge --ff-only : merge.ff = only
## git merge --ff      : merge.ff = true
## git merge --no-ff   : merge.ff = false
##
declare merge_ff='';
##
## pull-ff              - how a pull is handled
##
## git pull --ff-only : pull.ff = only
## git pull --ff      : pull.ff = true
## git pull --no-ff   : pull.ff = false
##
declare pull_ff='';
##
## tracked-repositories - list of tracked repositories
##
declare -a tracked_repositories=();
##
## project-name         - name of the project
##
declare project_name='';
##
## package-name         - name of the package
##
declare package_name='';
##
## git-files            - list of Git configuration files
##
declare -a git_files=();



## pull_rebase          - how a rebase is handled
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
## Parse command line options names and arguments.
##
################################################################################
##
## Declare the command line option names and option arguments.
##
declare short_options='';
##
declare long_options='';
long_options+='repository-path:,';
long_options+='repository-name:,';
long_options+='user-name:,';
long_options+='user-email:,';
long_options+='merge-ff:,';
long_options+='pull-ff:,';
long_options+='tracked-repository:,';
long_options+='project-name:,';
long_options+='package-name:,';
long_options+='git-file:,';
##
## Parse the command line options.
##
declare -a arguments=();
eval arguments=( "$( getopt --alternative \
                             --options "${short_options}" \
                             --longoptions "${long_options}" \
                             --shell 'bash' \
                             -- \
                             "${@}" )" );

                                                                                #echo "arguments: '${arguments[@]}' (${#arguments[@]})"
##
## Parse the command line options and command line arguments.
##
declare option_name='';
declare option_argument='';
declare -i previous_position=0;
declare -i current_position=0;
declare -i next_position=0;
                                                                                #echo ">>> next_position  : '${next_position}'";
while true; do
  option_name="${arguments[$(( "${current_position}" + 0 ))]}";
                                                                                #echo ">>> option_name    : '${option_name}'";
  option_argument="${arguments[$(( "${current_position}" + 1 ))]}";
  option_argument="$( echo "${option_argument}" | sed "s/^'//g" )";
  option_argument="$( echo "${option_argument}" | sed "s/'$//g" )";
                                                                                #echo ">>> option_argument: '${option_argument}'";
  next_position="$(( "${next_position}" + 1 ))";
                                                                                #echo ">>> next_position  : '${next_position}'";
  case "${option_name}" in
    '--repository-path' )
      repository_path="${option_argument}";
      next_position="$(( "${next_position}" + 1 ))";
      ;;
    '--repository-name' )
      repository_name="${option_argument}";
      next_position="$(( "${next_position}" + 1 ))";
      ;;
    '--user-name' )
      user_name="${option_argument}";
      next_position="$(( "${next_position}" + 1 ))";
      ;;
    '--user-email' )
      user_email="${option_argument}";
      next_position="$(( "${next_position}" + 1 ))";
      ;;
    '--merge-ff' )
      if   [[ 'only' == "${option_argument}" ]] \
        || [[ 'true' == "${option_argument}" ]] \
        || [[ 'false' == "${option_argument}" ]]; then
        merge_ff="${option_argument}";
        next_position="$(( "${next_position}" + 1 ))";
      else
        echo "Error: wrong option argument '${option_argument}' for option name '${option_name}'." 1>&2;
        exit 1;
      fi
      ;;
    '--pull-ff' )
      if   [[ 'only' == "${option_argument}" ]] \
        || [[ 'true' == "${option_argument}" ]] \
        || [[ 'false' == "${option_argument}" ]]; then
        pull_ff="${option_argument}";
        next_position="$(( "${next_position}" + 1 ))";
      else
        echo "Error: wrong option argument '${option_argument}' for option name '${option_name}'." 1>&2;
        exit 1;
      fi
      ;;
    '--tracked-repository' )
      tracked_repositories["${#tracked_repositories[@]}"]="${option_argument}";
      next_position="$(( "${next_position}" + 1 ))";
      ;;
    '--project-name' )
      project_name="${option_argument}";
      next_position="$(( "${next_position}" + 1 ))";
      ;;
    '--package-name' )
      package_name="${option_argument}";
      next_position="$(( "${next_position}" + 1 ))";
      ;;
    '--git-file' )
      git_files["${#git_files[@]}"]="${option_argument}";
      next_position="$(( "${next_position}" + 1 ))";
      ;;
    '--' )
      break 1;
      ;;
    *)
      echo "Error: unknown option name '${option_name}'." 1>&2;
      exit 1;
      ;;
  esac
  previous_position="${current_position}";
  current_position="${next_position}";
done
                                                                                #echo "repository_path      : '${repository_path}'";
                                                                                #echo "repository_name      : '${repository_name}'";
                                                                                #echo "user_name            : '${user_name}'";
                                                                                #echo "user_email           : '${user_email}'";
                                                                                #echo "merge_ff             : '${merge_ff}'";
                                                                                #echo "pull_ff              : '${pull_ff}'";
                                                                                #echo "tracked_repositories :";
                                                                                #for (( index=0; index<"${#tracked_repositories[@]}"; index++ )); do
                                                                                #  echo "  ${index}: '${tracked_repositories[${index}]}'";
                                                                                #done
                                                                                #echo "project_name         : '${project_name}'";
                                                                                #echo "package_name         : '${package_name}'";
                                                                                #echo "git_files            :";
                                                                                #for (( index=0; index<"${#git_files[@]}"; index++ )); do
                                                                                #  echo "  ${index}: '${git_files[${index}]}'";
                                                                                #done



################################################################################
##
## See  if we  can create  a new  Git repository.   If OK,  then change  working
## directory and create the new directory.
##
################################################################################
##
## See if there is the directory $repository_path.
##
if [[ -d "${repository_path}/" ]]; then
  :;
else
  echo "Error: directory '${repository_path}/' does not exist." 1>&2;
  exit 1;
fi
##
cd "${repository_path}/";
##
## See if there is a directory $repository_name is directory $repository_path.
##
if [[ -d "./${repository_name}/" ]]; then
  echo "Error: directory '${repository_path}/${repository_name}/' does exist." 1>&2;
  exit 1;
else
  :;
fi
##
declare confirm='';
read -p "Create repository in '${repository_path}/${repository_name}/' (y/n)? " 'confirm';
confirm="$( echo "${confirm}" | tr '[:upper:]' '[:lower:]' )";
case "${confirm}" in
  'y' | 'yes' )
    echo "Info: create repository in '${repository_path}/${repository_name}/'." 1>&2;
    ;;
  'n' | 'no'  )
    echo 'Info: creating repository aborded.';
    exit 0;
    ;;
  * )
    echo "Error: unknown '${confirm}'" 1>&2;
    exit 1;
    ;;
esac
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
echo "Info: create and initialize an empty repository in '${repository_path}/${repository_name}/'. ..." 1>&2;
##
git init --initial-branch='master' --template='' './';
##
echo '... done' 1>&2;



################################################################################
##
## Configure the Git repository.
##
################################################################################
##
echo "Info: configuring repository '${repository_path}/${repository_name}/'. ..." 1>&2;
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
echo '... done' 1>&2;



################################################################################
##
## Initial commit of the repository.
##
################################################################################
##
echo "Info: committing as initial commit '${REPOSITORY}'. ..." 1>&2;
##
git commit --allow-empty --message="$( echo "Initial commit of ${project_name} ${package_name}." | fold --spaces --width='50' )";
##
echo '... done' 1>&2;



################################################################################
##
## Create und commit Git configuration files.
##
## If file already exists, then exit.
##
################################################################################
##
echo "Info: creating git configuration files in '${REPOSITORY}'. ..." 1>&2;
##
declare git_file='';
for git_file in "${git_files[@]}"; do
  if [[ -f "./${git_file}" ]]; then
    echo "Error: Git configuration file './${git_file}' already exists." 1>&2;
    exit 1;
  else
    touch "./${git_file}";
    git add "./${git_file}";
    git commit --message="$( echo "Add Git configuration file." | fold --spaces  --width='50' )

$( echo "* ${git_file}: add configuration file." | fold --spaces  --width='72' )";
  fi
done
##
echo '... done' 1>&2;



################################################################################
##
## Cleanup and optimize the repository.
##
################################################################################
##
echo "Info: cleaning and optimizing '${REPOSITORY}'. ..." 1>&2;
##
git gc;
##
echo '... done' 1>&2;



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
