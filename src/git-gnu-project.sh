#! /usr/bin/env bash
## @comment{####################################################################
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
## ############################################################################}



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
## Copyright (C)  2023  Ralf Stephan  \<me\@ralf-stephan.name\>



## @file git-gnu-project.sh
##
## @brief The main script of the RaSt git-gnu-project.
##
## @details The main script of the RaSt git-gnu-project handling the command
## git-gnu-project and the subcommands gittify and gnutify.



## @comment{
## The doxygen custom command \@\{ ... \} causes problems for doxygen while
## counting the lines.  So the references to the lines in the source code are
## wrong.
## }



## @comment{
## Datatypes for Doxygen comments:
##
##   integer
##   float
##   string
##
##   indexed-array-of-X
##   hashed-array-of-X
## }



## @comment{
## First enable the shell options to make bash more verbose.
##
## This is moved to top of the file.  See below for the other shell options and
## for the additional shell options.
## }

#set -o 'xtrace';
#set -o 'verbose';

## @comment{
## Enable or disable shell options (set) for debugging.
## }

## @var _ENABLE_SET
## @brief Enable setting shell options (set).
## @details Enable running command to set shell options.<br /><br />
## 0 : enable<br />
## 1 : disable

declare -r -i _ENABLE_SET=0;

## @comment{
## Enable or disable additional shell options (shopt) for debugging.
## }

## @var _ENABLE_SHOPT
## @brief Enable setting additional shell options (shopt).
## @details Enable running command to set additional shell options.<br /><br />
## 0 : enable<br />
## 1 : disable

declare -r -i _ENABLE_SHOPT=0;

## @comment{
## Enable or disable trapping.
## }

## @var _ENABLE_TRAP
## @brief Enable trapping of signals and events.
## @details Enable running command for trapping.<br /><br />
## 0 : enable<br />
## 1 : disable

declare -r -i _ENABLE_TRAP=1;

## @comment{
## Enable or disable commands for debugging.
## }

## @var _ENABLE_DEBUG
## @brief Enable debug output.
## @details Enable running commands for debugging.<br /><br />
## 0 : enable<br />
## 1 : disable

declare -r -i _ENABLE_DEBUG=0;



## @comment{
## Command exit codes.
##
##   0   success
##   1   failure
## }

## @var integer EXIT_NO_ERROR
## @brief The exit code for no error.
## @details The exit code to signal that the command executed successfully.

declare -r -i EXIT_NO_ERROR=0;

## @var integer EXIT_GENERAL_ERROR
## @brief The exit code for a general error.
## @details The exit code to signal that the command did not execute
## successfully.

declare -r -i EXIT_GENERAL_ERROR=1;



## @comment{
## Function return codes.
##
##   0   success
##   1   failure
## }

## @var integer RETURN_NO_ERROR
## @brief The return code for no error.
## @details The return code to signal that the function executed successfully.

declare -r -i RETURN_NO_ERROR="${EXIT_NO_ERROR}";

## @var integer RETURN_GENERAL_ERROR
## @brief The return code for a general error.
## @details The return code to signal that the function did not execute
## successfully.

declare -r -i RETURN_GENERAL_ERROR="${EXIT_GENERAL_ERROR}";



## @comment{
## Enable or disable shell options (set) for debugging.
## }

## @fn _DEBUG_SET()
## @brief Run commands to set shell options.
## @details Run set commands by chaining multiple commands.<br /><br />
## Example:
## @code
## _DEBUG_SET set -o 'errexit'
## @endcode
## @startglobal
## @itemglobal{in,integer,_ENABLE_SET<br />Enable setting of shell options.}
## @endglobal
## @param[in] indexed-array-of-string ${\@}<br />The command to run.
## @return void<br />return value: none<br />return code: The return code of the
## last executed command.

function _DEBUG_SET() {
  #(( 0 == "${_ENABLE_SET}" )) && printf '%s\n' 'SET:';
  (( 0 == "${_ENABLE_SET}" )) && "${@}";
  return "${RETURN_NO_ERROR}";
}

## @comment{
## Enable or disable additional shell options (shopt) for debugging.
## }

## @fn _DEBUG_SHOPT()
## @brief Run commands to set additional shell options.
## @details Run shopt commands by chaining multiple commands.<br /><br />
## Example:
## @code
## _DEBUG_SHOPT shopt -s 'extdebug'
## @endcode
## @startglobal
## @itemglobal{in,integer,_ENABLE_SHOPT<br />Enable setting of additional shell
## options.}
## @endglobal
## @param[in] indexed-array-of-string ${\@}<br />The command to run.
## @return void<br />return value: none<br />return code: The return code of the
## last executed command.

function _DEBUG_SHOPT() {
  #(( 0 == "${_ENABLE_SHOPT}" )) && printf '%s\n' 'SHOPT:';
  (( 0 == "${_ENABLE_SHOPT}" )) && "${@}";
  return "${RETURN_NO_ERROR}";
}

## @comment{
## Enable or disable trapping.
## }

## @fn _DEBUG_TRAP()
## @brief Run commands for trapping of signals and events.
## @details Run trapping commands by chaining multiple commands.<br /><br />
## Example:
## @code
## _DEBUG_TRAP trap 'trapERR' ERR
## @endcode
## @startglobal
## @itemglobal{in,integer,_ENABLE_TRAP<br />Enable trapping.}
## @endglobal
## @param[in] indexed-array-of-string ${\@}<br />The command to run.
## @return void<br />return value: none<br />return code: The return code of the
## last executed command.

function _DEBUG_TRAP() {
  #(( 0 == "${_ENABLE_TRAP}" )) && printf '%s\n' 'TRAP:';
  (( 0 == "${_ENABLE_TRAP}" )) && "${@}";
  return "${RETURN_NO_ERROR}";
}

## @comment{
## Enable or disable commands for debugging.
## }

## @fn DEBUG()
## @brief Run commands for debugging.
## @details Run debugging commands by chaining multiple commands.<br /><br />
## Example:
## @code
## DEBUG echo 'a message'
## @endcode
## @startglobal
## @itemglobal{in,integer,_ENABLE<br />Enable debug output.}
## @endglobal
## @param[in] indexed-array-of-string ${\@}<br />The command to run.
## @return void<br />return value: none<br />return code: The return code of the
## last executed command.

function DEBUG() {
  #(( 0 == "${_ENABLE_DEBUG}" )) && printf '%s\n' 'DEBUG:';
  (( 0 == "${_ENABLE_DEBUG}" )) && "${@}";
  return "${RETURN_NO_ERROR}";
}



## @comment{====================================================================
##
## local: command documentation:
## bash$ set --help
## -----------------------------------------------------------------------------
##
## allexport
##
##   same as -a
##
##   Mark variables which are modified or created for export.
##
## braceexpand
##
##   same as -B
##
##   The shell will perform brace expansion.
##
## emacs
##
##   Use an emacs-style line editing interface.
##
## errexit
##
##   same as -e
##
##   Exit immediately if a command exits with a non-zero status.
##
## errtrace
##
##   same as -E
##
##   If set, the ERR trap is inherited by shell functions.
##
## functrace
##
##   same as -T
##
##   If set, the DEBUG and RETURN traps are inherited by shell functions.
##
## hashall
##
##   same as -h
##
##   Remember the location of commands as they are looked up.
##
## histexpand
##
##   same as -H
##
##   Enable ! style history substitution.  This flag is on by default when the
##   shell is interactive.
##
## history
##
##   Enable command history.
##
## igncr
##
##   On Cygwin, ignore \r in line endings.
##
## ignoreeof
##
##   The shell will not exit upon reading EOF.
##
## interactive-comments
##
##   Allow comments to appear in interactive commands.
##
## keyword
##
##   same as -k
##
##   All assignment arguments are placed in the environment for a command, not
##   just those that precede the command name.
##
## monitor
##
##   same as -m
##
##   Job control is enabled.
##
## noclobber
##
##   same as -C
##
##   If set, disallow existing regular files to be overwritten by redirection of
##   output.
##
## noexec
##
##   same as -n
##
##   Read commands but do not execute them.
##
## noglob
##
##   same as -f
##
##   Disable file name generation (globbing).
##
## nolog
##
##   Currently accepted but ignored.
##
## notify
##
##   same as -b
##
##   Notify of job termination immediately.
##
## nounset
##
##   same as -u
##
##   Treat unset variables as an error when substituting.
##
## onecmd
##
##   same as -t
##
##   Exit after reading and executing one command.
##
## physical
##
##   same as -P
##
##   If set, do not resolve symbolic links when executing commands such as cd
##   which change the current directory.
##
## pipefail
##
##   The return value of a pipeline is the status of the last command to exit
##   with a non-zero status, or zero if no command exited with a non-zero
##   status.
##
## posix
##
##   Change the behavior of bash where the default operation differs from the
##   Posix standard to match the standard.
##
## privileged
##
##   same as -p
##
##   Turned on whenever the real and effective user ids do not match.  Disables
##   processing of the $ENV file and importing of shell functions.  Turning this
##   option off causes the effective uid and gid to be set to the real uid and
##   gid.
##
## verbose
##
##   same as -v
##
##   Print shell input lines as they are read.
##
## vi
##
##   Use a vi-style line editing interface.
##
## xtrace
##
##   same as -x
##
##   Print commands and their arguments as they are executed.
##
## ============================================================================}

## @comment{====================================================================
##
## local: man documentation:
## bash$ man set
## -----------------------------------------------------------------------------
##
## see
## BASH_BUILTINS(1)
##
## ============================================================================}

## @comment{====================================================================
##
## local: info documentation:
## bash$ info set
## -----------------------------------------------------------------------------
##
## n/a
##
## ============================================================================}

## @comment{====================================================================
##
## local: package specific documentation:
## </usr/local/doc/???>
## -----------------------------------------------------------------------------
##
## n/a
##
## ============================================================================}

## @comment{====================================================================
##
## local: source code file:
## </usr/src/???>
## -----------------------------------------------------------------------------
##
## n/a
##
## ============================================================================}

## @comment{====================================================================
##
## local: configuration file:
## </???>
## -----------------------------------------------------------------------------
##
## n/a
##
## ============================================================================}

## @comment{====================================================================
##
## remote: website:
## 4.3.1 The Set Builtin
## <https://www.gnu.org/software/bash/manual/bash.html#The-Set-Builtin>
## -----------------------------------------------------------------------------
##
## allexport
##
##   Same as -a.
##
##   Each variable or function that is created or modified is given the export
##   attribute and marked for export to the environment of subsequent commands.
##
## braceexpand
##
##   Same as -B.
##
##   The shell will perform brace expansion (see Brace Expansion).  This option
##   is on by default.
##
## emacs
##
##   Use an emacs-style line editing interface (see Command Line Editing).  This
##   also affects the editing interface used for read -e.
##
## errexit
##
##   Same as -e.
##
##   Exit immediately if a pipeline (see Pipelines), which may consist of a
##   single simple command (see Simple Commands), a list (see Lists of
##   Commands), or a compound command (see Compound Commands) returns a non-zero
##   status.  The shell does not exit if the command that fails is part of the
##   command list immediately following a while or until keyword, part of the
##   test in an if statement, part of any command executed in a && or || list
##   except the command following the final && or ||, any command in a pipeline
##   but the last, or if the command's return status is being inverted with !.
##   If a compound command other than a subshell returns a non-zero status
##   because a command failed while -e was being ignored, the shell does not
##   exit.  A trap on ERR, if set, is executed before the shell exits.
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
## errtrace
##
##   Same as -E.
##
##   If set, any trap on ERR is inherited by shell functions, command
##   substitutions, and commands executed in a subshell environment.  The ERR
##   trap is normally not inherited in such cases.
##
## functrace
##
##   Same as -T.
##
##   If set, any trap on DEBUG and RETURN are inherited by shell functions,
##   command substitutions, and commands executed in a subshell environment.
##   The DEBUG and RETURN traps are normally not inherited in such cases.
##
## hashall
##
##   Same as -h.
##
##   Locate and remember (hash) commands as they are looked up for execution.
##   This option is enabled by default.
##
## histexpand
##
##   Same as -H.
##
##   Enable '!' style history substitution (see History Expansion).  This option
##   is on by default for interactive shells.
##
## history
##
##   Enable command history, as described in Bash History Facilities.  This
##   option is on by default in interactive shells.
##
## ignoreeof
##
##   An interactive shell will not exit upon reading EOF.
##
## keyword
##
##  Same as -k.
##
##   All arguments in the form of assignment statements are placed in the
##   environment for a command, not just those that precede the command name.
##
## monitor
##
##   Same as -m.
##
##   Job control is enabled (see Job Control).  All processes run in a separate
##   process group.  When a background job completes, the shell prints a line
##   containing its exit status.
##
## noclobber
##
##   Same as -C.
##
##   Prevent output redirection using '>', '>&', and '<>' from overwriting
##   existing files.
##
## noexec
##
##   Same as -n.
##
##   Read commands but do not execute them.  This may be used to check a script
##   for syntax errors.  This option is ignored by interactive shells.
##
## noglob
##
##   Same as -f.
##
##   Disable filename expansion (globbing).
##
## nolog
##
##   Currently ignored.
##
## notify
##
##   Same as -b.
##
##   Cause the status of terminated background jobs to be reported immediately,
##   rather than before printing the next primary prompt.
##
## nounset
##
##   Same as -u.
##
##   Treat unset variables and parameters other than the special parameters '@'
##   or '*', or array variables subscripted with '@' or '*', as an error when
##   performing parameter expansion.  An error message will be written to the
##   standard error, and a non-interactive shell will exit.
##
## onecmd
##
##   Same as -t.
##
##   Exit after reading and executing one command.
##
## physical
##
##   Same as -P.
##
##   If set, do not resolve symbolic links when performing commands such as cd
##   which change the current directory.  The physical directory is used
##   instead.  By default, Bash follows the logical chain of directories when
##   performing commands which change the current directory.
##
## pipefail
##
##   If set, the return value of a pipeline is the value of the last (rightmost)
##   command to exit with a non-zero status, or zero if all commands in the
##   pipeline exit successfully.  This option is disabled by default.
##
## posix
##
##   Change the behavior of Bash where the default operation differs from the
##   POSIX standard to match the standard (see Bash POSIX Mode).  This is
##   intended to make Bash behave as a strict superset of that standard.
##
## privileged
##
##   Same as -p.
##
##   Turn on privileged mode.  In this mode, the $BASH_ENV and $ENV files are
##   not processed, shell functions are not inherited from the environment, and
##   the SHELLOPTS, BASHOPTS, CDPATH and GLOBIGNORE variables, if they appear in
##   the environment, are ignored.  If the shell is started with the effective
##   user (group) id not equal to the real user (group) id, and the -p option is
##   not supplied, these actions are taken and the effective user id is set to
##   the real user id.  If the -p option is supplied at startup, the effective
##   user id is not reset.  Turning this option off causes the effective user
##   and group ids to be set to the real user and group ids.
##
## verbose
##
##   Same as -v.
##
##   Print shell input lines as they are read.
##
## vi
##
##   Use a vi-style line editing interface.  This also affects the editing
##   interface used for read -e.
##
## xtrace
##
##   Same as -x.
##
##   Print a trace of simple commands, for commands, case commands, select
##   commands, and arithmetic for commands and their arguments or associated
##   word lists after they are expanded and before they are executed.  The value
##   of the PS4 variable is expanded and the resultant value is printed before
##   the command and its expanded arguments.
##
## -r: Enable restricted shell mode.  This option cannot be unset once it has
##   been set.
##
## ============================================================================}

