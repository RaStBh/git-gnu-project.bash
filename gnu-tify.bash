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
