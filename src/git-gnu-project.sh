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
## List of set options.
##
## Recommended options to enable for debugging:
##
##   bash> set -E          -e         -u         -x        -o pipefail;
##
##   which is same as
##
##   bash> set -o errtrace -o errexit -o nounset -o xtrace -o pipefail;
##
## allexport - same as -a - Mark variables which are modified or created for
##   export.
##
## allexport - Same as -a. - Each variable or function that is created or
##   modified is given the export attribute and marked for export to the
##   environment of subsequent commands.
##
## braceexpand - same as -B - The shell will perform brace expansion.
##
## braceexpand - Same as -B. - The shell will perform brace expansion (see Brace
##   Expansion).  This option is on by default.
##
## emacs - use an emacs-style line editing interface
##
## emacs - Use an emacs-style line editing interface (see Command Line Editing).
##   This also affects the editing interface used for read -e.
##
## errexit - same as -e - Exit immediately if a command exits with a non-zero
##   status.
##
## errexit - Same as -e. - Exit immediately if a pipeline (see Pipelines), which
##   may consist of a single simple command (see Simple Commands), a list (see
##   Lists of Commands), or a compound command (see Compound Commands) returns a
##   non-zero status.  The shell does not exit if the command that fails is part
##   of the command list immediately following a while or until keyword, part of
##   the test in an if statement, part of any command executed in a && or ||
##   list except the command following the final && or ||, any command in a
##   pipeline but the last, or if the command’s return status is being inverted
##   with !.  If a compound command other than a subshell returns a non-zero
##   status because a command failed while -e was being ignored, the shell does
##   not exit.  A trap on ERR, if set, is executed before the shell exits.
##
##   This option applies to the shell environment and each subshell environment
##   separately (see Command Execution Environment), and may cause subshells to
##   exit before executing all the commands in the subshell.
##
##   If a compound command or shell function executes in a context where -e is
##   being ignored, none of the commands executed within the compound command or
##   function body will be affected by the -e setting, even if -e is set and a
##   command returns a failure status.  If a compound command or shell function
##   sets -e while executing in a context where -e is ignored, that setting will
##   not have any effect until the compound command or the command containing
##   the function call completes.
##
set -o errexit;
##
## errtrace - same as -E - If set, the ERR trap is inherited by shell functions.
##
## errtrace - Same as -E. - If set, any trap on ERR is inherited by shell
##   functions, command substitutions, and commands executed in a subshell
##   environment.  The ERR trap is normally not inherited in such cases.
##
set -o errtrace;
##
## functrace - same as -T - If set, the DEBUG and RETURN traps are inherited by
##   shell functions.
##
## functrace - Same as -T. - If set, any trap on DEBUG and RETURN are inherited
##   by shell functions, command substitutions, and commands executed in a
##   subshell environment.  The DEBUG and RETURN traps are normally not
##   inherited in such cases.
##
## hashall - same as -h - Remember the location of commands as they are looked
##   up.
##
## hashall - Same as -h. - Locate and remember (hash) commands as they are
##   looked up for execution. This option is enabled by default.
##
## histexpand - same as -H - Enable ! style history substitution.  This flag is
##   on by default when the shell is interactive.
##
## histexpand - Same as -H. - Enable ‘!’ style history substitution (see History
## Expansion).  This option is on by default for interactive shells.
##
## history - enable command history
##
## history - Enable command history, as described in Bash History Facilities.
##   This option is on by default in interactive shells.
##
## igncr - on Cygwin, ignore \r in line endings
##
## ignoreeof - the shell will not exit upon reading EOF
##
## ignoreeof - An interactive shell will not exit upon reading EOF.
##
## interactive-comments - allow comments to appear in interactive commands
##
## keyword - same as -k - All assignment arguments are placed in the environment
##   for a command, not just those that precede the command name.
##
## keyword - Same as -k. - All arguments in the form of assignment statements
##   are placed in the environment for a command, not just those that precede
##   the command name.
##
## monitor - same as -m - Job control is enabled.
##
## monitor - Same as -m. - Job control is enabled (see Job Control).  All
##   processes run in a separate process group.  When a background job
##   completes, the shell prints a line containing its exit status.
##
## noclobber - same as -C - If set, disallow existing regular files to be
##   overwritten by redirection of output.
##
## noclobber - Same as -C. - Prevent output redirection using ‘>’, ‘>&’, and
##   ‘<>’ from overwriting existing files.
##
## noexec - same as -n - Read commands but do not execute them.
##
## noexec - Same as -n. - Read commands but do not execute them.  This may be
##   used to check a script for syntax errors.  This option is ignored by
##   interactive shells.
##
## noglob - same as -f - Disable file name generation (globbing).
##
## noglob - Same as -f. - Disable filename expansion (globbing).
##
## nolog - currently accepted but ignored
##
## nolog - Currently ignored.
##
## notify - same as -b - Notify of job termination immediately.
##
## notify - Same as -b. -- Cause the status of terminated background jobs to be
##   reported immediately, rather than before printing the next primary prompt.
##
## nounset - same as -u - Treat unset variables as an error when substituting.
##
## nounset - Same as -u. - Treat unset variables and parameters other than the
##   special parameters ‘@’ or ‘*’, or array variables subscripted with ‘@’ or
##   ‘*’, as an error when performing parameter expansion.  An error message
##   will be written to the standard error, and a non-interactive shell will
##   exit.
##
set -o nounset;
##
## onecmd - same as -t - Exit after reading and executing one command.
##
## onecmd - Same as -t. - Exit after reading and executing one command.
##
## physical - same as -P - If set, do not resolve symbolic links when executing
##   commands such as cd which change the current directory.
##
## physical - Same as -P. - If set, do not resolve symbolic links when
##   performing commands such as cd which change the current directory.  The
##   physical directory is used instead.  By default, Bash follows the logical
##   chain of directories when performing commands which change the current
##   directory.
##
## pipefail - the return value of a pipeline is the status of the last command
##   to exit with a non-zero status, or zero if no command exited with a
##   non-zero status
##
## pipefail - If set, the return value of a pipeline is the value of the last
##   (rightmost) command to exit with a non-zero status, or zero if all commands
##   in the pipeline exit successfully. This option is disabled by default.
##
set -o pipefail;
##
## posix - change the behavior of bash where the default operation differs from
##   the Posix standard to match the standard
##
## posix - Change the behavior of Bash where the default operation differs from
##   the POSIX standard to match the standard (see Bash POSIX Mode).  This is
##   intended to make Bash behave as a strict superset of that standard.
##
## privileged - same as -p - Turned on whenever the real and effective user ids
##   do not match.  Disables processing of the $ENV file and importing of shell
##   functions.  Turning this option off causes the effective uid and gid to be
##   set to the real uid and gid.
##
## privileged - Same as -p. - Turn on privileged mode.  In this mode, the
##   $BASH_ENV and $ENV files are not processed, shell functions are not
##   inherited from the environment, and the SHELLOPTS, BASHOPTS, CDPATH and
##   GLOBIGNORE variables, if they appear in the environment, are ignored.  If
##   the shell is started with the effective user (group) id not equal to the
##   real user (group) id, and the -p option is not supplied, these actions are
##   taken and the effective user id is set to the real user id.  If the -p
##   option is supplied at startup, the effective user id is not reset.  Turning
##   this option off causes the effective user and group ids to be set to the
##   real user and group ids.
##
## verbose - same as -v - Print shell input lines as they are read.
##
## verbose - Same as -v. - Print shell input lines as they are read.
##
## vi - use a vi-style line editing interface
##
## vi - Use a vi-style line editing interface.  This also affects the editing
## interface used for read -e.
##
## xtrace - same as -x - Print commands and their arguments as they are
##   executed.
##
## xtrace - Same as -x. - Print a trace of simple commands, for commands, case
##   commands, select commands, and arithmetic for commands and their arguments
##   or associated word lists after they are expanded and before they are
##   executed.  The value of the PS4 variable is expanded and the resultant
##   value is printed before the command and its expanded arguments.
##
set -o xtrace;
##
## -r - Enable restricted shell mode. This option cannot be unset once it has
##   been set.
## @}



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