## @comment{====================================================================
##
## remote: wiki:
## <https://???>
## -----------------------------------------------------------------------------
##
## n/a
##
## ============================================================================}

## @comment{====================================================================
##
## remote: forum:
## <https://???>
## -----------------------------------------------------------------------------
##
## n/a
##
## ============================================================================}

## @comment{====================================================================
##
## remote: mailing list:
## <https://???>
## -----------------------------------------------------------------------------
##
## n/a
##
## ============================================================================}

## @comment{====================================================================
##
## remote: repository:
## <https://???>
## -----------------------------------------------------------------------------
##
## ============================================================================}

## @comment{====================================================================
##
## remote: archive:
## <https://???>
## -----------------------------------------------------------------------------
##
## n/a
##
## ============================================================================}



## @comment{
## Set shell (set) options.
##
## Recommended options to enable for debugging:
##
##   bash> set -E          -e         -u         -x        -o pipefail;
##
##   which is same as
##
##   bash> set -o errtrace -o errexit -o nounset -o xtrace -o pipefail;
## }

## @comment{
## First enable the shell options to make bash more verbose.
##
## This is moved to top of the file.
## }

#set -o 'xtrace';
#set -o 'verbose';

## @comment{
## Then enable all other shell options.
## }

_DEBUG_SET set -o 'errexit';
_DEBUG_SET set -o 'errtrace';
_DEBUG_SET set -o 'functrace';
_DEBUG_SET set -o 'nounset';
_DEBUG_SET set -o 'pipefail';



## @comment{====================================================================
##
## local: command documentation:
## bash$ shopt --help
## -----------------------------------------------------------------------------
##
## n/a
##
## ============================================================================}

## @comment{====================================================================
##
## local: man documentation:
## bash$ man shopt
## -----------------------------------------------------------------------------
##
## see
## BASH_BUILTINS(1)
##
## ============================================================================}

## @comment{====================================================================
##
## local: info documentation:
## bash$ info shopt
## -----------------------------------------------------------------------------
##
## n/a
##
## ============================================================================}

## @comment{====================================================================
##
## local: package specific documentation:
## </usr/local/doc/???>
## -----------------------------------------------------------------------------
##
## n/a
##
## ============================================================================}

## @comment{====================================================================
##
## local: source code file:
## </usr/src/???>
## -----------------------------------------------------------------------------
##
## n/a
##
## ============================================================================}

## @comment{====================================================================
##
## local: configuration file:
## </???>
## -----------------------------------------------------------------------------
##
## n/a
##
## ============================================================================}

## @comment{====================================================================
##
## remote: website:
## 4.3.2 The Shopt Builtin
## <https://www.gnu.org/software/bash/manual/bash.html#The-Shopt-Builtin>
## -----------------------------------------------------------------------------
##
## assoc_expand_once
##
##   If set, the shell suppresses multiple evaluation of associative array
##   subscripts during arithmetic expression evaluation, while executing
##   builtins that can perform variable assignments, and while executing
##   builtins that perform array dereferencing.
##
## autocd
##
##   If set, a command name that is the name of a directory is executed as if it
##   were the argument to the cd command.  This option is only used by
##   interactive shells.
##
## cdable_vars
##
##   If this is set, an argument to the cd builtin command that is not a
##   directory is assumed to be the name of a variable whose value is the
##   directory to change to.
##
## cdspell
##
##   If set, minor errors in the spelling of a directory component in a cd
##   command will be corrected.  The errors checked for are transposed
##   characters, a missing character, and a character too many.  If a correction
##   is found, the corrected path is printed, and the command proceeds.  This
##   option is only used by interactive shells.
##
## checkhash
##
##   If this is set, Bash checks that a command found in the hash table exists
##   before trying to execute it.  If a hashed command no longer exists, a
##   normal path search is performed.
##
## checkjobs
##
##   If set, Bash lists the status of any stopped and running jobs before
##   exiting an interactive shell.  If any jobs are running, this causes the
##   exit to be deferred until a second exit is attempted without an intervening
##   command (see Job Control).  The shell always postpones exiting if any jobs
##   are stopped.
##
## checkwinsize
##
##   If set, Bash checks the window size after each external (non-builtin)
##   command and, if necessary, updates the values of LINES and COLUMNS.  This
##   option is enabled by default.
##
## cmdhist
##
##   If set, Bash attempts to save all lines of a multiple-line command in the
##   same history entry.  This allows easy re-editing of multi-line commands.
##   This option is enabled by default, but only has an effect if command
##   history is enabled (see Bash History Facilities).
##
## compat31, compat32, compat40, compat41, compat42, compat43, compat44
##
##   These control aspects of the shell's compatibility mode (see Shell
##   Compatibility Mode).
##
## complete_fullquote
##
##   If set, Bash quotes all shell metacharacters in filenames and directory
##   names when performing completion.  If not set, Bash removes metacharacters
##   such as the dollar sign from the set of characters that will be quoted in
##   completed filenames when these metacharacters appear in shell variable
##   references in words to be completed.  This means that dollar signs in
##   variable names that expand to directories will not be quoted; however, any
##   dollar signs appearing in filenames will not be quoted, either.  This is
##   active only when bash is using backslashes to quote completed filenames.
##   This variable is set by default, which is the default Bash behavior in
##   versions through 4.2.
##
## direxpand
##
##   If set, Bash replaces directory names with the results of word expansion
##   when performing filename completion.  This changes the contents of the
##   Readline editing buffer.  If not set, Bash attempts to preserve what the
##   user typed.
##
## dirspell
##
##   If set, Bash attempts spelling correction on directory names during word
##   completion if the directory name initially supplied does not exist.
##
## dotglob
##
##   If set, Bash includes filenames beginning with a '.' in the results of
##   filename expansion.  The filenames '.' and '..' must always be matched
##   explicitly, even if dotglob is set.
##
## execfail
##
##   If this is set, a non-interactive shell will not exit if it cannot execute
##   the file specified as an argument to the exec builtin command.  An
##   interactive shell does not exit if exec fails.
##
## expand_aliases
##
##   If set, aliases are expanded as described below under Aliases, Aliases.
##   This option is enabled by default for interactive shells.
##
## extdebug
##
##   If set at shell invocation, or in a shell startup file, arrange to execute
##   the debugger profile before the shell starts, identical to the --debugger
##   option.  If set after invocation, behavior intended for use by debuggers is
##   enabled:
##
##   1. The -F option to the declare builtin (see Bash Builtin Commands)
##      displays the source file name and line number corresponding to each
##      function name supplied as an argument.
##
##   2. If the command run by the DEBUG trap returns a non-zero value, the next
##      command is skipped and not executed.
##
##   3. If the command run by the DEBUG trap returns a value of 2, and the shell
##      is executing in a subroutine (a shell function or a shell script
##      executed by the . or source builtins), the shell simulates a call to
##      return.
##
##   4. BASH_ARGC and BASH_ARGV are updated as described in their descriptions
##      (see Bash Variables).
##
##   5. Function tracing is enabled: command substitution, shell functions, and
##      subshells invoked with ( command ) inherit the DEBUG and RETURN traps.
##
##   6. Error tracing is enabled: command substitution, shell functions, and
##      subshells invoked with ( command ) inherit the ERR trap.
##
## extglob
##
##   If set, the extended pattern matching features described above (see Pattern
##   Matching) are enabled.
##
## extquote
##
##   If set, $'string' and $"string" quoting is performed within ${parameter}
##   expansions enclosed in double quotes.  This option is enabled by default.
##
## failglob
##
##   If set, patterns which fail to match filenames during filename expansion
##   result in an expansion error.
##
## force_fignore
##
##   If set, the suffixes specified by the FIGNORE shell variable cause words to
##   be ignored when performing word completion even if the ignored words are
##   the only possible completions.  See Bash Variables, for a description of
##   FIGNORE.  This option is enabled by default.
##
## globasciiranges
##
##   If set, range expressions used in pattern matching bracket expressions (see
##   Pattern Matching) behave as if in the traditional C locale when performing
##   comparisons.  That is, the current locale's collating sequence is not taken
##   into account, so 'b' will not collate between 'A' and 'B', and upper-case
##   and lower-case ASCII characters will collate together.
##
## globskipdots
##
##   If set, filename expansion will never match the filenames '.' and '..',
##   even if the pattern begins with a '.'.  This option is enabled by default.
##
## globstar
##
##   If set, the pattern '**' used in a filename expansion context will match
##   all files and zero or more directories and subdirectories.  If the pattern
##   is followed by a '/', only directories and subdirectories match.
##
## gnu_errfmt
##
##   If set, shell error messages are written in the standard GNU error message
##   format.
##
## histappend
##
##   If set, the history list is appended to the file named by the value of the
##   HISTFILE variable when the shell exits, rather than overwriting the file.
##
## histreedit
##
##   If set, and Readline is being used, a user is given the opportunity to
##   re-edit a failed history substitution.
##
## histverify
##
##   If set, and Readline is being used, the results of history substitution are
##   not immediately passed to the shell parser.  Instead, the resulting line is
##   loaded into the Readline editing buffer, allowing further modification.
##
## hostcomplete
##
##   If set, and Readline is being used, Bash will attempt to perform hostname
##   completion when a word containing a '@' is being completed (see Letting
##   Readline Type For You).  This option is enabled by default.
##
## huponexit
##
##   If set, Bash will send SIGHUP to all jobs when an interactive login shell
##   exits (see Signals).
##
## inherit_errexit
##
##   If set, command substitution inherits the value of the errexit option,
##   instead of unsetting it in the subshell environment.  This option is
##   enabled when POSIX mode is enabled.
##
## interactive_comments
##
##   Allow a word beginning with '##' to cause that word and all remaining
##   characters on that line to be ignored in an interactive shell.  This option
##   is enabled by default.
##
## lastpipe
##
##   If set, and job control is not active, the shell runs the last command of a
##   pipeline not executed in the background in the current shell environment.
##
## lithist
##
##   If enabled, and the cmdhist option is enabled, multi-line commands are
##   saved to the history with embedded newlines rather than using semicolon
##   separators where possible.
##
## localvar_inherit
##
##   If set, local variables inherit the value and attributes of a variable of
##   the same name that exists at a previous scope before any new value is
##   assigned.  The nameref attribute is not inherited.
##
## localvar_unset
##
##   If set, calling unset on local variables in previous function scopes marks
##   them so subsequent lookups find them unset until that function returns.
##   This is identical to the behavior of unsetting local variables at the
##   current function scope.
##
## login_shell
##
##   The shell sets this option if it is started as a login shell (see Invoking
##   Bash).  The value may not be changed.
##
## mailwarn
##
##   If set, and a file that Bash is checking for mail has been accessed since
##   the last time it was checked, the message "The mail in mailfile has been
##   read" is displayed.
##
## no_empty_cmd_completion
##
##   If set, and Readline is being used, Bash will not attempt to search the
##   PATH for possible completions when completion is attempted on an empty
##   line.
##
## nocaseglob
##
##   If set, Bash matches filenames in a case-insensitive fashion when
##   performing filename expansion.
##
## nocasematch
##
##   If set, Bash matches patterns in a case-insensitive fashion when performing
##   matching while executing case or [[ conditional commands (see Conditional
##   Constructs, when performing pattern substitution word expansions, or when
##   filtering possible completions as part of programmable completion.
##
## noexpand_translation
##
##   If set, Bash encloses the translated results of $"..." quoting in single
##   quotes instead of double quotes.  If the string is not translated, this has
##   no effect.
##
## nullglob
##
##   If set, Bash allows filename patterns which match no files to expand to a
##   null string, rather than themselves.
##
## patsub_replacement
##
##   If set, Bash expands occurrences of '&' in the replacement string of
##   pattern substitution to the text matched by the pattern, as described above
##   (see Shell Parameter Expansion).  This option is enabled by default.
##
## progcomp
##
##   If set, the programmable completion facilities (see Programmable
##   Completion) are enabled.  This option is enabled by default.
##
## progcomp_alias
##
##   If set, and programmable completion is enabled, Bash treats a command name
##   that doesn't have any completions as a possible alias and attempts alias
##   expansion.  If it has an alias, Bash attempts programmable completion using
##   the command word resulting from the expanded alias.
##
## promptvars
##
##   If set, prompt strings undergo parameter expansion, command substitution,
##   arithmetic expansion, and quote removal after being expanded as described
##   below (see Controlling the Prompt).  This option is enabled by default.
##
## restricted_shell
##
##   The shell sets this option if it is started in restricted mode (see The
##   Restricted Shell).  The value may not be changed.  This is not reset when
##   the startup files are executed, allowing the startup files to discover
##   whether or not a shell is restricted.
##
## shift_verbose
##
##   If this is set, the shift builtin prints an error message when the shift
##   count exceeds the number of positional parameters.
##
## sourcepath
##
##   If set, the . (source) builtin uses the value of PATH to find the directory
##   containing the file supplied as an argument.  This option is enabled by
##   default.
##
## varredir_close
##
##   If set, the shell automatically closes file descriptors assigned using the
##   {varname} redirection syntax (see Redirections) instead of leaving them
##   open when the command completes.
##
## xpg_echo
##
##   If set, the echo builtin expands backslash-escape sequences by default.
##
## ============================================================================}

