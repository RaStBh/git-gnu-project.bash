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
## $Date: 2023-06-10 04:07:40.7345884000 +00:00:00 $
##
################################################################################



################################################################################
##
## GIT-TIFY.BASH - 1 - 2023-06-10 - RaSt - RaSt git-gnu-project Manual
##
## NAME
##
##   git-tify.bash - manage a directory as Git and GNU style project
##
## SYNOPSIS
##
##   git-tify.bash
##
##   ???
##
## DESCRIPTION
##
##   RaSt git-gnu-project is a collection of  Bash scripts to manage a directory
##   as a Git and a GNU style project.
##
##   The directory then  is a Git working directory containing  a Git repository
##   directory.
##
##   The  Git working  directory  is  for example  </home/john_dow/repositories/
##   foobar/>.
##
##   The Git  repository directory is for  example </home/john_dow/repositories/
##   foobar/.git>.
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
##   git-tify.bash           - this script
##   config.inc.bash         - the configuration file
##   config.inc.bash.example - the example configuration file
##
## EXIT STATUS
##
##   on success: $? == 0
##   on failure: $? >  0
##
## EXAMPLES
##
##   git-tify.bash
##
##   ???
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



## @brief Test directory.
## @details Test directory.
##   1. See if there is the directory 'dirname'.
##      On yes continue.
##      On no exit.
##   2. See if there is the directry 'basename'.
##      On yes exit.
##      On no  continue.
## @return
##   The exit code of last command.

function testDirectory()
{
  # The dirname.

  local dirname="${1}";

  # The basename.

  local basename="${2}";

  # Test the directory 'dirname/basename/'.

  if [[ -d "${dirname}" ]]; then
  # do nothing
    :;
  else
    echo "Error: no such directory '${dirname}'.";
    exit 1;
  fi
  cd "${dirname}";
  if [[ -d "./${basename}" ]]; then
    echo "Error: directory '${dirname}/${basename}/' already exists.";
    exit 1;
  else
    # do nothing
    :;
  fi

  # Return from function.

  return;
}


## @brief Ask for confirmation.
## @details Ask for confirmation.
##   1. Ask the user.
##   2  On 'n', 'no', 'N', 'NO', 'nO', ... exit.
##      On 'y', 'yes', 'Y', 'YES', 'yES', ... continue.
## @return
##   The exit code of last command.

function askConfirmation()
{
  # The confirmation from user.

  local confirmation='';

  # Get confirmation from user.

  read -p "Create repository in '${dirname}/${basename}/'? (y/n): " 'confirmation';
  confirmation="${confirmation,,}";

  # See what the user answered.  On 'yes' continue. On 'no' exit.

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

  # Return from function.

  return;
}



## @brief Create a directory.
## @details Create a directory.
##   Create the directory.
##   Check presence of the directory.
## @param[in] directory
##  The directory to create.
## @return
##   The exit code of last command.

function createDirectory()
{
  # The directory to create.

  local directory="${1}";

  # Create the directory.

  mkdir "${directory}";

  # See if we created the directory.

  if [[ -d "${directory}" ]]; then
    echo "Info: directory '${directory}' created.";
  else
    echo "Error: directory '${directory}' not created.";
    exit 1;
  fi

  # Return from function.

  return;
}



## @brief Initialize a Git repository.
## @details Initialize a Git repository.
##   1. Create the Git repository.
##   2. See if the Git repository have been created.
## @return
##   The exit code of last command.

function initializeGitRepository()
{
  # Initialize the Git Repository.

  git init --initial-branch='master' --template='' ./;

  # See if the Git repository have been created.

  if [[ 'true' == "$( git rev-parse --is-inside-work-tree 2> /dev/null )" ]]; then
      echo "Info: Git repository created in '$( pwd )/'.";
  else
      echo "Info: Git repository not created in '$( pwd )/'.";
      exit 1;
  fi

  # Return from function.

  return;
}



## @brief Set Git local options.
## @details Set Git local options.
##   1. See that local options contain known keys.
##   2. See that key has value.
##   3. Set Git options locally.
## @param[in] local_options
##   The Git local options.
## @return
##   The exit code of last command.

function setLocalOptions()
{
  # The Git local options.

  local -a local_options=( "${@}" );

  # See if the keys of the local options are known keys.

  local index=0;

  local -a key_value=();
  local key='';
  local value='';

  for (( index=0; index<"${#local_options[@]}"; index++ )); do
    # Split option into key and value.

    key_value=();
    key='';
    value='';
    IFS=';' read -a 'key_value' -r <<< "${local_options[${index}]}";
    key="${key_value[0]}";
    value="${key_value[1]}";

    # See that the key is an allowed key.

    if   [[ 'user.name' == "${key}" ]]; then
      # do nothing
      :;
    elif [[ 'user.email' == "${key}" ]]; then
      # do nothing
      :;
    elif [[ 'merge.ff' == "${key}" ]]; then
      # do nothing
      :;
    elif [[ 'pull.ff' == "${key}" ]]; then
      # do nothing
      :;
    else
        echo "Error: unknown key '${key}' in variable 'local_options'.";
        exit 1;
    fi

    # See key has value.

    if [[ -n "${value}" ]]; then
      # do nothing
      :;
    else
      echo "Error: variable 'local_options' key '${key}' (${value}) has empty value.";
      exit 1;
    fi

    # Show key and value.

    echo "Info: variable 'local_options' key '${key}' (${value}) present.";

    # Set the local options.

    git config "${key}" "${value}";
  done

  # Return from function.

  return;
}



## @brief Set Git global options.
## @details Set Git global options.
##   1. See that global options contain known keys.
##   2. See that key has value.
##   3. Set Git options globally.
## @param[in] global_options
##   The Git global options.
## @return
##   The exit code of last command.

