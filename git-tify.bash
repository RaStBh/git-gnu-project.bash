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
## $Date: 2023-06-11 04:18:33.2607097000 +00:00:00 $
##
################################################################################



################################################################################
##
## GIT-TIFY.BASH - 1 - 2023-06-10 - RaSt - RaSt git-gnu-project Manual
##
## NAME
##
##   git-tify.bash - manage directory as Git style project
##
## SYNOPSIS
##
##   git-tify.bash [--working_directory=<working directory>]
##                 [--repository-directory=<repository directory>]
##                 [--empty-local-options]
##                 [--local-option=<local-option>]
##                 [--empty-global-options]
##                 [--global-option=<global option>]
##                 [--empty-remotes]
##                 [--remote=<remote>]
##                 [--help]
##                 [--version]
##
## DESCRIPTION
##
##   RaSt git-tify.bash is  a Bash script to  manage a directory as  a Git style
##   project.
##
##   The directory then  is a Git working directory containing  a Git repository
##   directory.
##
##   The  Git working  directory  is  for example  </home/john_dow/repositories/
##   foobar/>.
##
##   The Git  repository directory is for  example </home/john_dow/repositories/
##   foobar/.git/>.
##
##   This script does:
##
##   Step 1: Create the Git working  directory, asking the user for confirmation
##           before creating the Git working directory.
##   Step 2: Initialize the Git repository.
##   Step 3: Set the Git local options.
##   Step 3: Set the Git global options.
##   Step 4: Set the Git remotes.
##   Step 5: Commit Git repository as empty initial commit.
##   Step 6: Cleanup and optimize the Git repository.
##
## OPTIONS
##
##   --working-directory    - set Git working directory
##   --repository-directory - set Git repository directory
##   --empty-local-options  - set Git local  options list to an  empty list, use
##                            this before --local-option
##   --local-option         - add Git  local option  to Git local  options list,
##                            use this after --empty-local-options
##   --empty-global-options - set Git global options list  to an empty list, use
##                            this before --global-option
##   --global-option        - add Git global option  to Git global options list,
##                            use this after --empty-global-options
##   --empty-remotes        - set Git  remotes list to  an empty list,  use this
##                            before --remote
##   --remote               - add Git remote to Git remotes list, use this after
##                            --empty-remotes
##   --help                 - print help
##   --version              - print version
##
##   Allowed values for global options and local options:
##
##     merge.ff - only | true | false
##
##     pull.ff  - only | true | false
##
## IMPLEMENTATION NOTES
##
## ENVIRONMENT
##
## FILES
##
##   git-tify.bash           - this script
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
##   git-tify.bash --working-directory='/home/john_dow/repositories/foobar/' \
##                 --repository-directory='/home/john_dow/repositories/foobar/.git/' \
##                 --empty-local-options \
##                 --local-option='user.name;John Dow' \
##                 --local-option='user.email;john_dow@example.com' \
##                 --local-option='merge.ff;false' \
##                 --local-option='pull.ff;false' \
##                 --empty-global-options \
##                 --global-option='user.name;John Dow' \
##                 --global-option='user.email;john_dow@example.com' \
##                 --global-option='merge.ff;false' \
##                 --global-option='pull.ff;false' \
##                 --empty-remotes \
##                 --remote='github.com;git@github.com-JohnDow:JohnDow' \
##                 --remote='gitlab.com;git@gitlab.com-JohnDow:JohnDow' \
##                 --remote='example.com;ssh://john_dow@example.com/home/john_dow/repositories/foobar/'
##
##   git-tify.bash --help
##
##   git-tify.bash --version
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
##      On yes: continue.
##      On no:  exit.
##   2. See if there is the directry 'basename'.
##      On yes: exit.
##      On no : continue.
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
    echo "Error: directory '${dirname}/${basename}/' already exists.";
    exit 1;
  else
    # do nothing
    :;
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

  read -p "Create repository in '${dirname}/${basename}/'? (y/n): " 'confirmation';
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



## @brief Create a directory.
## @details Create a directory.
##   Create the directory.
##   Check presence of the directory.
## @param[in] directory
##  The directory to create, for example </home/john_dow/repositories/foobar/>
## @return
##   The exit code of the last command.

function createDirectory()
{
  # The directory to create.

  local directory="${1}";

  # Create the directory.

  mkdir "${directory}";

  # See if we created the directory.

  if [[ -d "${directory}" ]]; then
    echo "Info: directory '${directory}/' created.";
  else
    echo "Error: directory '${directory}/' not created.";
    exit 1;
  fi

  # Return from the function.

  return;
}



## @brief Initialize a Git repository.
## @details Initialize a Git repository.
##   1. Initialize  the Git repository.   This creates a '.git/'  directory, for
##      example </home/john_dow/repositories/foobar/.git/>.
##   2. See if the Git repository have been created.
## @return
##   The exit code of the last command.