## @comment{====================================================================
##
## remote: wiki:
## <https://???>
## -----------------------------------------------------------------------------
##
## n/a
##
## ============================================================================}

## @comment{====================================================================
##
## remote: forum:
## <https://???>
## -----------------------------------------------------------------------------
##
## n/a
##
## ============================================================================}

## @comment{====================================================================
##
## remote: mailing list:
## <https://???>
## -----------------------------------------------------------------------------
##
## n/a
##
## ============================================================================}

## @comment{====================================================================
##
## remote: repository:
## <https://???>
## -----------------------------------------------------------------------------
##
## n/a
##
## ============================================================================}

## @comment{====================================================================
##
## remote: archive:
## <https://???>
## -----------------------------------------------------------------------------
##
## n/a
##
## ============================================================================}



## @comment{
## Set shell additional shell (shopt) options.
## }

_DEBUG_SHOPT shopt -s 'extdebug';
_DEBUG_SHOPT shopt -s 'shift_verbose';



## @comment{====================================================================
##
## local: command documentation:
## bash$ trap --help
## -----------------------------------------------------------------------------
##
## If a SIGNAL_SPEC is EXIT (0) ARG is executed on exit from the shell.
##
## If a SIGNAL_SPEC is DEBUG, ARG is executed before every simple command.
##
## If a SIGNAL_SPEC is RETURN, ARG is executed each time a shell function or a
## script run by the . or source builtins finishes executing.
##
## A SIGNAL_SPEC of ERR means to execute ARG each time a command's failure would
## cause the shell to exit when the -e option is enabled.
##
## ============================================================================}

## @comment{====================================================================
##
## local: command documentation:
## bash$ trap -l
## -----------------------------------------------------------------------------
##
##
## List of signal names and their corresponding numbers:
##
##  1) SIGHUP
##  2) SIGINT
##  3) SIGQUIT
##  4) SIGILL
##  5) SIGTRAP
##  6) SIGABRT
##  7) SIGEMT
##  8) SIGFPE
##  9) SIGKILL
## 10) SIGBUS
## 11) SIGSEGV
## 12) SIGSYS
## 13) SIGPIPE
## 14) SIGALRM
## 15) SIGTERM
## 16) SIGURG
## 17) SIGSTOP
## 18) SIGTSTP
## 19) SIGCONT
## 20) SIGCHLD
## 21) SIGTTIN
## 22) SIGTTOU
## 23) SIGIO
## 24) SIGXCPU
## 25) SIGXFSZ
## 26) SIGVTALRM
## 27) SIGPROF
## 28) SIGWINCH
## 29) SIGPWR
## 30) SIGUSR1
## 31) SIGUSR2
## 32) SIGRTMIN
## 33) SIGRTMIN+1
## 34) SIGRTMIN+2
## 35) SIGRTMIN+3
## 36) SIGRTMIN+4
## 37) SIGRTMIN+5
## 38) SIGRTMIN+6
## 39) SIGRTMIN+7
## 40) SIGRTMIN+8
## 41) SIGRTMIN+9
## 42) SIGRTMIN+10
## 43) SIGRTMIN+11
## 44) SIGRTMIN+12
## 45) SIGRTMIN+13
## 46) SIGRTMIN+14
## 47) SIGRTMIN+15
## 48) SIGRTMIN+16
## 49) SIGRTMAX-15
## 50) SIGRTMAX-14
## 51) SIGRTMAX-13
## 52) SIGRTMAX-12
## 53) SIGRTMAX-11
## 54) SIGRTMAX-10
## 55) SIGRTMAX-9
## 56) SIGRTMAX-8
## 57) SIGRTMAX-7
## 58) SIGRTMAX-6
## 59) SIGRTMAX-5
## 60) SIGRTMAX-4
## 61) SIGRTMAX-3
## 62) SIGRTMAX-2
## 63) SIGRTMAX-1
## 64) SIGRTMAX
##
## ============================================================================}
## @comment{====================================================================
##
## local: man documentation:
## bash$ man trap
## -----------------------------------------------------------------------------
##
## see
## BASH_BUILTINS
##
## ============================================================================}

## @comment{====================================================================
##
## local: info documentation:
## bash$ info trap
## -----------------------------------------------------------------------------
##
## n/a
##
## ============================================================================}

## @comment{====================================================================
##
## local: package specific documentation:
## </usr/local/doc/???>
## -----------------------------------------------------------------------------
##
## n/a
##
## ============================================================================}

## @comment{====================================================================
##
## local: source code file:
## </usr/src/???>
## -----------------------------------------------------------------------------
##
## n/a
##
## ============================================================================}

## @comment{====================================================================
##
## local: configuration file:
## </???>
## -----------------------------------------------------------------------------
##
## n/a
##
## ============================================================================}

## @comment{====================================================================
##
## local: command documentation:
## bash$ kill --help
## -----------------------------------------------------------------------------
##
## ============================================================================}

## @comment{====================================================================
##
## local: command documentation:
## bash$ kill -l
## -----------------------------------------------------------------------------
##
## same as
## bash$ trap -l
##
## ============================================================================}

## @comment{====================================================================
##
## local: man documentation:
## bash$ man kill
## -----------------------------------------------------------------------------
##
## Here is a list of available signals, their numbers, and some commentary on
## them, from the file <sys/signal.h>, which should be considered the official
## source of this information.
##
## SIGHUP       1    hangup
## SIGINT       2    interrupt
## SIGQUIT      3    quit
## SIGILL       4    illegal instruction (not reset when caught)
## SIGTRAP      5    trace trap (not reset when caught)
## SIGABRT      6    used by abort
## SIGIOT       6    another name for SIGABRT
## SIGEMT       7    EMT instruction
## SIGFPE       8    floating point exception
## SIGKILL      9    kill (cannot be caught or ignored)
## SIGBUS      10    bus error
## SIGSEGV     11    segmentation violation
## SIGSYS      12    bad argument to system call
## SIGPIPE     13    write on a pipe with no one to read it
## SIGALRM     14    alarm clock
## SIGTERM     15    software termination signal from kill
## SIGURG      16    urgent condition on IO channel
## SIGSTOP     17    sendable stop signal not from tty
## SIGTSTP     18    stop signal from tty
## SIGCONT     19    continue a stopped process
## SIGCHLD     20    to parent on child stop or exit
## SIGCLD      20    System V name for SIGCHLD
## SIGTTIN     21    to readers pgrp upon background tty read
## SIGTTOU     22    like TTIN for output if (tp->t_local&LTOSTOP)
## SIGIO       23    input/output possible
## SIGPOLL     23    System V name for SIGIO
## SIGXCPU     24    exceeded CPU time limit
## SIGXFSZ     25    exceeded file size limit
## SIGVTALRM   26    virtual time alarm
## SIGPROF     27    profiling time alarm
## SIGWINCH    28    window changed
## SIGLOST     29    resource lost (eg, record-lock lost)
## SIGPWR      29    power failure
## SIGUSR1     30    user defined signal 1
## SIGUSR2     31    user defined signal 2
##
## ============================================================================}

## @comment{====================================================================
##
## local: info documentation:
## bash$ info kill
## -----------------------------------------------------------------------------
##
## 2.5 Signal specifications
## =========================
##
## A SIGNAL may be a signal name like 'HUP', or a signal number like '1', or an
## exit status of a process terminated by the signal.  A signal name can be
## given in canonical form or prefixed by 'SIG'.  The case of the letters is
## ignored.  The following signal names and numbers are supported on all POSIX
## compliant systems:
##
## 'HUP'
##
##    1.  Hangup.
##
## 'INT'
##
##    2.  Terminal interrupt.
##
## 'QUIT'
##
##    3.  Terminal quit.
##
## 'ABRT'
##
##    6.  Process abort.
##
## 'KILL'
##
##    9.  Kill (cannot be caught or ignored).
##
## 'ALRM'
##
##   14.  Alarm Clock.
##
## 'TERM'
##
##   15.  Termination.
##
## Other supported signal names have system-dependent corresponding numbers.
## All systems conforming to POSIX 1003.1-2001 also support the following
## signals:
##
## 'BUS'
##
##   Access to an undefined portion of a memory object.
##
## 'CHLD'
##
##   Child process terminated, stopped, or continued.
##
## 'CONT'
##
##   Continue executing, if stopped.
##
## 'FPE'
##
##   Erroneous arithmetic operation.
##
## 'ILL'
##
##   Illegal Instruction.
##
## 'PIPE'
##
##   Write on a pipe with no one to read it.
##
## 'SEGV'
##
##   Invalid memory reference.
##
## 'STOP'
##
##   Stop executing (cannot be caught or ignored).
##
## 'TSTP'
##
##   Terminal stop.
##
## 'TTIN'
##
##   Background process attempting read.
##
## 'TTOU'
##
##   Background process attempting write.
##
## 'URG'
##
##   High bandwidth data is available at a socket.
##
## 'USR1'
##
##   User-defined signal 1.
##
## 'USR2'
##
##   User-defined signal 2.
##
## POSIX 1003.1-2001 systems that support the XSI extension also support the
## following signals:
##
## 'POLL'
##
##   Pollable event.
##
## 'PROF'
##
##   Profiling timer expired.
##
## 'SYS'
##
##   Bad system call.
##
## 'TRAP'
##
##   Trace/breakpoint trap.
##
## 'VTALRM'
##
##   Virtual timer expired.
##
## 'XCPU'
##
##   CPU time limit exceeded.
##
## 'XFSZ'
##
##   File size limit exceeded.
##
## POSIX 1003.1-2001 systems that support the XRT extension also support at
## least eight real-time signals called 'RTMIN', 'RTMIN+1', ..., 'RTMAX-1',
## 'RTMAX'.
##
## ============================================================================}

## @comment{====================================================================
##
## local: package specific documentation:
## </usr/local/doc/???>
## -----------------------------------------------------------------------------
##
## n/a
##
## ============================================================================}

## @comment{====================================================================
##
## local: source code file:
## </usr/src/???>
## -----------------------------------------------------------------------------
##
## n/a
##
## ============================================================================}

## @comment{====================================================================
##
## local: configuration file:
## </???>
## -----------------------------------------------------------------------------
##
## n/a
##
## ============================================================================}

## @comment{====================================================================
##
## local: command documentation:
## bash$ stty --help
## -----------------------------------------------------------------------------
##
## ============================================================================}

## @comment{====================================================================
##
## local: command documentation:
## bash$ stty --all
## -----------------------------------------------------------------------------
##
## speed 38400 baud;
## rows 39;
## columns 134;                        libc      perl
##                                     -------   -------
## line    = 0;
## intr    = ^C;              CTRL-C   SIGINT    SIGINT
## quit    = ^\;              CTRL-\   SIGQUIT   SIGQUIT
## erase   = ^?;              CTRL-?
## kill    = ^U;              CTRL-U
## eof     = ^D;              CTRL-D
## eol     = <undef>;
## eol2    = <undef>;
## swtch   = ^Z;              CTRL-Z
## start   = ^Q;              CTRL-Q             SIGCONT
## stop    = ^S;              CTRL-S             SIGSTOP
## susp    = ^Z;              CTRL-Z   SIGTSTP   SIGTSTP
## rprnt   = ^R;              CTRL-R
## werase  = ^W;              CTRL-W
## lnext   = ^V;              CTRL-V
## discard = ^O;              CTRL-O
## min     = 1;
## time    = 0;
##
## -parenb
## -parodd
## -cmspar cs8
## -hupcl
## -cstopb cread
## -clocal
## -crtscts
## -ignbrk brkint
## -ignpar
## -parmrk
## -inpck
## -istrip
## -inlcr
## -igncr icrnl ixon
## -ixoff
## -iuclc ixany imaxbel iutf8 opost
## -olcuc
## -ocrnl onlcr
## -onocr
## -onlret
## -ofill
## -ofdel nl0 cr0 tab0 bs0 vt0 ff0 isig icanon iexten echo echoe echok
## -echonl
## -noflsh
## -tostop echoctl echoke
## -flusho
##
## ============================================================================}

## @comment{====================================================================
##
## local: man documentation:
## bash$ man stty
## -----------------------------------------------------------------------------
##
## ============================================================================}

