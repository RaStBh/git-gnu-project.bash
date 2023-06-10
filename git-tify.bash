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
  if [[ -d "${dirname}" ]]; then
    # do nothing
    :;
  else
    echo "Error: no such directory '${dirname}'.";
    exit 1;
  fi
  cd "${dirname}";
  local basename="$( basename "${working_directory}" )";
  if [[ -d "./${basename}" ]]; then
    echo "Error: directory '${dirname}/${basename}/' already exists.";
    exit 1;
  else
    # do nothing
    :;
  fi

  # It is ok to create the working directory.  So create it.

  mkdir "${basename}";
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