function initializeGitRepository()
{
  # Initialize the Git Repository.

  git init --initial-branch='master' --template='' ./;

  # See if the Git repository have been created

  if [[ 'true' == "$( git rev-parse --is-inside-work-tree 2> /dev/null )" ]]; then
      echo "Info: Git repository created in '$( pwd )/'.";
  else
      echo "Info: Git repository not created in '$( pwd )/'.";
      exit 1;
  fi

  # Return from the function.

  return;
}



## @brief Set the Git local options.
## @details Set the Git local options.
##   1. See that  the local option contains  a known key only.   The known local
##      option keys are:  user.name | user.email | merge.ff |  pull.ff.  A local
##      option has the format 'key;value'.
##   2. See that the key has a value.
##   3. Set the Git option locally.
## @param[in] local_options
##   The Git local options.
## @return
##   The exit code of the last command.

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
    # Split the option into the key and the value.

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

    # See the key has a known value.

    if [[ -n "${value}" ]]; then
      if   [[ 'true' == "${value}" ]]; then
        # do nothing
        :;
      elif [[ 'false' == "${value}" ]]; then
        # do nothing
        :;
      elif [[ 'only' == "${value}" ]]; then
        # do nothing
        :;
      else
        echo "Error: variable 'local_options' key '${key}' (${value}) has unknown value.";
        exit 1;
      fi
    else
      echo "Error: variable 'local_options' key '${key}' (${value}) has empty value.";
      exit 1;
    fi

    # Show the key and the value.

    echo "Info: variable 'local_options' key '${key}' (${value}) present.";

    # Set the local option.

    git config "${key}" "${value}";
  done

  # Return from the function.

  return;
}



## @brief Set the Git global options.
## @details Set the Git global options.
##   1. See that the global option contains  a known key only.  The known global
##      option keys are: user.name | user.email  | merge.ff | pull.ff.  A global
##      option has the format 'key;value'.
##   2. See that the key has a value.
##   3. Set the Git option globally.
## @param[in] global_options
##   The Git global options.
## @return
##   The exit code of the last command.

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
    # Split the option into the key and the value.

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

    # See the key has a known value.

    if [[ -n "${value}" ]]; then
      if   [[ 'true' == "${value}" ]]; then
        # do nothing
        :;
      elif [[ 'false' == "${value}" ]]; then
        # do nothing
        :;
      elif [[ 'only' == "${value}" ]]; then
        # do nothing
        :;
      else
        echo "Error: variable 'global_options' key '${key}' (${value}) has unknown value.";
        exit 1;
      fi
    else
      echo "Error: variable 'global_options' key '${key}' (${value}) has empty value.";
      exit 1;
    fi

    # Show the key and the value.

    echo "Info: variable 'global_options' key '${key}' (${value}) present.";

    # Set the global option.

    git config --global "${key}" "${value}";
  done

  # Return from the function.

  return;
}



## @brief Set the Git remotes.
## @details Set the Git remotes.
##   1. See  that the  Git  remote contains  a  key.  A  remote  has the  format
##      'key;value'.
##   2. See that the key has a value.
##   3. Set Git remote.
## @param[in] remotes
##   The Git remotes.
## @return
##   The exit code of the last command.

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
    # Split the remotes into the key and the value.

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

    # See the key has a value.

    if [[ -n "${value}" ]]; then
      # do nothing
      :;
    else
      echo "Error: variable 'remotes' key (${key}) has empty value.";
      exit 1;
    fi

    # Show the key and the value.

    echo "Info: variable 'remotes' key '${key}' (${value}) present.";

    # Set the remote.

    git remote add "${key}" "${value}";
  done

  # Return from the function.

  return;
}



## @brief Initial empty commit.
## @details Initial empty commit.
## @return
##   The exit code of the last command.

function initialCommit()
{
  # Initial empty commit.

  git commit \
      --allow-empty \
      --message="$(  echo "Initial empty commit." \
                   | fold --spaces --width='50' )";

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
git-tify.bash (RaSt git-gnu-project) 0.2.0
(2023-06-11 04:18:33.2607097000 +00:00:00)
Copyright (C)  2023  Ralf Stephan
License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.";
END
)";

  # The usage of the script

  local usage="$( cat << 'END'
SYNOPSIS

  git-tify.bash [--working_directory=<working directory>]
                [--repository-directory=<repository directory>]
                [--empty-local-options]
                [--local-option=<local-option>]
                [--empty-global-options]
                [--global-option=<global option>]
                [--empty-remotes]
                [--remote=<remote>]
                [--help]
                [--version]

  git-tify.bash --help

  git-tify.bash --version