## @comment{====================================================================
##
## local: info documentation:
## bash$ info stty
## -----------------------------------------------------------------------------
##
## 19.2.6 Special characters
## -------------------------
##
## The special characters' default values vary from system to system.  They are
## set with the syntax 'name value', where the names are listed below and the
## value can be given either literally, in hat notation ('^C'), or as an integer
## which may start with '0x' to indicate hexadecimal, '0' to indicate octal, or
## any other digit to indicate decimal.
##
## For GNU stty, giving a value of '^-' or 'undef' disables that special
## character.  (This is incompatible with Ultrix 'stty', which uses a value of
## 'u' to disable a special character.  GNU 'stty' treats a value 'u' like any
## other, namely to set that special character to <U>.)
##
## 'intr'
##
##    Send an interrupt signal.
##
## 'quit'
##
##    Send a quit signal.
##
## 'erase'
##
##    Erase the last character typed.
##
## 'kill'
##
##    Erase the current line.
##
## 'eof'
##
##    Send an end of file (terminate the input).
##
## 'eol'
##
##    End the line.
##
## 'eol2'
##
##    Alternate character to end the line.  Non-POSIX.
##
## 'discard'
##
##    Alternate character to toggle discarding of output.  Non-POSIX.
##
## 'swtch'
##
##    Switch to a different shell layer.  Non-POSIX.
##
## 'status'
##
##    Send an info signal.  Not currently supported on Linux.  Non-POSIX.
##
## 'start'
##
##    Restart the output after stopping it.
##
## 'stop'
##
##    Stop the output.
##
## 'susp'
##
##    Send a terminal stop signal.
##
## 'dsusp'
##
##    Send a terminal stop signal after flushing the input.  Non-POSIX.
##
## 'rprnt'
##
##    Redraw the current line.  Non-POSIX.
##
## 'werase'
##
##    Erase the last word typed.  Non-POSIX.
##
## 'lnext'
##
##    Enter the next character typed literally, even if it is a special
##    character.  Non-POSIX.
##
## ============================================================================}

## @comment{====================================================================
##
## local: package specific documentation:
## </usr/local/doc/???>
## -----------------------------------------------------------------------------
##
## n/a
##
## ============================================================================}

## @comment{====================================================================
##
## local: source code file:
## </usr/src/???>
## -----------------------------------------------------------------------------
##
## n/a
##
## ============================================================================}

## @comment{====================================================================
##
## local: configuration file:
## </???>
## -----------------------------------------------------------------------------
##
## n/a
##
## ============================================================================}

## @comment{====================================================================
##
## remote: website:
## "termios, tcgetattr, tcsetattr, tcsendbreak, tcdrain, tcflush, tcflow,
## cfmakeraw, cfgetospeed, cfgetispeed, cfsetispeed, cfsetospeed, cfsetspeed -
## get and set terminal attributes, line control, get and set baud rate"
## <https://manpages.debian.org/bookworm/manpages-dev/termios.3.en.html>
## -----------------------------------------------------------------------------
##
## The c_cc array defines the terminal special characters.  The symbolic indices
## (initial values) and meaning are:
##
## VDISCARD
##
##   (not in POSIX; not supported under Linux; 017, SI, Ctrl-O) Toggle:
##   start/stop discarding pending output.  Recognized when IEXTEN is set, and
##   then not passed as input.
##
## VDSUSP
##
##   (not in POSIX; not supported under Linux; 031, EM, Ctrl-Y) Delayed suspend
##   character (DSUSP): send SIGTSTP signal when the character is read by the
##   user program.  Recognized when IEXTEN and ISIG are set, and the system
##   supports job control, and then not passed as input.
##
## VEOF
##
##   (004, EOT, Ctrl-D) End-of-file character (EOF).  More precisely: this
##   character causes the pending tty buffer to be sent to the waiting user
##   program without waiting for end-of-line.  If it is the first character of
##   the line, the read(2) in the user program returns 0, which signifies
##   end-of-file.  Recognized when ICANON is set, and then not passed as input.
##
## VEOL
##
##   (0, NUL) Additional end-of-line character (EOL).  Recognized when ICANON is
##   set.
##
## VEOL2
##
##   (not in POSIX; 0, NUL) Yet another end-of-line character (EOL2).
##   Recognized when ICANON is set.
##
## VERASE
##
##   (0177, DEL, rubout, or 010, BS, Ctrl-H, or also #) Erase character (ERASE).
##   This erases the previous not-yet-erased character, but does not erase past
##   EOF or beginning-of-line.  Recognized when ICANON is set, and then not
##   passed as input.
##
## VINTR
##
##   (003, ETX, Ctrl-C, or also 0177, DEL, rubout) Interrupt character (INTR).
##   Send a SIGINT signal.  Recognized when ISIG is set, and then not passed as
##   input.
##
## VKILL
##
##   (025, NAK, Ctrl-U, or Ctrl-X, or also @) Kill character (KILL).  This
##   erases the input since the last EOF or beginning-of-line.  Recognized when
##   ICANON is set, and then not passed as input.
##
## VLNEXT
##
##   (not in POSIX; 026, SYN, Ctrl-V) Literal next (LNEXT).  Quotes the next
##   input character, depriving it of a possible special meaning.  Recognized
##   when IEXTEN is set, and then not passed as input.
##
## VMIN
##
##   Minimum number of characters for noncanonical read (MIN).
##
## VQUIT
##
##   (034, FS, Ctrl-\) Quit character (QUIT).  Send SIGQUIT signal.  Recognized
##   when ISIG is set, and then not passed as input.
##
## VREPRINT
##
##   (not in POSIX; 022, DC2, Ctrl-R) Reprint unread characters (REPRINT).
##   Recognized when ICANON and IEXTEN are set, and then not passed as input.
##
## VSTART
##
##   (021, DC1, Ctrl-Q) Start character (START).  Restarts output stopped by the
##   Stop character.  Recognized when IXON is set, and then not passed as input.
##
## VSTATUS
##
##   (not in POSIX; not supported under Linux; status request: 024, DC4,
##   Ctrl-T).  Status character (STATUS).  Display status information at
##   terminal, including state of foreground process and amount of CPU time it
##   has consumed.  Also sends a SIGINFO signal (not supported on Linux) to the
##   foreground process group.
##
## VSTOP
##
##   (023, DC3, Ctrl-S) Stop character (STOP).  Stop output until Start
##   character typed.  Recognized when IXON is set, and then not passed as
##   input.
##
## VSUSP
##
##   (032, SUB, Ctrl-Z) Suspend character (SUSP).  Send SIGTSTP signal.
##   Recognized when ISIG is set, and then not passed as input.
##
## VSWTCH
##
##   (not in POSIX; not supported under Linux; 0, NUL) Switch character (SWTCH).
##   Used in System V to switch shells in shell layers, a predecessor to shell
##   job control.
##
## VTIME
##
## Timeout in deciseconds for noncanonical read (TIME).
##
## VWERASE
##
##   (not in POSIX; 027, ETB, Ctrl-W) Word erase (WERASE).  Recognized when
##   ICANON and IEXTEN are set, and then not passed as input.
##
## An individual terminal special character can be disabled by setting the value
## of the corresponding c_cc element to _POSIX_VDISABLE.
##
## The above symbolic subscript values are all different, except that VTIME,
## VMIN may have the same value as VEOL, VEOF, respectively.  In noncanonical
## mode the special character meaning is replaced by the timeout meaning.  For
## an explanation of VMIN and VTIME, see the description of noncanonical mode
## below.a
##
## ============================================================================}

## @comment{====================================================================
##
## remote: website:
## signal - ANSI C signal handling
## <https://manpages.debian.org/bookworm/manpages-dev/signal.2.en.html>
## -----------------------------------------------------------------------------
##
## see
## man 7 signal
##
## ============================================================================}

## @comment{====================================================================
##
## remote: website:
## signal - overview of signals
## <https://manpages.debian.org/bookworm/manpages/signal.7.en.html>
## -----------------------------------------------------------------------------
##
## Standard signals
##
## Linux supports the standard signals listed below.  The second column of the
## table indicates which standard (if any) specified the signal: "P1990"
## indicates that the signal is described in the original POSIX.1-1990 standard;
## "P2001" indicates that the signal was added in SUSv2 and POSIX.1-2001.
##
## Signal      Standard   Action   Comment
##  ---------   --------   ------   -------------------------------------------
##
## SIGABRT     P1990      Core     Abort signal from abort(3)
## SIGALRM     P1990      Term     Timer signal from alarm(2)
## SIGBUS      P2001      Core     Bus error (bad memory access)
## SIGCHLD     P1990      Ign      Child stopped or terminated
## SIGCLD      -          Ign      A synonym for SIGCHLD
## SIGCONT     P1990      Cont     Continue if stopped
## SIGEMT      -          Term     Emulator trap
## SIGFPE      P1990      Core     Floating-point exception
## SIGHUP      P1990      Term     Hangup detected on controlling terminal or
##                                 death of controlling process
## SIGILL      P1990      Core     Illegal Instruction
## SIGINFO     -                   A synonym for SIGPWR
## SIGINT      P1990      Term     Interrupt from keyboard
## SIGIO       -          Term     I/O now possible (4.2BSD)
## SIGIOT      -          Core     IOT trap.  A synonym for SIGABRT
## SIGKILL     P1990      Term     Kill signal
## SIGLOST     -          Term     File lock lost (unused)
## SIGPIPE     P1990      Term     Broken pipe: write to pipe with no readers;
##                                 see pipe(7)
## SIGPOLL     P2001      Term     Pollable event (Sys V); synonym for SIGIO
## SIGPROF     P2001      Term     Profiling timer expired
## SIGPWR      -          Term     Power failure (System V)
## SIGQUIT     P1990      Core     Quit from keyboard
## SIGSEGV     P1990      Core     Invalid memory reference
## SIGSTKFLT   -          Term     Stack fault on coprocessor (unused)
## SIGSTOP     P1990      Stop     Stop process
## SIGTSTP     P1990      Stop     Stop typed at terminal
## SIGSYS      P2001      Core     Bad system call (SVr4); see also seccomp(2)
## SIGTERM     P1990      Term     Termination signal
## SIGTRAP     P2001      Core     Trace/breakpoint trap
## SIGTTIN     P1990      Stop     Terminal input for background process
## SIGTTOU     P1990      Stop     Terminal output for background process
## SIGUNUSED   -          Core     Synonymous with SIGSYS
## SIGURG      P2001      Ign      Urgent condition on socket (4.2BSD)
## SIGUSR1     P1990      Term     User-defined signal 1
## SIGUSR2     P1990      Term     User-defined signal 2
## SIGVTALRM   P2001      Term     Virtual alarm clock (4.2BSD)
## SIGXCPU     P2001      Core     CPU time limit exceeded (4.2BSD); see
##                                 setrlimit(2)
## SIGXFSZ     P2001      Core     File size limit exceeded (4.2BSD); see
##                                 setrlimit(2)
## SIGWINCH    -          Ign      Window resize signal (4.3BSD, Sun)
##
## The signals SIGKILL and SIGSTOP cannot be caught, blocked, or ignored.
##
## Up to and including Linux 2.2, the default behavior for SIGSYS, SIGXCPU,
## SIGXFSZ, and (on architectures other than SPARC and MIPS) SIGBUS was to
## terminate the process (without a core dump).  (On some other UNIX systems the
## default action for SIGXCPU and SIGXFSZ is to terminate the process without a
## core dump.)  Linux 2.4 conforms to the POSIX.1-2001 requirements for these
## signals, terminating the process with a core dump.
##
## SIGEMT is not specified in POSIX.1-2001, but nevertheless appears on most
## other UNIX systems, where its default action is typically to terminate the
## process with a core dump.
##
## SIGPWR (which is not specified in POSIX.1-2001) is typically ignored by
## default on those other UNIX systems where it appears.
##
## SIGIO (which is not specified in POSIX.1-2001) is ignored by default on
## several other UNIX systems.
##
## ============================================================================}

## @comment{====================================================================
##
## remote: website:
## signal - overview of signals
## <https://manpages.debian.org/bookworm/manpages/signal.7.en.html>
## -----------------------------------------------------------------------------
##
## Signal numbering for standard signals
##
## The numeric value for each signal is given in the table below.  As shown in
## the table, many signals have different numeric values on different
## architectures.  The first numeric value in each table row shows the signal
## number on x86, ARM, and most other architectures; the second value is for
## Alpha and SPARC; the third is for MIPS; and the last is for PARISC.  A dash
## (-) denotes that a signal is absent on the corresponding architecture.
##
## Signal      x86/ARM       Alpha/   MIPS   PARISC   Notes
##             most others   SPARC
## ---------   -----------   ------   ----   ------   -------------
##
## SIGHUP       1             1        1      1
## SIGINT       2             2        2      2
## SIGQUIT      3             3        3      3
## SIGILL       4             4        4      4
## SIGTRAP      5             5        5      5
## SIGABRT      6             6        6      6
## SIGIOT       6             6        6      6
## SIGBUS       7            10       10     10
## SIGEMT       -             7        7      -
## SIGFPE       8             8        8      8
## SIGKILL      9             9        9      9
## SIGUSR1     10            30       16     16
## SIGSEGV     11            11       11     11
## SIGUSR2     12            31       17     17
## SIGPIPE     13            13       13     13
## SIGALRM     14            14       14     14
## SIGTERM     15            15       15     15
## SIGSTKFLT   16             -        -      7
## SIGCHLD     17            20       18     18
## SIGCLD       -             -       18      -
## SIGCONT     18            19       25     26
## SIGSTOP     19            17       23     24
## SIGTSTP     20            18       24     25
## SIGTTIN     21            21       26     27
## SIGTTOU     22            22       27     28
## SIGURG      23            16       21     29
## SIGXCPU     24            24       30     12
## SIGXFSZ     25            25       31     30
## SIGVTALRM   26            26       28     20
## SIGPROF     27            27       29     21
## SIGWINCH    28            28       20     23
## SIGIO       29            23       22     22
## SIGPOLL                                            Same as SIGIO
## SIGPWR      30            29/-     19     19
## SIGINFO      -            29/-      -      -
## SIGLOST      -             -/29     -      -
## SIGSYS      31            12       12     31
## SIGUNUSED   31             -        -     31
##
## Note the following:
##
## * Where defined, SIGUNUSED is synonymous with SIGSYS.  Since glibc 2.26,
##   SIGUNUSED is no longer defined on any architecture.
##
## * Signal 29 is SIGINFO/SIGPWR (synonyms for the same value) on Alpha but
##   SIGLOST on SPARC.
##
## ============================================================================}