function setGlobalOptions()
{
  # The Git global options.

  local -a global_options=( "${@}" );

  # See if the keys of the global options are known keys.

  local index=0;

  local -a key_value=();
  local key='';
  local value='';

  for (( index=0; index<"${#global_options[@]}"; index++ )); do
    # Split option into key and value.

    key_value=();
    key='';
    value='';
    IFS=';' read -a 'key_value' -r <<< "${global_options[${index}]}";
    key="${key_value[0]}";
    value="${key_value[1]}";

    # See that the key is an allowed key.

    if   [[ 'user.name' == "${key}" ]]; then
      # do nothing
      :;
    elif [[ 'user.email' == "${key}" ]]; then
      # do nothing
      :;
    elif [[ 'merge.ff' == "${key}" ]]; then
      # do nothing
      :;
    elif [[ 'pull.ff' == "${key}" ]]; then
      # do nothing
      :;
    else
        echo "Error: unknown key '${key}' in variable 'global_options'.";
        exit 1;
    fi

    # See key has value.

    if [[ -n "${value}" ]]; then
      # do nothing
      :;
    else
      echo "Error: variable 'global_options' key '${key}' (${value}) has empty value.";
      exit 1;
    fi

    # Show key and value.

    echo "Info: variable 'global_options' key '${key}' (${value}) present.";

    # Set the global options.

    git config --global "${key}" "${value}";
  done

  # Return from function.

  return;
}



## @brief Set Git remotes.
## @details Set Git remotes.
##   1. See that remotes contain known keys.
##   2. See that key has value.
##   3. Set Git remotes.
## @param[in] remotes
##   The Git remotes.
## @return
##   The exit code of last command.
function setRemotes()
{
  # The Git remotes.

  local -a remotes=( "${@}" );

  # See if the keys of the remotes are not empty.

  local index=0;

  local -a key_value=();
  local key='';
  local value='';

  for (( index=0; index<"${#remotes[@]}"; index++ )); do
    # Split remotes into key and value.

    key_value=();
    key='';
    value='';
    IFS=';' read -a 'key_value' -r <<< "${remotes[${index}]}";
    key="${key_value[0]}";
    value="${key_value[1]}";

    # See that the key is not empty.

    if [[ -n "${key}" ]]; then
      # do nothing
      :;
    else
      echo "Error: variable 'remotes' has empty key (${value}).";
      exit 1;
    fi

    # See key has value.

    if [[ -n "${value}" ]]; then
      # do nothing
      :;
    else
      echo "Error: variable 'remotes' key (${key}) has empty value.";
      exit 1;
    fi

    # Show key and value.

    echo "Info: variable 'remotes' key '${key}' (${value}) present.";

    # Set remote.

    git remote add "${key}" "${value}";
  done

  # Return from function.

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

  local arguments=( "${@}" );

  # The Git working directory.

  local working_directory='';

  # The Git repository directory.

  local repository_directory='';

  # The Git local options.

  local -a local_options=();

  # The Git global options.

  local -a global_options=();

  # The Git remotes.

  local -a remotes=();

  # Get content from configuration file if it is present.

  if [[ -f './config.inc.bash' ]]; then
    echo "Info: configuration file './config.inc.bash' present.";
    echo "Info: loading configuraton file './config.inc.bash'.";
    source './config.inc.bash';
  else
    echo "Info: configuration file './config.inc.bash' not present.";
    echo "Info: not loading configuraton file './config.inc.bash'.";
  fi

  # See if variables are set and not empty.

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
  if (( 0 < "${#local_options[@]}" )); then
    echo "Info: variable 'local_options' (${#local_options[@]}) (${local_options[@]}) present.";
  else
    echo "Error: variable 'local_options' not present.";
    exit 1;
  fi
  if (( 0 < "${#global_options[@]}" )); then
    echo "Info: variable 'global_options' (${#global_options[@]}) (${global_options[@]}) present.";
  else
    echo "Error: variable 'global_options' not present.";
    exit 1;
  fi
  if (( 0 < "${#remotes[@]}" )); then
    echo "Info: variable 'remotes' (${#remotes[@]}) (${remotes[@]}) present.";
  else
    echo "Error: variable 'remotes' not present.";
    exit 1;
  fi

  # See if we can create the working directory.

  echo "Info: creating working directory '${working_directory}' ...";
  local dirname="$( dirname "${working_directory}" )";
  local basename="$( basename "${working_directory}" )";
  testDirectory "${dirname}" "${basename}";
  working_directory="${dirname}/${basename}/";

  # Ask for confirmation before creating the working directory.

  askConfirmation;

  # It is ok to create the working directory.  So create it.

  createDirectory "${working_directory}";
  echo '... done';

  # Change directory to working directory.

  echo "Info: changing directory to '${working_directory}' ...";
  cd "${working_directory}";
  echo '... done';

  # Initialize the Git repository.

  echo "Info: initializing Git repository in '${working_directory}'";
  initializeGitRepository;
  echo '... done';

  # Set Git local options.

  echo "Info: configure Git local options in '${working_directory}'";
  setLocalOptions "${local_options[@]}";
  echo '... done';

  # Set Git global options.

  echo "Info: configure Git global options in '${working_directory}'";
  setGlobalOptions "${global_options[@]}";
  echo '... done';

  # Set remotes.

  echo "Info: configure Git remotes in '${working_directory}'";
  setRemotes "${remotes[@]}";
  echo '... done';

  # Return from function.

  return;
}

# Call the main function and pass the command line arguments.

main "${@}";



################################################################################
##
## TESTS
##
################################################################################



################################################################################
##
## EXIT
##
################################################################################

exit;