OPTIONS

  --working-directory    - set Git working directory
  --repository-directory - set Git repository directory
  --empty-local-options  - set Git local options list to an empty list, use
                           this before --local-option
  --local-option         - add Git local option  to Git local options list,
                           use this after --empty-local-options
  --empty-global-options - set Git  global options  list to an  empty list,
                           use this before --global-option
  --global-option        - add  Git global  option  to  Git global  options
                           list, use this after --empty-global-options
  --empty-remotes        - set Git remotes list to  an empty list, use this
                           before --remote
  --remote               - add  Git remote  to Git  remotes list,  use this
                           after --empty-remotes
  --help                 - print help
  --version              - print version";

Report bugs to:
Package home page:
General help using RaSt software:

  https://github.com/RaStBh/
  https://gitlab.com/RaStBh/
END
)";

  # The Git working directory.

  local working_directory='';

  # The  Git  repository  directory.

  local repository_directory='';

  # The Git local options.

  local -a local_options=();

  # The Git global options.

  local -a global_options=();

  # The Git remotes.

  local -a remotes=();

  # Get the variables from the configuration file if the file it is present.

  if [[ -f './config.inc.bash' ]]; then
    echo "Info: configuration file './config.inc.bash' present.";
    echo "Info: loading configuraton file './config.inc.bash'.";
    source './config.inc.bash';
  else
    echo "Info: configuration file './config.inc.bash' not present.";
    echo "Info: not loading configuraton file './config.inc.bash'.";
  fi

  # Get the command line arguments.

  local short_options='';
  local long_options='';
  long_options+='working-directory:,';
  long_options+='repository-directory:,';
  long_options+='empty-local-options,';
  long_options+='local-option:,';
  long_options+='empty-global-options,';
  long_options+='global-option:,';
  long_options+='help,';
  long_options+='version,';

  eval arguments=( "$( getopt --alternative \
                              --options "${short_options}" \
                              --longoptions "${long_options}" \
                              --shell 'bash' \
                              -- \
                              "${@}" )" );
  local option_name='';
  local option_argument='';
  local -i previous_position=0;
  local -i current_position=0;
  local -i next_position=0;

  while true; do
    option_name="${arguments[$(( "${current_position}" + 0 ))]}";
    option_argument="${arguments[$(( "${current_position}" + 1 ))]}";
    next_position="$(( "${next_position}" + 1 ))";
    case "${option_name}" in

      '--working-directory' )
        working_directory="${option_argument}";
        next_position="$(( "${next_position}" + 1 ))";
        ;;

      '--repository-directory' )
        repository_directory="${option_argument}";
        next_position="$(( "${next_position}" + 1 ))";
        ;;

      '--empty-local-options' )
        local_options=();
        next_position="$(( "${next_position}" + 0 ))";
        ;;

      '--local-option' )
        local_options["${#local_options[@]}"]=( "${option_argument}" );
        next_position="$(( "${next_position}" + 1 ))";
        ;;

      '--empty-global-options' )
        global_options=();
        next_position="$(( "${next_position}" + 0 ))";
        ;;

      '--global-option' )
        global_options["${#global_options[@]}"]=( "${option_argument}" );
        next_position="$(( "${next_position}" + 1 ))";
        ;;

      '--help' )
        echo "${usage}";
        exit 0;
        ;;

      '--version' )
        echo "${version}";
        exit 0;
        ;;

      *)
        echo "Error: unknown option name '${option_name}'."
        echo '';
        echo "${usage}";
        exit 1;
        ;;

    esac
    previous_position="${current_position}";
    current_position="${next_position}";
  done

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

  # See if we can create the Git working directory.

  echo "Info: creating working directory '${working_directory}' ...";
  local dirname="$( dirname "${working_directory}" )";
  local basename="$( basename "${working_directory}" )";
  testDirectory "${dirname}" "${basename}";
  working_directory="${dirname}/${basename}/";

  # Ask the user for confirmation before creating the Git working directory.

  askConfirmation;

  # It is ok to create the Git working directory.  So create it.

  createDirectory "${working_directory}";
  echo '... done';

  # Change the Bash working directory to the Git working directory.

  echo "Info: changing directory to '${working_directory}' ...";
  cd "${working_directory}";
  echo '... done';

  # Initialize the Git repository.

  echo "Info: initializing Git repository in '${working_directory}' ...";
  initializeGitRepository;
  echo '... done';

  # Set the Git local options.

  echo "Info: configure Git local options in '${working_directory}' ...";
  setLocalOptions "${local_options[@]}";
  echo '... done';

  # Set the Git global options.

  echo "Info: configure Git global options in '${working_directory}' ...";
  setGlobalOptions "${global_options[@]}";
  echo '... done';

  # Set the Git remotes.

  echo "Info: configure Git remotes in '${working_directory}' ...";
  setRemotes "${remotes[@]}";
  echo '... done';

  # Initial commit.

  echo "Info: commiting Git repository in '${working_directory}' ...";
  initialCommit;
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
## TESTS
##
################################################################################



################################################################################
##
## EXIT
##
################################################################################

exit;
