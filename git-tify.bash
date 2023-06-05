#! /usr/bin/env bash

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
## git-tify.bash repository-path repository-name ???
##
## DESCRIPTION
##
## ???
##
## ARGUMENTS
##
## repository-path - path to the directory
##
## repository-name - name of the repository
##
## ???
##
## OPTIONS
##
## ???
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
## git-tify.bash - this script
##
## EXIT STATUS                                  (For sections 1, 6, and 8 only.)
##
## EXAMPLES
##
## git-tify.bash /home/user/john_dow/repositories/ foobar
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
## $1 : repository-path - path to the directory
##
declare repository_path='';
##
## S2 : repository-name - name of the repository
##
declare repository_name='';



################################################################################
##
## Get the command line arguments.
##
################################################################################
##
## Check number of arguments.
##
if (( 2 == "${#}" )); then
  :;
else
  echo 'Error: wrong number of arguments.';
  exit 1;
fi
##
## $1 : repository-path - path to the directory
##
repository_path="${1}";
repository_path="$( echo "${repository_path}" | sed 's/[/]*$//g' )";
##
## S2 : repository-name - name of the repository
##
repository_name="${2}";



################################################################################
##
## See if we can create a new  repository.  If OK, then change working directory
## and create the new directory.
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