## @comment{====================================================================
##
## signal - overview of signals
## <https://manpages.debian.org/bookworm/manpages/signal.7.en.html>
## -----------------------------------------------------------------------------
##
## Real-time signals
##
## Starting with Linux 2.2, Linux supports real-time signals as originally
## defined in the POSIX.1b real-time extensions (and now included in
## POSIX.1-2001).  The range of supported real-time signals is defined by the
## macros SIGRTMIN and SIGRTMAX.  POSIX.1-2001 requires that an implementation
## support at least _POSIX_RTSIG_MAX (8) real-time signals.
##
## The Linux kernel supports a range of 33 different real-time signals, numbered
## 32 to 64.  However, the glibc POSIX threads implementation internally uses
## two (for NPTL) or three (for LinuxThreads) real-time signals (see
## pthreads(7)), and adjusts the value of SIGRTMIN suitably (to 34 or 35).
## Because the range of available real-time signals varies according to the
## glibc threading implementation (and this variation can occur at run time
## according to the available kernel and glibc), and indeed the range of
## real-time signals varies across UNIX systems, programs should never refer to
## real-time signals using hard-coded numbers, but instead should always refer
## to real-time signals using the notation SIGRTMIN+n, and include suitable
## (run-time) checks that SIGRTMIN+n does not exceed SIGRTMAX.
##
## Unlike standard signals, real-time signals have no predefined meanings: the
## entire set of real-time signals can be used for application-defined purposes.
##
## The default action for an unhandled real-time signal is to terminate the
## receiving process.
##
## Real-time signals are distinguished by the following:
##
## * Multiple instances of real-time signals can be queued.  By contrast, if
##   multiple instances of a standard signal are delivered while that signal is
##   currently blocked, then only one instance is queued.
##
## * If the signal is sent using sigqueue(3), an accompanying value (either an
##   integer or a pointer) can be sent with the signal.  If the receiving
##   process establishes a handler for this signal using the SA_SIGINFO flag to
##   sigaction(2), then it can obtain this data via the si_value field of the
##   siginfo_t structure passed as the second argument to the handler.
##   Furthermore, the si_pid and si_uid fields of this structure can be used to
##   obtain the PID and real user ID of the process sending the signal.
##
## * Real-time signals are delivered in a guaranteed order.  Multiple real-time
##   signals of the same type are delivered in the order they were sent.  If
##   different real-time signals are sent to a process, they are delivered
##   starting with the lowest-numbered signal.  (I.e., low-numbered signals have
##   highest priority.)  By contrast, if multiple standard signals are pending
##   for a process, the order in which they are delivered is unspecified.
##
## If both standard and real-time signals are pending for a process, POSIX
## leaves it unspecified which is delivered first.  Linux, like many other
## implementations, gives priority to standard signals in this case.
##
## According to POSIX, an implementation should permit at least
## _POSIX_SIGQUEUE_MAX (32) real-time signals to be queued to a process.
## However, Linux does things differently.  Up to and including Linux 2.6.7,
## Linux imposes a system-wide limit on the number of queued real-time signals
## for all processes.  This limit can be viewed and (with privilege) changed via
## the /proc/sys/kernel/rtsig-max file.  A related file,
## /proc/sys/kernel/rtsig-nr, can be used to find out how many real-time signals
## are currently queued.  In Linux 2.6.8, these /proc interfaces were replaced
## by the RLIMIT_SIGPENDING resource limit, which specifies a per-user limit for
## queued signals; see setrlimit(2) for further details.
##
## ============================================================================}

## @comment{====================================================================
##
## remote: website:
## 4.1 Bourne Shell Builtins
## <https://www.gnu.org/software/bash/manual/bash.html#Bourne-Shell-Builtins>
## -----------------------------------------------------------------------------
##
## trap
##
##   trap [-lp] [arg] [sigspec ...]
##
## The commands in arg are to be read and executed when the shell receives
## signal sigspec.  If arg is absent (and there is a single sigspec) or equal
## to '-', each specified signal's disposition is reset to the value it had
## when the shell was started.  If arg is the null string, then the signal
## specified by each sigspec is ignored by the shell and commands it invokes.
## If arg is not present and -p has been supplied, the shell displays the trap
## commands associated with each sigspec.  If no arguments are supplied, or
## only -p is given, trap prints the list of commands associated with each
## signal number in a form that may be reused as shell input.  The -l option
## causes the shell to print a list of signal names and their corresponding
## numbers.  Each sigspec is either a signal name or a signal number.  Signal
## names are case insensitive and the SIG prefix is optional.
##
## If a sigspec is 0 or EXIT, arg is executed when the shell exits.  If a
## sigspec is DEBUG, the command arg is executed before every simple command,
## for command, case command, select command, every arithmetic for command, and
## before the first command executes in a shell function.  Refer to the
## description of the extdebug option to the shopt builtin (see The Shopt
## Builtin) for details of its effect on the DEBUG trap.  If a sigspec is
## RETURN, the command arg is executed each time a shell function or a script
## executed with the . or source builtins finishes executing.
##
## If a sigspec is ERR, the command arg is executed whenever a pipeline (which
## may consist of a single simple command), a list, or a compound command
## returns a non-zero exit status, subject to the following conditions.  The ERR
## trap is not executed if the failed command is part of the command list
## immediately following an until or while keyword, part of the test following
## the if or elif reserved words, part of a command executed in a && or || list
## except the command following the final && or ||, any command in a pipeline
## but the last, or if the command's return status is being inverted using !.
## These are the same conditions obeyed by the errexit (-e) option.
##
## Signals ignored upon entry to the shell cannot be trapped or reset.  Trapped
## signals that are not being ignored are reset to their original values in a
## subshell or subshell environment when one is created.
##
## The return status is zero unless a sigspec does not specify a valid signal.
##
## ============================================================================}

## @comment{====================================================================
##
## remote: website:
## 17.4.9.2 Characters that Cause Signals
## <https://www.gnu.org/software/libc/manual/html_mono/libc.html#Signal-
##  Characters>
## -----------------------------------------------------------------------------
##
## 17.4.9.2 Characters that Cause Signals
##
## These special characters may be active in either canonical or noncanonical
## input mode, but only when the ISIG flag is set (see Local Modes).
##
## Macro: int VINTR
##
##   This is the subscript for the INTR character in the special control
##   character array.  termios.c_cc[VINTR] holds the character itself.
##
##   The INTR (interrupt) character raises a SIGINT signal for all processes in
##   the foreground job associated with the terminal.  The INTR character itself
##   is then discarded.  See Signal Handling, for more information about
##   signals.
##
##   Typically, the INTR character is C-c.
##
## Macro: int VQUIT
##
##   This is the subscript for the QUIT character in the special control
##   character array.  termios.c_cc[VQUIT] holds the character itself.
##
##   The QUIT character raises a SIGQUIT signal for all processes in the
##   foreground job associated with the terminal.  The QUIT character itself is
##   then discarded.  See Signal Handling, for more information about signals.
##
##   Typically, the QUIT character is C-\.
##
## Macro: int VSUSP
##
##   This is the subscript for the SUSP character in the special control
##   character array.  termios.c_cc[VSUSP] holds the character itself.
##
##   The SUSP (suspend) character is recognized only if the implementation
##   supports job control (see Job Control).  It causes a SIGTSTP signal to be
##   sent to all processes in the foreground job associated with the terminal.
##   The SUSP character itself is then discarded.  See Signal Handling, for more
##   information about signals.
##
##   Typically, the SUSP character is C-z.
##
## Few applications disable the normal interpretation of the SUSP character.  If
## your program does this, it should provide some other mechanism for the user
## to stop the job.  When the user invokes this mechanism, the program should
## send a SIGTSTP signal to the process group of the process, not just to the
## process itself.  See Signaling Another Process.
##
## Macro: int VDSUSP
##
##   This is the subscript for the DSUSP character in the special control
##   character array.  termios.c_cc[VDSUSP] holds the character itself.
##
##   The DSUSP (suspend) character is recognized only if the implementation
##   supports job control (see Job Control).  It sends a SIGTSTP signal, like
##   the SUSP character, but not right away-only when the program tries to read
##   it as input.  Not all systems with job control support DSUSP; only
##   BSD-compatible systems do (including GNU/Hurd systems).
##
##   See Signal Handling, for more information about signals.
##
##   Typically, the DSUSP character is C-y.
##
## ============================================================================}

## @comment{====================================================================
##
## remote: website:
## 24.2.2 Termination Signals
## <https://www.gnu.org/ software/libc/manual/html_mono/libc.html#Termination-
## Signals>
## -----------------------------------------------------------------------------
##
## online resource website:
## -----------------------------------------------------------------------------
##
## 24.2.2 Termination Signals
##
## These signals are all used to tell a process to terminate, in one way or
## another.  They have different names because they're used for slightly
## different purposes, and programs might want to handle them differently.
##
## The reason for handling these signals is usually so your program can tidy up
## as appropriate before actually terminating.  For example, you might want to
## save state information, delete temporary files, or restore the previous
## terminal modes.  Such a handler should end by specifying the default action
## for the signal that happened and then reraising it; this will cause the
## program to terminate with that signal, as if it had not had a handler.
## (See Handlers That Terminate the Process.)
##
## The (obvious) default action for all of these signals is to cause the process
## to terminate.
##
## Macro: int SIGTERM
##
##   The SIGTERM signal is a generic signal used to cause program termination.
##   Unlike SIGKILL, this signal can be blocked, handled, and ignored.  It is
##   the normal way to politely ask a program to terminate.
##
##   The shell command kill generates SIGTERM by default.
##
## Macro: int SIGINT
##
##   The SIGINT ("program interrupt") signal is sent when the user types the
##   INTR character (normally C-c).  See Special Characters, for information
##   about terminal driver support for C-c.
##
## Macro: int SIGQUIT
##
##   The SIGQUIT signal is similar to SIGINT, except that it's controlled by a
##   different key-the QUIT character, usually C-\-and produces a core dump when
##   it terminates the process, just like a program error signal.  You can think
##   of this as a program error condition "detected" by the user.
##
##   See Program Error Signals, for information about core dumps.  See Special
##   Characters, for information about terminal driver support.
##
##   Certain kinds of cleanups are best omitted in handling SIGQUIT.  For
##   example, if the program creates temporary files, it should handle the other
##   termination requests by deleting the temporary files.  But it is better for
##   SIGQUIT not to delete them, so that the user can examine them in
##   conjunction with the core dump.
##
## Macro: int SIGKILL
##
##   The SIGKILL signal is used to cause immediate program termination.  It
##   cannot be handled or ignored, and is therefore always fatal.  It is also
##   not possible to block this signal.
##
##   This signal is usually generated only by explicit request.  Since it cannot
##   be handled, you should generate it only as a last resort, after first
##   trying a less drastic method such as C-c or SIGTERM.  If a process does not
##   respond to any other termination signals, sending it a SIGKILL signal will
##   almost always cause it to go away.
##
##   In fact, if SIGKILL fails to terminate a process, that by itself
##   constitutes an operating system bug which you should report.
##
##   The system will generate SIGKILL for a process itself under some unusual
##   conditions where the program cannot possibly continue to run (even to run
##   a signal handler).
##
## Macro: int SIGHUP
##
##   The SIGHUP ("hang-up") signal is used to report that the user's terminal is
##   disconnected, perhaps because a network or telephone connection was broken.
##   For more information about this, see Control Modes.
##
##   This signal is also used to report the termination of the controlling
##   process on a terminal to jobs associated with that session; this
##   termination effectively disconnects all processes in the session from the
##   controlling terminal.  For more information, see Termination Internals.
##
## ============================================================================}

