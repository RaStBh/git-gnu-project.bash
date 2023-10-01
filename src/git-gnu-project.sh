#! /usr/bin/env bash
## @c{##########################################################################
################################################################################
##                                                                            ##
## This file is part of the RaSt git-gnu-project package.                     ##
##                                                                            ##
## RaSt git-gnu-project - create a Git repository and a GNU project tree in a ##
## local directory.                                                           ##
##                                                                            ##
## Copyright (C)  2023  Ralf Stephan  <me@ralf-stephan.name>                  ##
##                                                                            ##
## This package is free software: you can redistribute it and/or modify it    ##
## under the terms of the GNU General Public License as published by the Free ##
## Software Foundation, either version 3 of the License, or (at your option)  ##
## any later version.                                                         ##
##                                                                            ##
## This package is distributed in the hope that it will be useful, but        ##
## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
## for more details.                                                          ##
##                                                                            ##
## You should have received a copy of the GNU General Public License along    ##
## with this package.  If not, see <https://www.gnu.org/licenses/>.           ##
##                                                                            ##
################################################################################
## }############################################################################



## @mainpage
##
## RaSt git-gnu-project package
##
## With the RaSt git-gnu-project you can create a Git repository and a GNU
## project tree in a local directory.
##
## 1.0.0
##
## 2023-09-18 14:17:21 +00:00:00
##
## @copyright Copyright (C)  2023  Ralf Stephan  \<me@ralf-stephan.name\>



## @file git-gnu-project.sh
##
## @brief The main script of the RaSt git-gnu-project.
##
## @details The main script of the RaSt git-gnu-project handling the command
## git-gnu-project and the subcommands gittify and gnutify.



## @c{
## For Doxygen \var:
##
##   Datatypes:
##
##     integer
##     float
##     string
##
##     indexed-array-of-X
##     hashed-array-of-X
## }

## @var integer EXIT_NO_ERROR
## @brief The Exit code for no error.
## @details The Command executed successfully.

declare -r -i EXIT_NO_ERROR=0;

## @var integer EXIT_GENERAL_ERROR
## @brief The Exit code for a general error.
## @details The Command did not execute successfully.

declare -r -i EXIT_GENERAL_ERROR=1;

## @fn main()
## @brief The main function.
## @details The main function (1) reads the configuration file, (2) reads the
##   command line arguments (3) handles the command line arguments and (4)
##   handles the subcommands gittify and gnutify.
## @param[in] integer argc
##   The number of command line arguments passed to the function.
## @param[in] indexed-array-of-string argv
##   The Array containing the command line arguments passed to the function.
## @return
##   return value: void; return code: the return code of the last executed
##   command.

function main() {
  local -i argc="${1}"; shift 1;
  local -a argv=( "${@}" );

  return;
}

# Call the main function.

main "${#}" "${@}";

# Pass the return code of the main function to the console as the exit code.

exit "${?}";
