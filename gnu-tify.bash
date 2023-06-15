#! /usr/bin/env -S bash -e
################################################################################
##
## This file is part of the RaSt git-gnu-project package.
##
## RaSt  git-gnu-project is  to manage  a directory  as a  Git and  a GNU  style
## project.
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
## this package.  If not, see <https://www.gnu.org/licenses/>.
##
################################################################################



################################################################################
##
## $Version: 0.2.0 (2023-06-12 03:10:51 +00:00:00) $
##
################################################################################



################################################################################
##
## GNU-TIFY.BASH - 1 - 2023-06-12 - RaSt - RaSt git-gnu-project Manual
##
## NAME
##
##   gnu-tify.bash - manage directory as GNU style project
##
## SYNOPSIS
##
##   gnu-tify.bash
##
##   ???
##
## DESCRIPTION
##
##   RaSt gnu-tify.bash is  a Bash script to  manage a directory as  a GNU style
##   project.
##
##   The directory then contains a GNU style project tree for program, library, documentation or package projects.
##
##   ???
##
## OPTIONS
##
##   ???
##
## IMPLEMENTATION NOTES
##
## ENVIRONMENT
##
## FILES
##
##   gnu-tify.bash           - this script
##   config.inc.bash         - configuration file
##   config.inc.bash.example - example configuration file
##
## EXIT STATUS
##
##   on success: $? == 0
##   on failure: $? >  0
##
## EXAMPLES
##
##   gnu-tify.bash
##
##   ???
##
##   gnu-tify.bash --help
##
##   gnu-tify.bash --version
##
## DIAGNOSTICS
##
## SEE ALSO
##
##   Report bugs to:
##   Package home page:
##   General help using RaSt software:
##
##     https://github.com/RaStBh/
##     https://gitlab.com/RaStBh/
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



################################################################################
##
## GLOBAL CONSTANTS
##
################################################################################



################################################################################
##
## GLOBAL VARIABLES
##
################################################################################



################################################################################
##
## FUNCTONS
##
################################################################################



################################################################################
##
## TESTS
##
################################################################################



## @brief Test directory.
## @details Test directory.
##   1. See if there is the directory 'dirname'.
##      On yes: continue.
##      On no:  exit.
##   2. See if there is the directry 'basename'.
##      On yes: continue.
##      On no:  exit.
## @param[in] dirname
##   The dirname, for example </home/john_dow/repositories/>.
## @param[in] basename
##   The basename, for example <foobar>.
## @return
##   The exit code of last command.

function testDirectory()
{
  # The dirname.

  local dirname="${1}";

  # The basename.

  local basename="${2}";

  # Test the directory.

  if [[ -d "${dirname}" ]]; then
  # do nothing
    :;
  else
    echo "Error: no such directory '${dirname}'.";
    exit 1;
  fi
  cd "${dirname}";
  if [[ -d "./${basename}" ]]; then
    # do nothing
    :;
  else
    echo "Error: directory '${dirname}/${basename}/' does not exist.";
    exit 1;
  fi

  # Return from the function.

  return;
}



## @brief Ask the user for confirmation.
## @details Ask the user for confirmation.
##   1. Ask the user.
##   2  On 'n', 'no', 'N', 'NO', 'nO', ...   : exit.
##      On 'y', 'yes', 'Y', 'YES', 'yES', ...: continue.
## @return
##   The exit code of the last command.

function askConfirmation()
{
  # The confirmation from the user.

  local confirmation='';

  # Get confirmation from the user.

  read -p "Create project tree in '${dirname}/${basename}/'? (y/n): " 'confirmation';
  confirmation="${confirmation,,}";

  # See what the user answered.  On 'yes' continue.  On 'no' exit.

  case "${confirmation}" in
    'n' | 'no' )
      echo 'Info: aborded by user.';
      exit 0;
      ;;
    'y' | 'yes' )
      # do nothing
      ;;
    * )
      echo "Error: unkown confirmation '${confirmation}'.";
      exit 1;
      ;;
  esac

  # Return from the function.

  return;
}



## @brief Cleanup and optimize the repository.
## @details Cleanup and optimize the repository.
## @return
##   The exit code of the last command.

function runHousekeeping()
{
  # Cleanup and optimize the repository.

  git gc;

  # Return from the function.

  return;

}



################################################################################
##
## MAIN
##
################################################################################