## @comment{====================================================================
##
## remote: website:
## 24.2.5 Job Control Signals
## <https://www.gnu.org/ software/libc/manual/html_mono/libc.html#Job-Control
## -Signals>
## -----------------------------------------------------------------------------
##
## online resource website:
## -----------------------------------------------------------------------------
##
## 24.2.5 Job Control Signals
##
## These signals are used to support job control.  If your system doesn't
## support job control, then these macros are defined but the signals themselves
## can't be raised or handled.
##
## You should generally leave these signals alone unless you really understand
## how job control works.  See Job Control.
##
## Macro: int SIGCHLD
##
##   This signal is sent to a parent process whenever one of its child processes
##   terminates or stops.
##
##   The default action for this signal is to ignore it.  If you establish a
##   handler for this signal while there are child processes that have
##   terminated but not reported their status via wait or waitpid (see Process
##   Completion), whether your new handler applies to those processes or not
##   depends on the particular operating system.
##
## Macro: int SIGCLD
##
##   This is an obsolete name for SIGCHLD.
##
## Macro: int SIGCONT
##
##   You can send a SIGCONT signal to a process to make it continue.  This
##   signal is special-it always makes the process continue if it is stopped,
##   before the signal is delivered.  The default behavior is to do nothing
##   else.  You cannot block this signal.  You can set a handler, but SIGCONT
##   always makes the process continue regardless.
##
##   Most programs have no reason to handle SIGCONT; they simply resume
##   execution without realizing they were ever stopped.  You can use a handler
##   for SIGCONT to make a program do something special when it is stopped and
##   continued-for example, to reprint a prompt when it is suspended while
##   waiting for input.
##
## Macro: int SIGSTOP
##
##   The SIGSTOP signal stops the process.  It cannot be handled, ignored, or
##   blocked.
##
## Macro: int SIGTSTP
##
##   The SIGTSTP signal is an interactive stop signal.  Unlike SIGSTOP, this
##   signal can be handled and ignored.
##
##   Your program should handle this signal if you have a special need to leave
##   files or system tables in a secure state when a process is stopped.  For
##   example, programs that turn off echoing should handle SIGTSTP so they can
##   turn echoing back on before stopping.
##
##   This signal is generated when the user types the SUSP character (normally
##   C-z).  For more information about terminal driver support, see Special
##   Characters.
##
## Macro: int SIGTTIN
##
##   A process cannot read from the user's terminal while it is running as a
##   background job.  When any process in a background job tries to read from
##   the terminal, all of the processes in the job are sent a SIGTTIN signal.
##   The default action for this signal is to stop the process.  For more
##   information about how this interacts with the terminal driver, see Access
##   to the Controlling Terminal.
##
## Macro: int SIGTTOU
##
##   This is similar to SIGTTIN, but is generated when a process in a background
##   job attempts to write to the terminal or set its modes.  Again, the default
##   action is to stop the process.  SIGTTOU is only generated for an attempt to
##   write to the terminal if the TOSTOP output mode is set; see Output Modes.
##
## While a process is stopped, no more signals can be delivered to it until it
## is continued, except SIGKILL signals and (obviously) SIGCONT signals.  The
## signals are marked as pending, but not delivered until the process is
## continued.  The SIGKILL signal always causes termination of the process and
## can't be blocked, handled or ignored.  You can ignore SIGCONT, but it always
## causes the process to be continued anyway if it is stopped.  Sending a
## SIGCONT signal to a process causes any pending stop signals for that process
## to be discarded.  Likewise, any pending SIGCONT signals for a process are
## discarded when it receives a stop signal.
##
## When a process in an orphaned process group (see Orphaned Process Groups)
## receives a SIGTSTP, SIGTTIN, or SIGTTOU signal and does not handle it, the
## process does not stop.  Stopping the process would probably not be very
## useful, since there is no shell program that will notice it stop and allow
## the user to continue it.  What happens instead depends on the operating
## system you are using.  Some systems may do nothing; others may deliver
## another signal instead, such as SIGKILL or SIGHUP.  On GNU/Hurd systems, the
## process dies with SIGKILL; this avoids the problem of many stopped,
## orphaned processes lying around the system.
##
## ============================================================================}

## @comment{====================================================================
##
## remote: wiki:
## POSIX signals
## <https://en.wikipedia.org/wiki/Signal_(IPC)#POSIX_signals>
## -----------------------------------------------------------------------------
##
## POSIX signals
##
## The list below documents the signals specified in the Single Unix
## Specification.  All signals are defined as macro constants in the <signal.h>
## header file.  The name of the macro constant consists of a "SIG" prefix
## followed by a mnemonic name for the signal.
##
## SIGABRT and SIGIOT
##
##   "Signal abort", "signal input/output trap"
##
##   The SIGABRT signal is sent to a process to tell it to abort, i.e. to
##   terminate.  The signal is usually initiated by the process itself when it
##   calls abort() function of the C Standard Library, but it can be sent to the
##   process from outside like any other signal.
##
##   SIGIOT indicates that the CPU has executed an explicit "trap" instruction
##   (without a defined function), or an unimplemented instruction (when
##   emulation is unavailable).
##
##   Note: "input/output trap" is a misnomer for any CPU "trap" instruction.
##   The term reflects early usage of such instructions, predominantly to
##   implement I/O functions, but they are not inherently tied to device I/O and
##   may be used for other purposes such as communication between virtual & real
##   hosts.
##
##   SIGIOT and SIGABRT are typically the same signal, and receipt of that
##   signal may indicate any of the conditions above.
##
## SIGALRM, SIGVTALRM and SIGPROF
##
##   "Signal alarm", "signal virtual timer alarm", "signal profiling timer
##   alarm"
##
##   The SIGALRM, SIGVTALRM and SIGPROF signals are sent to a process when the
##   corresponding time limit is reached.  The process sets these time limits
##   by calling alarm or setitimer.  The time limit for SIGALRM is based on real
##   or clock time; SIGVTALRM is based on CPU time used by the process; and
##   SIGPROF is based on CPU time used by the process and by the system on its
##   behalf (known as a profiling timer).  On some systems SIGALRM may be used
##   internally by the implementation of the sleep function.
##
## SIGBUS
##
##   "Signal bus"
##
##   The SIGBUS signal is sent to a process when it causes a bus error.  The
##   conditions that lead to the signal being sent are, for example, incorrect
##   memory access alignment or non-existent physical address.
##
## SIGCHLD
##
##   "Signal child"
##
##   The SIGCHLD signal is sent to a process when a child process terminates, is
##   stopped, or resumes after being stopped.  One common usage of the signal is
##   to instruct the operating system to clean up the resources used by a child
##   process after its termination without an explicit call to the wait system
##   call.
##
## SIGCONT
##
##   "Signal continue"
##
##   The SIGCONT signal instructs the operating system to continue (restart) a
##   process previously paused by the SIGSTOP or SIGTSTP signal.  One important
##   use of this signal is in job control in the Unix shell.
##
## SIGFPE
##
##   "Signal floating-point error"
##
##   The SIGFPE signal is sent to a process when an exceptional (but not
##   necessarily erroneous) condition has been detected in the floating point or
##   integer arithmetic hardware.  This may include division by zero, floating
##   point underflow or overflow, integer overflow, an invalid operation or an
##   inexact computation.  Behaviour may differ depending on hardware.
##
## SIGHUP
##
##   "Signal hangup"
##
##   The SIGHUP signal is sent to a process when its controlling terminal is
##   closed.  It was originally designed to notify the process of a serial line
##   drop (a hangup).  In modern systems, this signal usually means that the
##   controlling pseudo or virtual terminal has been closed.[10]  Many daemons
##   (who have no controlling terminal) interpret receipt of this signal as a
##   request to reload their configuration files and flush/reopen their logfiles
##   instead of exiting.[11]  nohup is a command to make a command ignore the
##   signal.
##
## SIGILL
##
##   "Signal illegal"
##
##   The SIGILL signal is sent to a process when it attempts to execute an
##   illegal, malformed, unknown, or privileged instruction.
##
## SIGINT
##
##   "Signal interrupt"
##
##   The SIGINT signal is sent to a process by its controlling terminal when a
##   user wishes to interrupt the process.  This is typically initiated by
##   pressing Ctrl+C, but on some systems, the "delete" character or "break"
##   key can be used.[12]
##
## SIGKILL
##
##   "Signal kill"
##
##   The SIGKILL signal is sent to a process to cause it to terminate
##   immediately (kill).  In contrast to SIGTERM and SIGINT, this signal cannot
##   be caught or ignored, and the receiving process cannot perform any clean-up
##   upon receiving this signal.  The following exceptions apply:
##
##   * Zombie processes cannot be killed since they are already dead and waiting
##     for their parent processes to reap them.
##
##   * Processes that are in the blocked state will not die until they wake up
##     again.
##
##   * The init process is special: It does not get signals that it does not
##     want to handle, and thus it can ignore SIGKILL.[13]  An exception from
##     this rule is while init is ptraced on Linux.[14][15]
##
##   * An uninterruptibly sleeping process may not terminate (and free its
##     resources) even when sent SIGKILL.  This is one of the few cases in which
##     a UNIX system may have to be rebooted to solve a temporary software
##     problem.
##
##   SIGKILL is used as a last resort when terminating processes in most system
##   shutdown procedures if it does not voluntarily exit in response to SIGTERM.
##   To speed the computer shutdown procedure, Mac OS X 10.6, aka Snow Leopard,
##   will send SIGKILL to applications that have marked themselves "clean"
##   resulting in faster shutdown times with, presumably, no ill effects.[16]
##   The command killall -9 has a similar, while dangerous effect, when executed
##   e.g. in Linux; it does not let programs save unsaved data.  It has other
##   options, and with none, uses the safer SIGTERM signal.
##
## SIGPIPE
##
##   "Signal pipe"
##
##   The SIGPIPE signal is sent to a process when it attempts to write to a pipe
##   without a process connected to the other end.
##
## SIGPOLL
##
##   "Signal poll"
##
##   The SIGPOLL signal is sent when an event occurred on an explicitly watched
##   file descriptor.[17]  Using it effectively leads to making asynchronous I/O
##   requests since the kernel will poll the descriptor in place of the caller.
##   It provides an alternative to active polling.
##
## SIGRTMIN to SIGRTMAX
##
##   "Signal real-time minimum", "signal real-time maximum"
##
##   The SIGRTMIN to SIGRTMAX signals are intended to be used for user-defined
##   purposes.  They are real-time signals.
##
## SIGQUIT
##
##   "Signal quit"
##
##   The SIGQUIT signal is sent to a process by its controlling terminal when
##   the user requests that the process quit and perform a core dump.
##
## SIGSEGV
##
##   "Signal segmentation violation"
##
##   The SIGSEGV signal is sent to a process when it makes an invalid virtual
##   memory reference, or segmentation fault, i.e. when it performs a
##   segmentation violation.[18]
##
## SIGSTOP
##
##   "Signal stop"
##
##   The SIGSTOP signal instructs the operating system to stop a process for
##   later resumption.
##
## SIGSYS
##
##   "Signal system call"
##
##   The SIGSYS signal is sent to a process when it passes a bad argument to a
##   system call.  In practice, this kind of signal is rarely encountered since
##   applications rely on libraries (e.g. libc) to make the call for them.
##   SIGSYS can be received by applications violating the Linux Seccomp security
##   rules configured to restrict them.  SIGSYS can also be used to emulate
##   foreign system calls, e.g. emulate Windows system calls on Linux.[19]
##
## SIGTERM
##
##   "Signal terminate"
##
##   The SIGTERM signal is sent to a process to request its termination.  Unlike
##   the SIGKILL signal, it can be caught and interpreted or ignored by the
##   process.  This allows the process to perform nice termination releasing
##   resources and saving state if appropriate.  SIGINT is nearly identical to
##   SIGTERM.
##
## SIGTSTP
##
##   "Signal terminal stop"
##
##   The SIGTSTP signal is sent to a process by its controlling terminal to
##   request it to stop (terminal stop).  It is commonly initiated by the user
##   pressing Ctrl+Z.  Unlike SIGSTOP, the process can register a signal handler
##   for, or ignore, the signal.
##
## SIGTTIN and SIGTTOU
##
##   The SIGTTIN and SIGTTOU signals are sent to a process when it attempts to
##   read in or write out respectively from the tty while in the background.
##   Typically, these signals are received only by processes under job control;
##   daemons do not have controlling terminals and, therefore, should never
##   receive these signals.
##
## SIGTRAP
##
##   "Signal trap"
##
##   The SIGTRAP signal is sent to a process when an exception (or trap)
##   occurs: a condition that a debugger has requested to be informed of - for
##   example, when a particular function is executed, or when a particular
##   variable changes value.
##
## SIGURG
##
##   "Signal urgent"
##
##   The SIGURG signal is sent to a process when a socket has urgent or
##   out-of-band data available to read.
##
## SIGUSR1 and SIGUSR2
##
##   "Signal user 1", "signal user 2"
##
##   The SIGUSR1 and SIGUSR2 signals are sent to a process to indicate
##   user-defined conditions.
##
## SIGXCPU
##
##   "Signal exceeded CPU"
##
##   The SIGXCPU signal is sent to a process when it has used up the CPU for a
##   duration that exceeds a certain predetermined user-settable value.[20]  The
##   arrival of a SIGXCPU signal provides the receiving process a chance to
##   quickly save any intermediate results and to exit gracefully, before it is
##   terminated by the operating system using the SIGKILL signal.
##
## SIGXFSZ
##
##   "Signal excess file size"
##
##   The SIGXFSZ signal is sent to a process when it grows a file that exceeds
##   the maximum allowed size.
##
## SIGWINCH
##
##   "Signal window change"
##
##   The SIGWINCH signal is sent to a process when its controlling terminal
##   changes its size (a window change).[21]
##
## ============================================================================}

