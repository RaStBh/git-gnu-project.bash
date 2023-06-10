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

  # The working directory.

  local working_directory='';

  # The repository directory.

  local repository_directory='';

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

  # See if we can create the working directory.

  echo "Info: creating working directory '${working_directory}' ...";
  local dirname="$( dirname "${working_directory}" )";
  local basename="$( basename "${working_directory}" )";
  testDirectory "${dirname}" "${basename}";

  # Ask for confirmation before creating the working directory.

  askConfirmation;

  # It is ok to create the working directory.  So create it.

  createDirectory "${dirname}/${basename}/";
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
