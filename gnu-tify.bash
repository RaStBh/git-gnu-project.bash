#! /usr/bin/env -S bash -e
################################################################################
##
## This file is part of RaSt git-gnu-project.
##
## RaSt git-gnu-project is to  manage a directory as a Git  repository and a GNU
## package.
##
## Copyright (C)  2023  Ralf Stephan  <me@ralf-stephan.name>
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
##
##
##
################################################################################
##
## $Date: 2023-06-07 15:51:53.8110411000 +00:00:00 $
##
################################################################################
##
##
##
################################################################################
##
## git-tify.bash (git-gnu-project)
##
## NAME
##
##   gnu-tify.bash - manage a directory as a GNU package.
##
## SYNOPSIS
##
##   gnu-tify.bash
##   [--repository-path=<path to the directory>]
##   [--repository-name=<name of the repository>]
##   [--package_type=<package type>]
##   [--copying_file=<copying file>]
##
## DESCRIPTION
##
##   Manage a directory as a Git repository.
##
##   Step 1: Add GNU standard readme files.
##   Step 2: Add GNU All-Permissive License to the files.
##   Step 3: Add files to the repository.
##   Step 4: Add files for project tree.
##
## OPTIONS
##
##   --repository-path - set path to the directory
##   --repository-name - set name of the repository
##   --package_type    - set package type
##   --copying_file    - add copying file
##
## IMPLEMENTATION NOTES
##
## ENVIRONMENT
##
## FILES
##
##   gnu-tify.bash           - this script
##   config.inc.bash         - used configuration file
##   config.inc.bash.example - example configuration file
##
## EXIT STATUS
##
##   on success: 0
##   on failure: 1
##
## EXAMPLES
##
##   ./git-tify.bash
##   --repository-path='/home/user/JohnDow/repositories/' \
##   --repository-name='foobar' \
##   --package_type='pkg' \
##   --copying_file='COPYING,home/JohnDow/licenses/gnu_gpl-3.0.txt'
##
## DIAGNOSTICS
##
## SEE ALSO
##
## STANDARDS
##
## HISTORY
##
## AUTHORS
##
##   Ralf Stephan <me@ralf-stephan.name>
##
## CAVEATS
##
## BUGS
##
## SECURITY CONSIDERATIONS
##
################################################################################
##
##
##
################################################################################
##
## Global constants.
##
################################################################################
##
declare -r LICENSE_COPYRIGHT_NOTICE="
## This file is part of ABC foo-bar.
##
## ABC foo-bar is to convert foo into bar.
##
## Copyright (C)  1234  ABC, Inc.  <abc_inc@example.com>
##
## GNU All-Permissive  License: Copying and  distribution of this file,  with or
## without modification,  are permitted in  any medium without  royalty provided
## the copyright  notice and this  notice are  preserved.  This file  is offered
## as-is, without any warranty.";
##
##
##
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
declare package_type='';
##
declare -A copying_files=();
##
##
##
################################################################################
##
## Get content of configuration file.
##
################################################################################
##
if [[ -f './config.inc.bash' ]]; then
  source './config.inc.bash';
else
  :;
fi
##
##
##
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
long_options+='package_type:,';
long_options+='copying_files:,'; # ??? todo
#
## Parse the command line options.
##
declare -a arguments=();
eval arguments=( "$( getopt --alternative \
                             --options "${short_options}" \
                             --longoptions "${long_options}" \
                             --shell 'bash' \
                             -- \
                             "${@}" )" );
##
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
    'package_type' )
      repository_name="${package_type}";
      next_position="$(( "${next_position}" + 1 ))";
      ;;
    'copying_file' )
      copying_files["${#copying_files[@]}"]="${option_argument}";
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
                                                                                #echo "package_type         : '${package_type}'";
                                                                                #echo "copying_files        :";
                                                                                #for (( index=0; index<"${#copying_files[@]}"; index++ )); do
                                                                                #  echo "  ${index}: '${copying_files[${index}]}'";
                                                                                #done