## @brief The main function.
## @details The main function.
##   The script starts here.
## @ param[in] arguments
##   The command line arguments.
## @return
##   The exit code of the last command.

function main()
{
  # Get the command line arguments.

  local -a arguments=( "${@}" );

  # The Version of this script.

  local version="$( cat << 'END'
gnu-tify.bash (RaSt git-gnu-project)
0.2.0 (2023-06-12 03:10:51 +00:00:00)
Copyright (C)  2023  Ralf Stephan  <me@ralf-stephan.name>
License GPLv3+ (GNU GPL version 3 or later,
see <https://gnu.org/licenses/gpl.html>)
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
END
)";

  # The usage of the script

  local usage=" cat << 'END'
SYNOPSIS

  git-tify.bash

  ???

OPTIONS

  ???

END
";

  # The Git working directory.

  local working_directory='';

  # The  Git  repository  directory.

  local repository_directory='';

  # GNU standard readme files.

  local -a readme_files=();

  # The package type.

  local type='';

  # Package project tree - common files and directories.

  local -a common_tree=();

  # Package project tree - files and directories for program projects.

  local -a pogram_tree=();

  # Package project tree - files and directories for library projects.

  local -a library_tree=();

  # Package project tree - files and directories for document projects.

  local -a document_tree=();

  # Package project tree - files and directories for package projects.

  local -a package_tree=();

  # The Legal notice.

  local legal_notice='';

  # Files containing licenses texts.

  local -a license_files=();

  # Get the command line arguments.

  local short_options='';
  local long_options='';

  # Get the variables from the configuration file if the file it is present.

  if [[ -f './config.inc.bash' ]]; then
    echo "Info: configuration file './config.inc.bash' present.";
    echo "Info: loading configuraton file './config.inc.bash'.";
    source './config.inc.bash';
  else
    echo "Info: configuration file './config.inc.bash' not present.";
    echo "Info: not loading configuraton file './config.inc.bash'.";
  fi

  eval arguments=( "$( getopt --alternative \
                              --options "${short_options}" \
                              --longoptions "${long_options}" \
                              --shell 'bash' \
                              -- \
                              "${@}" )" );

  # See if the variables are set and not empty.

  if [[ -n "${working_directory}" ]]; then
    echo "Info: variable 'working_directory' (${working_directory}) present.";
  else
    echo "Error: variable 'working_directory' not present.";
    exit 1;
  fi
  if [[ -n "${repository_directory}" ]]; then
    echo "Info: variable 'repository_directory' (${repository_directory}) present.";
  else
    echo "Error: variable 'repository_directory' not present.";
    exit 1;
  fi
  if (( 0 < "${#readme_files[@]}" )); then
    echo "Info: variable 'readme_files' (${#readme_files[@]}) (${readme_files[@]}) present.";
  else
    echo "Error: variable 'readme_files' not present.";
    exit 1;
  fi
  if [[ -n "${type}" ]]; then
    echo "Info: variable 'type' (${type}) present.";
  else
    echo "Error: variable 'type' not present.";
    exit 1;
  fi
  if (( 0 <= "${#common_tree[@]}" )); then
    echo "Info: variable 'common_tree' (${#common_tree[@]}) (${common_tree[@]}) present.";
  else
    echo "Error: variable 'common_tree' not present.";
    exit 1;
  fi
  if (( 0 < "${#pogram_tree[@]}" )); then
    echo "Info: variable 'pogram_tree' (${#pogram_tree[@]}) (${pogram_tree[@]}) present.";
  else
    echo "Error: variable 'pogram_tree' not present.";
    exit 1;
  fi
  if (( 0 < "${#library_tree[@]}" )); then
    echo "Info: variable 'library_tree' (${#library_tree[@]}) (${library_tree[@]}) present.";
  else
    echo "Error: variable 'library_tree' not present.";
    exit 1;
  fi
  if (( 0 < "${#document_tree[@]}" )); then
    echo "Info: variable 'document_tree' (${#document_tree[@]}) (${document_tree[@]}) present.";
  else
    echo "Error: variable 'document_tree' not present.";
    exit 1;
  fi
  if (( 0 < "${#package_tree[@]}" )); then
    echo "Info: variable 'package_tree' (${#package_tree[@]}) (${package_tree[@]}) present.";
  else
    echo "Error: variable 'package_tree' not present.";
    exit 1;
  fi
  if (( 0 < "${#license_files[@]}" )); then
    echo "Info: variable 'license_files' (${#license_files[@]}) (${license_files[@]}) present.";
  else
    echo "Error: variable 'license_files' not present.";
    exit 1;
  fi
  if [[ -n "${legal_notice}" ]]; then
    echo "Info: variable 'legal_notice' (${legal_notice}) present.";
  else
    echo "Error: variable 'legal_notice' not present.";
    exit 1;
  fi

  # See if we have a GNU working directory.

  local dirname="$( dirname "${working_directory}" )";
  local basename="$( basename "${working_directory}" )";
  testDirectory "${dirname}" "${basename}";
  working_directory="${dirname}/${basename}/";

  # Ask the user for confirmation before creating the Git working directory.

  askConfirmation;

  # Change the Bash working directory to the Git working directory.

  echo "Info: changing directory to '${working_directory}' ...";
  cd "${working_directory}";
  echo '... done';

  # Create GNU standard readme files.
  # If there is a Git repository in the working directory, add files to the repository.

  echo "Info: creating readme files in '${working_directory}' ...";
  local readme_file='';
    for readme_file in "${readme_files[@]}"; do
      echo "
${legal_notice}" > "./${readme_file}";
      if [[ 'true' == "$( git rev-parse --is-inside-work-tree 2> /dev/null )" ]]; then
        git add "./${readme_file}";
        git commit --message="$( echo "Add file." | fold --spaces --width='50' )

$( echo "* ${readme_file}: add file." | fold --spaces --width='72' )";
      else
        # do nothing
        :;
      fi
    done
  echo '... done';

  # Create the project tree.

  echo "Info: creating GNU project in '${working_directory}' ...";
  local -a project_tree=();
  if   [[ 'prg' == "${type}" ]]; then
    project_tree=( "${common_tree[@]}" "${pogram_tree[@]}" );
  elif [[ 'lib' == "${type}" ]]; then
    project_tree=( "${common_tree[@]}" "${library_tree[@]}" );
  elif [[ 'doc' == "${type}" ]]; then
    project_tree=( "${common_tree[@]}" "${document_tree[@]}" );
  elif [[ 'pkg' == "${type}" ]]; then
    project_tree=( "${common_tree[@]}" "${package_tree[@]}" );
  else
    echo "Error: unknown package type '${type}'.";
  fi
  local project_item='';
  for project_item in "${project_tree[@]}"; do
    mkdir -p "$( dirname "./${project_item}" )";
    echo "
${legal_notice}" > "./${project_item}";
    if [[ 'true' == "$( git rev-parse --is-inside-work-tree 2> /dev/null )" ]]; then
      git add "./${project_item}";
      git commit --message="$( echo "Add file." | fold --spaces --width='50' )

$( echo "* ${project_item}: add file." | fold --spaces --width='72' )";
    else
      # do nothing
      :;
    fi
  done
  echo '... done';

  # Copy licenses files.

  echo "Info: copying licenses files to '${working_directory}' ...";
  local index=0;
  local -a key_value=();
  local key='';
  local value='';
  for (( index=0; index<"${#license_files[@]}"; index++ )); do
    # Split the files into the key and the value.

    key_value=();
    key='';
    value='';
    IFS=';' read -a 'key_value' -r <<< "${license_files[${index}]}";
    key="${key_value[0]}";
    value="${key_value[1]}";# See that the key is not empty.

    if [[ -n "${key}" ]]; then
      # do nothing
      :;
    else
      echo "Error: variable 'remotes' has empty key (${value}).";
      exit 1;
    fi

    # See the key has a value.

    if [[ -n "${value}" ]]; then
      # do nothing
      :;
    else
      echo "Error: variable 'remotes' key (${key}) has empty value.";
      exit 1;
    fi

    # Copy the license files.

    cat "${value}" > "./${key}";
    if [[ 'true' == "$( git rev-parse --is-inside-work-tree 2> /dev/null )" ]]; then
      git add "./${key}";
      git commit --message="$( echo "Add file." | fold --spaces --width='50' )

$( echo "* ${key}: add file." | fold --spaces --width='72' )";
    else
      # do nothing
      :;
    fi
  done
  echo '... done';

  # Cleanup and optimize the Git repository.

  echo "Info: cleaning and optimizing Git repository in '${working_directory}' ...";
  runHousekeeping;
  echo '... done';

  # Return from the function.

  return;
}

# Call the main function and pass the command line arguments.

main "${@}";



################################################################################
##
## EXIT
##
################################################################################

exit;
