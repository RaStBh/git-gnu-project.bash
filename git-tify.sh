#! /usr/bin/env bash
################################################################################
##                                                                            ##
## This file is part of the RaSt git-gnu-project.sh package.                  ##
##                                                                            ##
## RaSt git-gnu-project.sh  - for  managing a  directory as  a Git repository ##
## and a GNU project using Bash.                                              ##
##                                                                            ##
## Copyright (C)  2023  Ralf Stephan  <me@ralf-stephan.name>                  ##
##                                                                            ##
## RaSt git-gnu-project.sh is free  software: you can redistribute  it and/or ##
## modify it under the terms of  the GNU General Public License as  published ##
## by the Free Software Foundation, either  version 3 of the License, or  (at ##
## your option) any later version.                                            ##
##                                                                            ##
## RaSt  git-gnu-project.sh  is  distributed  in  the  hope  that  it will be ##
## useful, but  WITHOUT ANY  WARRANTY; without  even the  implied warranty of ##
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU  General ##
## Public License for more details.                                           ##
##                                                                            ##
## You should have received  a copy of the  GNU General Public License  along ##
## with this package.  If not, see <https://www.gnu.org/licenses/>.           ##
##                                                                            ##
## $Version: 0.10.0 (2023-08-08 07:34:01 +00:00:00) $                         ##
##                                                                            ##
################################################################################



################################################################################
##
## GIT-TIFY.SH - 1 - 2023-08-08 - RaSt - RaSt git-gnu-project.sh Manual
##
## NAME
##
##   git-tify.sh - for managing a directory as a Git repository
##
## SYNOPSIS
##
##   git-tify.sh [--working-directory=<working directory>]
##               [--empty-local-options]
##               [--local-option=<local-option>]
##               [--empty-global-options]
##               [--global-option=<global option>]
##               [--empty-remotes]
##               [--remote=<remote>]
##               [--legal-notice=<legal notice>]
##               [--empty-configuration-files]
##               [--configuration-file=<configuration file>]
##               [--help]
##               [--version]
##
## DESCRIPTION
##
##   RaSt git-tify.sh is for managing a directory as a Git repository.
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
##   Step 6: Add Git configuration files.
##           Add legal notice to Git configuration files.
##           Commit Git configuration files.
##   Step 7: Cleanup and optimize the Git repository.
##
## OPTIONS
##
##   --working-directory         - set Git working directory
##   --empty-local-options       - set Git local options  list to an empty list,
##                                 use this before --local-option
##   --local-option              - add  Git local  option to  Git local  options
##                                 list, use this after --empty-local-options
##   --empty-global-options      - set Git global options list to an empty list,
##                                 use this before --global-option
##   --global-option             - add Git  global option to Git  global options
##                                 list, use this after --empty-global-options
##   --empty-remotes             - set Git  remotes list  to an empty  list, use
##                                 this before --remote
##   --remote                    - add Git remote to  Git remotes list, use this
##                                 after --empty-remotes
##   --legal-notice              - set legal notice
##   --empty-configuration-files - set Git  configuration file list to  an empty
##                                 list, use this before --configuration-file
##   --configuration-file        - add  Git  remote  to Git  configuration  file
##                                 list,         use          this         after
##                                 --empty-configuration-files
##   --help                      - print help
##   --version                   - print version
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
##   git-tify.sh           - this script
##   config.inc.sh         - configuration file
##   config.inc.sh.example - example configuration file
##
## EXIT STATUS
##
##   on success: $? == 0
##   on failure: $? >  0
##
## EXAMPLES
##
##   git-tify.sh --working-directory='/home/john_dow/repositories/foobar/' \
##               --empty-local-options \
##               --local-option='user.name;John Dow' \
##               --local-option='user.email;john_dow@example.com' \
##               --local-option='merge.ff;false' \
##               --local-option='pull.ff;false' \
##               --empty-global-options \
##               --global-option='user.name;John Dow' \
##               --global-option='user.email;john_dow@example.com' \
##               --global-option='merge.ff;false' \
##               --global-option='pull.ff;false' \
##               --empty-remotes \
##               --remote='github.com;git@github.com-JohnDow:JohnDow' \
##               --remote='gitlab.com;git@gitlab.com-JohnDow:JohnDow' \
##               --remote='example.com;ssh://john_dow@example.com/home/john_dow/repositories/foobar/' \
##               --legal-notice="################################################################################
##               ##
##               ## This file is part of the JD foobar package.
##               ##
##               ## JD foobar is for making foobar.
##               ##
##               ## Copyright (C)  2023  John Dow  <john_dow@example.com>
##               ##
##               ## GNU All-Permissive  License: Copying and  distribution of this file,  with or
##               ## without modification,  are permitted in  any medium without  royalty provided
##               ## the copyright  notice and this  notice are  preserved.  This file  is offered
##               ## as-is, without any warranty.
##               ##
##               ################################################################################" \
##               --empty-configuration-files \
##               --configuration-file='.gitattributes' \
##               --configuration-file='.gitignore' \
##               --configuration-file='.gitkeep' \
##               --configuration-file='.gitmodules' \
##               --configuration-file='.mailmap'
##
##   git-tify.sh --help
##
##   git-tify.sh --version
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
##   Ralf Stephan  <me@ralf-stephan.name>
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
## GLOBAL FUNCTONS
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
  if [[ -d "${dirname}/${basename}" ]]; then
    echo "Error: directory '${dirname}/${basename}/' does exist.";
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

  if    [[ 'true' == "$( git rev-parse --is-inside-work-tree 2> /dev/null )" ]] \
     && [[ -d './.git/' ]]; then
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
      if    [[ 'merge.ff' == "${key}" ]] \
         || [[ 'pull.ff' == "${key}" ]]; then
        if   [[ 'true' == "${value}" ]]; then
          #do nothing
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
        # do nothing
        :;
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
      if    [[ 'merge.ff' == "${key}" ]] \
         || [[ 'pull.ff' == "${key}" ]]; then
        if   [[ 'true' == "${value}" ]]; then
          #do nothing
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
        # do nothing
        :;
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