##
## Remove trailing '/'.
##
repository_path="$( echo "${repository_path}" | sed 's/[\/]*$//' )";
##
##
##
################################################################################
##
## See if we have the given directory.  If OK, then change working directory and
## create the new directory.
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
## See if there is a directory $repository_name in directory $repository_path.
##
if [[ -d "./${repository_name}/" ]]; then
  :;
else
  echo "Error: directory '${repository_path}/${repository_name}/' does not exist." 1>&2;
  exit 1;
fi
##
## Ask for confirmation.
##
declare confirm='';
read -p "Create package in '${repository_path}/${repository_name}/' (y/n)? " 'confirm';
confirm="$( echo "${confirm}" | tr '[:upper:]' '[:lower:]' )";
case "${confirm}" in
  'y' | 'yes' )
    echo "Info: create package in '${repository_path}/${repository_name}/'." 1>&2;
    ;;
  'n' | 'no'  )
    echo 'Info: creating package aborded.';
    exit 0;
    ;;
  * )
    echo "Error: unknown '${confirm}'" 1>&2;
    exit 1;
    ;;
esac
##
## Change directory.
##
cd "./${repository_name}/";
##
##
##
################################################################################
##
## Add GNU standard readme files.
##
## Add GNU All-Permissive License.
##
## If we are in  a Git working directory we add and commit  the files to the Git
## repository.
##
################################################################################
##
echo "Info: create readme files in '${repository_path}/${repository_name}/'. ..." 1>&2;
##
declare gnu_file='';
for gnu_file in "${gnu_files[@]}"; do
    touch "./${gnu_file}";
    echo "${LICENSE_COPYRIGHT_NOTICE}" > "./${gnu_file}";
    if [[ 'true' == "$( git rev-parse --is-inside-work-tree 2> /dev/null )" ]]; then
      git add "./${gnu_file}";
      git commit --message="$( echo "Add GNU standard readme file." | fold --spaces  --width='50' )

$( echo "* ${git_file}: add GNU standard readme file." | fold --spaces  --width='72' )";
    else
      :;
    fi
done
##
echo '... done' 1>&2;
##
##
##
################################################################################
##
## Create project tree.
## The project tree depends on the type of project.
##
################################################################################
##
echo "Info: creating project tree in '${repository_path}/${repository_name}/'. ..." 1>&2;
##
declare -a project_files=();
if   [[ 'prg' == "${package_type}" ]]; then
  echo "... project type: prg ..." 1>&2;
  project_files=( "${project_tree_prg[@]}" );
  :;
elif [[ 'lib' == "${package_type}" ]]; then
  echo "... project type: lib ..." 1>&2;
  project_files=( "${project_tree_lib[@]}" );
  :;
elif [[ 'doc' == "${package_type}" ]]; then
  echo "... project type: doc ..." 1>&2;
  project_files=( "${project_tree_doc[@]}" );
  :;
elif [[ 'pkg' == "${package_type}" ]]; then
  echo "... project type: pkg ..." 1>&2;
  project_files=( "${project_tree_pkg[@]}" );
  :;
else
  echo "Error: unknow package type '${project_type}'";
  exit 1;
fi
##
declare project_file='';
for project_file in "${project_files[@]}"; do
    if [[ '.' == "$( dirname "${project_file}"' ' )" ]]; then
      :;
    else
      mkdir -p "$( dirname "${project_file}"' ' )";
    fi
    touch "${project_file}";
    if   [[ 'COPYING.PRG' == "$( basename "${project_file}" )" ]]; then
      cp "${copying_files[COPYING.PRG]}" "./COPYING.PRG";
    elif [[ 'COPYING.LIB' == "$( basename "${project_file}" )" ]]; then
      cp "${copying_files[COPYING.LIB]}" "./COPYING.LIB";
    elif [[ 'COPYING.DOC' == "$( basename "${project_file}" )" ]]; then
      cp "${copying_files[COPYING.DOC]}" "./COPYING.DOC";
    else
      :;
    fi
done
##
echo '... done' 1>&2;
##
##
##
################################################################################
##
## TESTS
##
################################################################################
##
##
##
################################################################################
##
## Exit the shell.
##
################################################################################
##
exit 0;