## @comment{====================================================================
##
## remote: wiki:
## Default action
## <https://en.wikipedia.org/wiki/Signal_(IPC)#Default_action>
## -----------------------------------------------------------------------------
##
## Default action
##
## A process can define how to handle incoming POSIX signals.  If a process does
## not define a behaviour for a signal, then the default handler for that signal
## is being used.  The table below lists some default actions for
## POSIX-compliant UNIX systems, such as FreeBSD, OpenBSD and Linux.
##
## Signal      Portable   Default action          Description
##             number
##
## SIGABRT      6         Terminate (core dump)   Process abort signal
## SIGALRM     14         Terminate               Alarm clock
## SIGBUS       -         Terminate (core dump)   Access to an undefined portion
##                                                of a memory object
## SIGCHLD      -         Ignore                  Child process terminated,
##                                                stopped, or continued
## SIGCONT      -         Continue                Continue executing, if stopped
## SIGFPE       8         Terminate (core dump)   Erroneous arithmetic operation
## SIGHUP       1         Terminate               Hangup
## SIGILL       4         Terminate (core dump)   Illegal instruction
## SIGINT       2         Terminate               Terminal interrupt signal
## SIGKILL      9         Terminate               Kill (cannot be caught or
##                                                ignored)
## SIGPIPE     13         Terminate               Write on a pipe with no one to
##                                                read it
## SIGPOLL      -         Terminate               Pollable event
## SIGPROF      -         Terminate               Profiling timer expired
## SIGQUIT      3         Terminate (core dump)   Terminal quit signal
## SIGSEGV     11         Terminate (core dump)   Invalid memory reference
## SIGSTOP      -         Stop                    Stop executing (cannot be
##                                                caught or ignored)
## SIGSYS       -         Terminate (core dump)   Bad system call
## SIGTERM     15         Terminate               Termination signal
## SIGTRAP      5         Terminate (core dump)   Trace/breakpoint trap
## SIGTSTP      -         Stop                    Terminal stop signal
## SIGTTIN      -         Stop                    Background process attempting
##                                                read
## SIGTTOU      -         Stop                    Background process attempting
##                                                write
## SIGUSR1      -         Terminate               User-defined signal 1
## SIGUSR2      -         Terminate               User-defined signal 2
## SIGURG       -         Ignore                  Out-of-band data is available
##                                                at a socket
## SIGVTALRM    -         Terminate               Virtual timer expired
## SIGXCPU      -         Terminate (core dump)   CPU time limit exceeded
## SIGXFSZ      -         Terminate (core dump)   File size limit exceeded
## SIGWINCH     -         Ignore                  Terminal window size changed
##
## Portable number:
##
##   For most signals the corresponding signal number is implementation-defined.
##   This column lists the numbers specified in the POSIX standard.[22]
##
## Actions explained:
##
##   Terminate - Abnormal termination of the process.  The process is terminated
##   with all the consequences of _exit() except that the status made available
##   to wait() and waitpid() indicates abnormal termination by the specified
##   signal.
##
##   Terminate (core dump) - Abnormal termination of the process.  Additionally,
##   implementation-defined abnormal termination actions, such as creation of a
##   core file, may occur.
##
##   Ignore - Ignore the signal.
##
##   Stop - Stop (or suspend) the process.
##
##   Continue - Continue the process, if it is stopped; otherwise, ignore the
##   signal.
##
## ============================================================================}

## @comment{====================================================================
##
## remote: wiki:
## Miscellaneous signals
## <https://en.wikipedia.org/wiki/Signal_(IPC)#Miscellaneous_signals>
## -----------------------------------------------------------------------------
##
## Miscellaneous signals
##
## The following signals are not specified in the POSIX specification.  They
## are, however, sometimes used on various systems.
##
## SIGEMT
##
##   The SIGEMT signal is sent to a process when an emulator trap occurs.
##
## SIGINFO
##
##   The SIGINFO signal is sent to a process when a status (info) request is
##   received from the controlling terminal.
##
## SIGPWR
##
##   The SIGPWR signal is sent to a process when the system experiences a power
##   failure.
##
## SIGLOST
##
##   The SIGLOST signal is sent to a process when a file lock is lost.
##
## SIGSTKFLT
##
##   The SIGSTKFLT signal is sent to a process when the coprocessor experiences
##   a stack fault (i.e. popping when the stack is empty or pushing when it is
##   full).[23]  It is defined by, but not used on Linux, where a x87
##   coprocessor stack fault will generate SIGFPE instead.[24]
##
## SIGUNUSED
##
##   The SIGUNUSED signal is sent to a process when a system call with an unused
##   system call number is made.  It is synonymous with SIGSYS on most
##   architectures.[23]
##
## SIGCLD
##
##   The SIGCLD signal is synonymous with SIGCHLD.[23]
##
## ============================================================================}

## @comment{====================================================================
##
## remote: forum:
## <https://???>
## -----------------------------------------------------------------------------
##
## n/a
##
## ============================================================================}

## @comment{====================================================================
##
## remote: mailing list:
## <https://???>
## -----------------------------------------------------------------------------
##
## n/a
##
## ============================================================================}

## @comment{====================================================================
##
## remote: repository:
## <https://???>
## -----------------------------------------------------------------------------
##
## n/a
##
## ============================================================================}

## @comment{====================================================================
##
## remote: archive:
## <https://???>
## -----------------------------------------------------------------------------
##
## n/a
##
## ============================================================================}



## @comment{
## Trap signals and other events.
##
## Signals that are used to tell a process to terminate (from glibc):
##
##   SIGTERM
##   SIGINT    CTRL-C
##   SIGQUIT   CTRL-\
##   SIGKILL
##   SIGHUP
##
## Signals that are used to support job control (from glibc):
##
##   SIGCHLD
##   SIGCLD
##   SIGCONT
##   SIGSTOP
##   SIGTSTP   CTRL-Z
##   SIGTTIN
##   SIGTTOU
##
## Events useful for debugging:
##
##   EXIT
##   DEBUG
##   RETURN
##   ERR
## }

## @comment{
## Signals that are used to tell a process to terminate:
## }

## @fn trapSIGTERM()
## @brief Trap function for the SIGTERM signal.
## @details   The SIGTERM signal is a generic signal used to cause program
## termination.  Unlike SIGKILL, this signal can be blocked, handled, and
## ignored.  It is the normal way to politely ask a program to terminate.<br />
## <br />The shell command kill generates SIGTERM by default.
## @param[in,out] void
## @return void<br />return value: none<br />return code: The return code of the
## last executed command.

function trapSIGTERM() {
  local -r -i lineno="${1}";
  echo 'SIGTERM: This function is not yet implemented.';
  return;
}

_DEBUG_TRAP trap 'trapSIGTERM "${LINENO}"' SIGTERM;

## @fn trapSIGINT()
## @brief Trap function for the SIGINT signal (CTRL-C).
## @details The SIGINT ("program interrupt") signal is sent when the user types
## the INTR character (normally C-c).  See Special Characters, for information
## about terminal driver support for C-c.
## @param[in,out] void
## @return void<br />return value: none<br />return code: The return code of the
## last executed command.

function trapSIGINT() {
  local -r -i lineno="${1}";
  echo 'SIGINT: This function is not yet implemented.';
  return;
}

_DEBUG_TRAP trap 'trapSIGINT "LINENO"' SIGINT;

## @fn trapSIGQUIT()
## @brief Trap function for the SIGQUIT signal (CTRL-\\).
## @details   The SIGQUIT signal is similar to SIGINT, except that it's
## controlled by a different key-the QUIT character, usually C-\\-and produces a
## core dump when it terminates the process, just like a program error signal.
## You can think of this as a program error condition "detected" by the user.
## <br /><br />See Program Error Signals, for information about core dumps.  See
## Special Characters, for information about terminal driver support.<br />
## <br />Certain kinds of cleanups are best omitted in handling SIGQUIT.  For
## example, if the program creates temporary files, it should handle the other
## termination requests by deleting the temporary files.  But it is better for
## SIGQUIT not to delete them, so that the user can examine them in conjunction
## with the core dump.
## @param[in,out] void
## @return void<br />return value: none<br />return code: The return code of the
## last executed command.

function trapSIGQUIT() {
  local -r -i lineno="${1}";
  echo 'SIGQUIT: This function is not yet implemented.';
  return;
}

_DEBUG_TRAP trap 'trapSIGQUIT "${LINENO}"' SIGQUIT;

## @fn trapSIGKILL()
## @brief Trap function for the SIGKILL signal.
## @details The SIGKILL signal is used to cause immediate program termination.
## It cannot be handled or ignored, and is therefore always fatal.  It is also
## not possible to block this signal.<br /><br />This signal is usually
## generated only by explicit request.  Since it cannot be handled, you should
## generate it only as a last resort, after first trying a less drastic method
## such as C-c or SIGTERM.  If a process does not respond to any other
## termination signals, sending it a SIGKILL signal will almost always cause it
## to go away.<br /><br />In fact, if SIGKILL fails to terminate a process,
## that by itself constitutes an operating system bug which you should
## report.<br /><br />The system will generate SIGKILL for a process itself
## under some unusual conditions where the program cannot possibly continue to
## run (even to run a signal handler).
## @param[in,out] void
## @return void<br />return value: none<br />return code: The return code of the
## last executed command.

function trapSIGKILL() {
  local -r -i lineno="${1}";
  echo 'SIGKILL: This function is not yet implemented.';
  return;
}

_DEBUG_TRAP trap 'trapSIGKILL "${LINENO}"' SIGKILL;

## @fn trapSIGHUP()
## @brief Trap function for the SIGHUP signal.
## @details The SIGHUP ("hang-up") signal is used to report that the user's
## terminal is disconnected, perhaps because a network or telephone connection
## was broken.   For more information about this, see Control Modes.<br /><br />
## This signal is also used to report the termination of the controlling process
## on a terminal to jobs associated with that session; this termination
## effectively disconnects all processes in the session from the controlling
## terminal.  For more information, see Termination Internals.
## @param[in,out] void
## @return void<br />return value: none<br />return code: The return code of the
## last executed command.

function trapSIGHUP() {
  local -r -i lineno="${1}";
  echo 'SIGHUP: This function is not yet implemented.';
  return;
}

_DEBUG_TRAP trap 'trapSIGHUP "${LINENO}"' SIGHUP;

## @comment{
## Signals that are used to support job control:
## }

## @fn trapSIGCHLD()
## @brief Trap function for the SIGCHLD signal.
## @details This signal is sent to a parent process whenever one of its child
## processes terminates or stops.<br /><br />The default action for this signal
## is to ignore it.  If you establish a handler for this signal while there are
## child processes that have terminated but not reported their status via wait
## or waitpid (see Process Completion), whether your new handler applies to
## those processes or not depends on the particular operating system.
## @param[in,out] void
## @return void<br />return value: none<br />return code: The return code of the
## last executed command.

function trapSIGCHLD() {
  local -r -i lineno="${1}";
  echo 'SIGCHLD: This function is not yet implemented.';
  return;
}

_DEBUG_TRAP trap 'trapSIGCHLD "${LINENO}"' SIGCHLD;

## @comment{
## SIGCLD is an invalid signal specification.  This is ceept here as a comment.

## @fn trapSIGCLD()
## @brief Trap function for the SIGCLD signal.
## @details This is an obsolete name for SIGCHLD.
## @param[in,out] void
## @return void<br />return value: none<br />return code: The return code of the
## last executed command.

#function trapSIGCLD() {
#  local -r -i lineno="${1}";
#  echo 'SIGCLD: This function is not yet implemented.';
#  return;
#}

#_DEBUG_TRAP trap 'trapSIGCLD "${LINENO}"' SIGCLD;
## }

## @fn trapSIGCONT()
## @brief Trap function for the SIGCONT signal.
## @details You can send a SIGCONT signal to a process to make it continue. This
## signal is special-it always makes the process continue if it is stopped,
## before the signal is delivered.  The default behavior is to do nothing
## else.  You cannot block this signal.  You can set a handler, but SIGCONT
## always makes the process continue regardless.<br /><br />Most programs have
## no reason to handle SIGCONT; they simply resume execution without realizing
## they were ever stopped.  You can use a handler for SIGCONT to make a program
## do something special when it is stopped and continued-for example, to reprint
## a prompt when it is suspended while waiting for input.
## @param[in,out] void
## @return void<br />return value: none<br />return code: The return code of the
## last executed command.

function trapSIGCONT() {
  local -r -i lineno="${1}";
  echo 'SIGCONT: This function is not yet implemented.';
  return;
}

_DEBUG_TRAP trap 'trapSIGCONT "${LINENO}"' SIGCONT;

## @fn trapSIGSTOP()
## @brief Trap function for the SIGCONT signal.
## @details The SIGSTOP signal stops the process.  It cannot be handled,
## ignored, or blocked.
## @param[in,out] void
## @return void<br />return value: none<br />return code: The return code of the
## last executed command.

function trapSIGSTOP() {
  local -r -i lineno="${1}";
  echo 'SIGSTOP: This function is not yet implemented.';
  return;
}

_DEBUG_TRAP trap 'trapSIGSTOP "${LINENO}"' SIGSTOP;

## @fn trapSIGTSTP()
## @brief Trap function for the SIGTSTP signal (CTRL-Z).
## @details The SIGTSTP signal is an interactive stop signal.  Unlike SIGSTOP,
## this signal can be handled and ignored.<br /><br />Your program should handle
## this signal if you have a special need to leave files or system tables in a
## secure state when a process is stopped.  For example, programs that turn off
## echoing should handle SIGTSTP so they can turn echoing back on before
## stopping.<br /><br />This signal is generated when the user types the SUSP
## character (normally C-z).  For more information about terminal driver
## support, see Special Characters.
## @param[in,out] void
## @return void<br />return value: none<br />return code: The return code of the
## last executed command.

function trapSIGTSTP() {
  local -r -i lineno="${1}";
  echo 'SIGTSTP: This function is not yet implemented.';
  return;
}

_DEBUG_TRAP trap 'trapSIGTSTP "${LINENO}"' SIGTSTP;

## @fn trapSIGTTIN()
## @brief Trap function for the SIGTTIN signal.
## @details A process cannot read from the user's terminal while it is running
## as a background job.  When any process in a background job tries to read from
## the terminal, all of the processes in the job are sent a SIGTTIN signal. The
## default action for this signal is to stop the process.  For more information
## about how this interacts with the terminal driver, see Access to the
## Controlling Terminal.
## @param[in,out] void
## @return void<br />return value: none<br />return code: The return code of the
## last executed command.

function trapSIGTTIN() {
  local -r -i lineno="${1}";
  echo 'SIGTTIN: This function is not yet implemented.';
  return;
}

_DEBUG_TRAP trap 'trapSIGTTIN "${LINENO}"' SIGTTIN;