## @brief Create annotated tag.
## @details Create annotated tag.
## @param[in] tag
##   The tag.
## @return
##   The exit code of the last command.

function createAnnotatedTag()
{
  # The tag.

  local tag="${1}";

  # Create annotated tag.

  git tag -a "${tag}" -m "${tag}";

  # Return from the function.

  return;
}



## @brief Add Git configuration files.
## @details
##   Add Git configuration files.
##   Add legal notice to Git configuration files.
##   Commit Git configuration files.
## @param[in] legal_notice
##   The legal notice
## @param[in] configuration_files
##   The Git configuration files.
## @return
##   The exit code of the last command.

function addConfigurationFiles()
{
  # The legal notice.

  local legal_notice="${1}"; shift;

  # The configuration files.

  local -a configuration_files=( "${@}" );

  # Add Git configuration files.
  # Add legal notice to Git configuration files.
  # Commit Git configuration files.

  local configuration_file='';
  for configuration_file in "${configuration_files[@]}"; do
      echo "
${legal_notice}" > "${configuration_file}";
    git add "${configuration_file}";
    git commit --message="$( echo "Add file.

* ${configuration_file}: add file." | fold --spaces --width='72' )";
  done

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
## @param[in] arguments
##   The command line arguments.
## @return
##   The exit code of the last command.

function main()
{
  # Get the command line arguments.

  local -a arguments=( "${@}" );

  # The Version of this script.

  local version="$( cat << 'END'
git-tify.sh (RaSt git-gnu-project.sh)
0.10.0 (2023-08-08 07:34:01 +00:00:00)
Copyright (C)  2023  Ralf Stephan  <me@ralf-stephan.name>
License GPLv3+ (GNU GPL version 3 or later,
see <https://gnu.org/licenses/gpl.html>)
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
END
)";

  # The usage of the script

  local usage="$( cat << 'END'
SYNOPSIS

  git-tify.sh [--working_directory=<working directory>]
              [--empty-local-options]
              [--local-option=<local-option>]
              [--empty-global-options]
              [--global-option=<global option>]
              [--empty-remotes]
              [--remote=<remote>]
              [--legal-notice=<legal notice>]
              [--empty-configuration-files]
              [--configuration-file=<configuration file>]
              [--help]
              [--version]

  git-tify.sh --help

  git-tify.sh --version

OPTIONS

  --working-directory         - set Git working directory
  --empty-local-options       - set Git local options  list to an empty list,
                                use this before --local-option
  --local-option              - add  Git local  option to  Git local  options
                                list, use this after --empty-local-options
  --empty-global-options      - set Git global options list to an empty list,
                                use this before --global-option
  --global-option             - add Git  global option to Git  global options
                                list, use this after --empty-global-options
  --empty-remotes             - set Git  remotes list  to an empty  list, use
                                this before --remote
  --remote                    - add Git remote to  Git remotes list, use this
                                after --empty-remotes
  --legal-notice              - set legal notice
  --empty-configuration-files - set Git  configuration file list to  an empty
                                list, use this before --configuration-file
  --configuration-file        - add  Git  remote  to Git  configuration  file
                                list,         use          this         after
                                --empty-configuration-files
  --help                      - print help
  --version                   - print version

  Allowed values for global options and local options:

    merge.ff - only | true | false

    pull.ff  - only | true | false

Report bugs to:
Package home page:
General help using RaSt software:

  https://github.com/RaStBh/
  https://gitlab.com/RaStBh/
END
)";

  # Name of the organisation.

  local name_organisation='';

  # Name of the package.

  local name_package='';

  # Package description.

  local description_package='';

  # Copyright information.

  local copyright_years='';
  local copyright_owners='';
  local copyright_contacts='';

  # The Legal notice.

  local legal_notice='';

  # The Git working directory.

  local working_directory='';

  # The Git local options.

  local -a local_options=();

  # The Git global options.

  local -a global_options=();

  # The Git remotes.

  local -a remotes=();

  # The Git configuration files.

  local -a configuration_files=();

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

  # Files containing licenses texts.

  local -a license_files=();

  # Get the variables from the configuration file if the file it is present.

  if [[ -f './config.inc.sh' ]]; then
    echo "Info: configuration file './config.inc.sh' present.";
    echo "Info: loading configuraton file './config.inc.sh'.";
    source './config.inc.sh';
  else
    echo "Info: configuration file './config.inc.sh' not present.";
    echo "Info: not loading configuration file './config.inc.sh'.";
  fi

  # Get the command line arguments.

  local short_options='';
  local long_options='';
  long_options+='working-directory:,';
  long_options+='empty-local-options,';
  long_options+='local-option:,';
  long_options+='empty-global-options,';
  long_options+='global-option:,';
  long_options+='empty-remotes,';
  long_options+='remote:,';
  long_options+='legal-notice:,';
  long_options+='empty-configuration-files,';
  long_options+='configuration-file:,';
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

      '--empty-local-options' )
        local_options=();
        next_position="$(( "${next_position}" + 0 ))";
        ;;

      '--local-option' )

        local_options[${#local_options[@]}]="${option_argument}";
        next_position="$(( "${next_position}" + 1 ))";
        ;;

      '--empty-global-options' )
        global_options=();
        next_position="$(( "${next_position}" + 0 ))";
        ;;

      '--global-option' )
        global_options["${#global_options[@]}"]="${option_argument}";
        next_position="$(( "${next_position}" + 1 ))";
        ;;

      '--empty-remotes' )
        remotes=();
        next_position="$(( "${next_position}" + 0 ))";
        ;;

      '--remote' )
        remotes["${#remotes[@]}"]="${option_argument}";
        next_position="$(( "${next_position}" + 1 ))";
        ;;

      '--legal-notice' )
        legal_notice="${option_argument}";
        next_position="$(( "${next_position}" + 1 ))";
        ;;

      '--empty-configuration-files' )
        configuration_files=();
        next_position="$(( "${next_position}" + 0 ))";
        ;;

      '--configuration-file' )
        configuration_files["${#configuration_files[@]}"]="${option_argument}";
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

      '--' )
        break;
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

  if [[ -n "${name_organisation}" ]]; then
    echo "Info: variable 'name_organisation' (${name_organisation}) present.";
  else
    echo "Error: variable 'name_organisation' not present.";
    exit 1;
  fi
  if [[ -n "${name_package}" ]]; then
    echo "Info: variable 'name_package' (${name_package}) present.";
  else
    echo "Error: variable 'name_package' not present.";
    exit 1;
  fi
  if [[ -n "${description_package}" ]]; then
    echo "Info: variable 'description_package' (${description_package}) present.";
  else
    echo "Error: variable 'description_package' not present.";
    exit 1;
  fi
  if [[ -n "${copyright_years}" ]]; then
    echo "Info: variable 'copyright_years' (${copyright_years}) present.";
  else
    echo "Error: variable 'copyright_years' not present.";
    exit 1;
  fi
  if [[ -n "${copyright_owners}" ]]; then
    echo "Info: variable 'copyright_owners' (${copyright_owners}) present.";
  else
    echo "Error: variable 'copyright_owners' not present.";
    exit 1;
  fi
  if [[ -n "${copyright_contacts}" ]]; then
    echo "Info: variable 'copyright_contacts' (${copyright_contacts}) present.";
  else
    echo "Error: variable 'copyright_contacts' not present.";
    exit 1;
  fi
  if [[ -n "${legal_notice}" ]]; then
    echo "Info: variable 'legal_notice' (${legal_notice}) present.";
  else
    echo "Error: variable 'legal_notice' not present.";
    exit 1;
  fi
  if [[ -n "${working_directory}" ]]; then
    echo "Info: variable 'working_directory' (${working_directory}) present.";
  else
    echo "Error: variable 'working_directory' not present.";
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
  if (( 0 < "${#configuration_files[@]}" )); then
    echo "Info: variable 'configuration_files' (${#configuration_files[@]}) (${configuration_files[@]}) present.";
  else
    echo "Error: variable 'configuration_files' not present.";
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

  echo "Info: configuring Git global options in '${working_directory}' ...";
  setGlobalOptions "${global_options[@]}";
  echo '... done';

  # Set the Git remotes.

  echo "Info: configuring Git remotes in '${working_directory}' ...";
  setRemotes "${remotes[@]}";
  echo '... done';

  # Initial commit.

  echo "Info: commiting Git repository in '${working_directory}' ...";
  initialCommit;
  echo '... done';

  # Create annotated tag.

  echo "Info: create annotated tag in '${working_directory}' ...";
  createAnnotatedTag '0.0.0';
  echo '... done';

  ## Add Git configuration files.
  ## Add legal notice to Git configuration files.
  ## Commit Git configuration files.

  echo "Info: adding Git configuration files in '${working_directory}' ...";
  addConfigurationFiles "${legal_notice}" "${configuration_files[@]}";
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