## @fn trapSIGTTOU()
## @brief Trap function for the SIGTTOU signal.
## @details This is similar to SIGTTIN, but is generated when a process in a
## background job attempts to write to the terminal or set its modes.  Again,
## the default action is to stop the process.  SIGTTOU is only generated for an
## attempt to write to the terminal if the TOSTOP output mode is set; see Output
## Modes.
## @param[in,out] void
## @return void<br />return value: none<br />return code: The return code of the
## last executed command.

function trapSIGTTOU() {
  local -r -i lineno="${1}";
  echo 'SIGTTOU: This function is not yet implemented.';
  return;
}

_DEBUG_TRAP trap 'trapSIGTTOU "${LINENO}"' SIGTTOU;

## @comment{
## Events useful for debugging:
## }

## @fn trapEXIT()
## @brief Trap function for the EXIT event.
## @details If a SIGNAL_SPEC is EXIT (0) ARG is executed on exit from the shell.
## @param[in,out] void
## @return void<br />return value: none<br />return code: The return code of the
## last executed command.

function trapEXIT() {
  local -r -i lineno="${1}";
  echo 'trapEXIT: This function is not yet implemented.';
  return;
}

_DEBUG_TRAP trap 'trapEXIT "${LINENO}"' EXIT;

## @fn trapDEBUG()
## @brief Trap function for the DEBUG event.
## @details If a SIGNAL_SPEC is DEBUG, ARG is executed before every simple
## command.
## @param[in,out] void
## @return void<br />return value: none<br />return code: The return code of the
## last executed command.

function trapDEBUG() {
  local -r -i lineno="${1}";
  echo 'trapDEBUG: This function is not yet implemented.';
  return;
}

_DEBUG_TRAP trap 'trapDEBUG "${LINENO}"' DEBUG;

## @fn trapRETURN()
## @brief Trap function for the RETURN event.
## @details If a SIGNAL_SPEC is RETURN, ARG is executed each time a shell
## function or a script run by the . or source builtins finishes executing.
## @param[in,out] void
## @return void<br />return value: none<br />return code: The return code of the
## last executed command.

function trapRETURN (){
  local -r -i lineno="${1}";
  echo 'trapRETURN: This function is not yet implemented.';
  return;
}

_DEBUG_TRAP trap 'trapRETURN "${LINENO}"' RETURN;

## @fn trapERR()
## @brief Trap function for the ERR event.
## @details A SIGNAL_SPEC of ERR means to execute ARG each time a command's
## failure would cause the shell to exit when the -e option is enabled.
## @param[in,out] void
## @return void<br />return value: none<br />return code: The return code of the
## last executed command.

function trapERR() {
  local -r -i lineno="${1}";
  echo 'trapERR: This function is not yet implemented.';
  return;
}

_DEBUG_TRAP trap 'trapERR "${LINENO}"' ERR;



## @comment{
## Logging level:
##
## Level   Description
## -----   -----------
##
## ALL     All levels including custom levels.
##
## TRACE   Designates finer-grained informational events than the DEBUG.
##
## DEBUG   Designates fine-grained informational events that are most useful to
##         debug an application.
##
## INFO    Designates informational messages that highlight the progress of the
##         application at coarse-grained level.
##
## WARN    Designates potentially harmful situations.
##
## ERROR   Designates error events that might still allow the application to
##         continue running.
##
## FATAL   Designates very severe error events that will presumably lead the
##         application to abort.
##
## OFF     The highest possible rank and is intended to turn off logging.
## }



## @comment{
## Handle logging
##
## Priority: TRACE < DEBUG < INFO < WARN < ERROR < FATAL
##           1       2       3      4      5       6
##
##           |                                     |
##           |                                     +-- highest
##           |
##           +-- lowest
##
##           ALL   0   enable all
##           OFF   7   disable all
## }

## @var LOG_LEVEL_ALL
## @brief Log level ALL.
## @details Constant to symbolize log level ALL.

declare -r -i LOG_LEVEL_ALL=0;

## @var LOG_LEVEL_TRACE
## @brief Log level TRACE.
## @details Constant to symbolize log level TRACE.

declare -r -i LOG_LEVEL_TRACE=1;

## @var LOG_LEVEL_DEBUG
## @brief Log level DEBUG.
## @details Constant to symbolize log level DEBUG.

declare -r -i LOG_LEVEL_DEBUG=2;

## @var LOG_LEVEL_INFO
## @brief Log level INFO.
## @details Constant to symbolize log level INFO.

declare -r -i LOG_LEVEL_INFO=3;

## @var LOG_LEVEL_WARN
## @brief Log level WARN.
## @details Constant to symbolize log level WARN.

declare -r -i LOG_LEVEL_WARN=4;

## @var LOG_LEVEL_ERROR
## @brief Log level ERROR.
## @details Constant to symbolize log level ERROR.

declare -r -i LOG_LEVEL_ERROR=5;

## @var LOG_LEVEL_FATAL
## @brief Log level FATAL.
## @details Constant to symbolize log level FATAL.

declare -r -i LOG_LEVEL_FATAL=6;

## @var LOG_LEVEL_OFF
## @brief Log level OFF.
## @details Constant to symbolize log level OFF.

declare -r -i LOG_LEVEL_OFF=7;

## @var log_level
## @brief Log level.
## @details The currently selected log level.

declare -i log_level="${LOG_LEVEL_ERROR}";

## @fn setLogLevel()
## @brief Set the current log level.
## @details Set the current log level using one of the log levels:<br /><br />
## TRACE (1, lowest) < DEBUG (2) < INFO (3) < WARN (4) < ERROR (5) < FATAL (6,
## highest)
## @param[in] integer level<br />The current log level.
## @return void<br />return value: none<br />return code: The return code of the
## last executed command.

function setLogLevel() {
  local -r -i level="${1}";
  log_level="${level}";
  return;
}

## @fn getLogLevel()
## @brief Get current log level.
## @details Get the current log level using one of the log levels:<br /><br />
## TRACE (1, lowest) < DEBUG (2) < INFO (3) < WARN (4) < ERROR (5) < FATAL (6,
## highest)
## @param[in] void
## @return integer level<br />return value: The currently selected log level
## <br />return code: The return code of the last executed command.

function getLogLevel() {
  local -r -i level="${log_level}";
  echo "${level}";
  return;
}

## @fn dumpStack()
## @brief Create a stack dump.
## @details Return the context of each successive subroutine call.
## @param[in] void
## @return return value:<br />string stackdump<br />return code:<br />The return code of the last
##   executed command.
##
## @comment{
## reminder:
## local -r -i exit_code="${?}";
## local -r -i line_number="${LINENO}";
## local -r    executed_command="${BASH_COMMAND}";
## }

function dumpStack() {
  local timestamp='';
  local source_file='';
  local source_line='';
  local source_function='';
  local target_file='';
  local target_line='';
  local target_function='';
  local -i count=0;
  local shopt_old='';
  local shopt_new='';
  local -a target=();
  local stack_dump='';

  stack_dump='stack dump:';
  count="${#FUNCNAME[@]}";
  local -i index=0;
  for (( index=0; index<"$(( "${count}" - 1 ))"; index++ )); do

    stack_dump+="\n";
    timestamp="${EPOCHREALTIME}";
    stack_dump+="[${timestamp}]";
    stack_dump+=' ';
    stack_dump+="${index}:";
    stack_dump+=' ';
    source_file="${BASH_SOURCE[$(( "${index}" + 0 ))]}";
    stack_dump+="in file '${source_file}'";
    stack_dump+=' ';
    source_line="${BASH_LINENO[$(( "${index}" + 0 ))]}";
    stack_dump+="in line '${source_line}'";
    stack_dump+=' ';
    source_function="${FUNCNAME[$(( "${index}" + 0 ))]}";
    stack_dump+="the function '${source_function}'";
    stack_dump+=' ';
    stack_dump+='is called';
    stack_dump+=' ';
    stack_dump+='-->';
    stack_dump+=' ';

    shopt_old="$( shopt -p extdebug )";
    shopt_new="shopt -s extdebug";
    eval "${shopt_new}";
    readarray -d ' ' target < <( declare -F "${FUNCNAME[$(( "${index}" + 0 ))]}" );
    eval "${shopt_old}";

    target_function="${target[0]}";
    target_function="${target_function% }";
    stack_dump+="the function '${target_function}' is";
    stack_dump+=' ';
    target_file="${target[2]}";
    target_file="${target_file%$'\n'}";
    stack_dump+="in file '${target_file}'";
    stack_dump+=' ';
    target_line="${target[1]}";
    target_line="${target_line% }";
    stack_dump+="in line '${target_line}'";

  done

  echo -e "${stack_dump}";

  return;
}

## @fn printLog()
## @breif Print log message to STDOUT.
## @details Print log message to STDOUT.
## Example:
## @code
## printLog INFO a message
## @endcode
## @param[in] integer level<br />The log level.
## @param[in] array-of-string message<br />The log message.
## @return string result<br />return value: The log entry<br />return code: The
## return code of the last executed command.

function printLog() {
  local -r -i level="${1}"; shift 1;
  local -r -a message=( "${@}" );
  local -r    timestamp="${EPOCHREALTIME}";
  local -r    format='[%010s] [%- 5s] %s';
  local       result='';
  if   (( "${level}" <= "${LOG_LEVEL_TRACE}" )); then
    printf -v 'result' "${format}" "${timestamp}" 'TRACE' "$( echo "${message[@]}" )";
  elif (( "${level}" <= "${LOG_LEVEL_DEBUG}" )); then
    printf -v 'result' "${format}" "${timestamp}" 'DEBUG' "$( echo "${message[@]}" )";
  elif (( "${level}" <= "${LOG_LEVEL_INFO}" )); then
    printf -v 'result' "${format}" "${timestamp}" 'INFO' "$( echo "${message[@]}" )";
  elif (( "${level}" <= "${LOG_LEVEL_WARN}" )); then
    printf -v 'result' "${format}" "${timestamp}" 'WARN' "$( echo "${message[@]}" )";
  elif (( "${level}" <= "${LOG_LEVEL_ERROR}" )); then
    printf -v 'result' "${format}" "${timestamp}" 'ERROR' "$( echo "${message[@]}" )";
  elif (( "${level}" <= "${LOG_LEVEL_FATAL}" )); then
    printf -v 'result' "${format}" "${timestamp}" 'FATAL' "$( echo "${message[@]}" )";
  else
    :;
  fi
  echo "${result}";
  return;
}

## @fn printLogTRACE
## @brief Print TRACE log message.
## @details Print TRACE log message. Make a stack trace also.
## @param[in] array-of-string message<br />The message.
## @return void<br />return value: none<br />return code: The return code of the
## last executed command.

function printLogTRACE() {
  local -r -a message=( "${@}" );
  printLog "${LOG_LEVEL_TRACE}" "${message[@]}";
  dumpStack;
  return;
}

## @fn printLogDEBUG
## @brief Print DEBUG log message.
## @details Print DEBUG log message.
## @param[in] array-of-string message<br />The message.
## @return void<br />return value: none<br />return code: The return code of the
## last executed command.

function printLogDEBUG {
  local -r -a message=( "${@}" );
  printLog "${LOG_LEVEL_DEBUG}" "${message[@]}";
  return;
}

## @fn printLogINFO
## @brief Print INFO log message.
## @details Print INFO log message.
## @param[in] array-of-string message<br />The message.
## @return void<br />return value: none<br />return code: The return code of the
## last executed command.

function printLogINFO {
  local -r -a message=( "${@}" );
  printLog "${LOG_LEVEL_INFO}" "${message[@]}";
  return;
}

## @fn printLogWARN
## @brief Print WARN log message.
## @details Print WARN log message.
## @param[in] array-of-string message<br />The message.
## @return void<br />return value: none<br />return code: The return code of the
## last executed command.

function printLogWARN {
  local -r -a message=( "${@}" );
  printLog "${LOG_LEVEL_WARN}" "${message[@]}";
  return;
}

## @fn printLogERROR
## @brief Print ERROR log message.
## @details Print ERROR log message.
## @param[in] array-of-string message<br />The message.
## @return void<br />return value: none<br />return code: The return code of the
## last executed command.

function printLogERROR {
  local -r -a message=( "${@}" );
  printLog "${LOG_LEVEL_ERROR}" "${message[@]}";
  return;
}

## @fn printLogFATAL
## @brief Print FATAL log message.
## @details Print FATAL log message.
## @param[in] array-of-string message<br />The message.
## @return void<br />return value: none<br />return code: The return code of the
## last executed command.

function printLogFATAL {
  local -r -a message=( "${@}" );
  printLog "${LOG_LEVEL_FATAL}" "${message[@]}";
  return;
}



## @c{
## Here starts the program.
## }

## @fn main()
## @brief The main function.
## @details The main function (1) reads the configuration file, (2) reads the
##   command line arguments (3) handles the command line arguments and (4)
##   handles the subcommands gittify and gnutify.
## @param[in] integer argc<br />The number of command line arguments passed to
##   the function.
## @param[in] indexed-array-of-string argv<br />The Array containing the command
##   line arguments passed to the function.
## @return return value: void;<br />return code: the return code of the last
##   executed command.

function main() {
  local -r    command="${1}"; shift 1;                                          DEBUG printLogINFO "$( local -p command )";
  local -r -i argc="${1}"; shift 1;                                             DEBUG printLogINFO "$( local -p argc )";
  local -r -a argv=( "${@}" );                                                  DEBUG printLogINFO "$( local -p argv )";

  DEBUG echo 'git-gnu-project running ...';
  DEBUG echo '';

  DEBUG echo '';
  DEBUG echo '... finished git-gnu-project';

  return;
}

# Set the log level

setLogLevel "${LOG_LEVEL_ALL}";

# Call the main function.

main "${0}" "${#}" "${@}";

# Pass the return code of the main function to the console as the exit code.

exit "${?}";
