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
## bash$ set --help
##
## "4.3.1 The Set Builtin" <https://www.gnu.org/software/bash/manual/bash.html#
## The-Set-Builtin>
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
## List of shopt options.
##
## "4.3.2 The Shopt Builtin" <https://www.gnu.org/software/bash/manual/bash.html
## #The-Shopt-Builtin>
##
## assoc_expand_once - If set, the shell suppresses multiple evaluation of
##   associative array subscripts during arithmetic expression evaluation, while
##   executing builtins that can perform variable assignments, and while
##   executing builtins that perform array dereferencing.
##
## autocd - If set, a command name that is the name of a directory is executed
##   as if it were the argument to the cd command. This option is only used by
##   interactive shells.
##
## cdable_vars - If this is set, an argument to the cd builtin command that is
##   not a directory is assumed to be the name of a variable whose value is the
##   directory to change to.
##
## cdspell - If set, minor errors in the spelling of a directory component in a
##   cd command will be corrected.  The errors checked for are transposed
##   characters, a missing character, and a character too many.  If a correction
##   is found, the corrected path is printed, and the command proceeds.  This
##   option is only used by interactive shells.
##
## checkhash - If this is set, Bash checks that a command found in the hash
##   table exists before trying to execute it.  If a hashed command no longer
##   exists, a normal path search is performed.
##
## checkjobs - If set, Bash lists the status of any stopped and running jobs
##   before exiting an interactive shell.  If any jobs are running, this causes
##   the exit to be deferred until a second exit is attempted without an
##   intervening command (see Job Control).  The shell always postpones exiting
##   if any jobs are stopped.
##
## checkwinsize - If set, Bash checks the window size after each external
##   (non-builtin) command and, if necessary, updates the values of LINES and
##   COLUMNS.  This option is enabled by default.
##
## cmdhist - If set, Bash attempts to save all lines of a multiple-line command
##   in the same history entry.  This allows easy re-editing of multi-line
##   commands.  This option is enabled by default, but only has an effect if
##  command history is enabled (see Bash History Facilities).
##
## compat31, compat32, compat40, compat41, compat42, compat43, compat44 - These
##   control aspects of the shell’s compatibility mode (see Shell Compatibility
##   Mode).
##
## complete_fullquote - If set, Bash quotes all shell metacharacters in
##   filenames and directory names when performing completion.  If not set, Bash
##   removes metacharacters such as the dollar sign from the set of characters
##   that will be quoted in completed filenames when these metacharacters appear
##   in shell variable references in words to be completed.  This means that
##   dollar signs in variable names that expand to directories will not be
##   quoted; however, any dollar signs appearing in filenames will not be
##   quoted, either.  This is active only when bash is using backslashes to
##   quote completed filenames.  This variable is set by default, which is the
##   default Bash behavior in versions through 4.2.
##
## direxpand - If set, Bash replaces directory names with the results of word
##   expansion when performing filename completion.  This changes the contents
##   of the Readline editing buffer.  If not set, Bash attempts to preserve what
##   the user typed.
##
## dirspell - If set, Bash attempts spelling correction on directory names
##   during word completion if the directory name initially supplied does not
##   exist.
##
## dotglob - If set, Bash includes filenames beginning with a ‘.’ in the results
##   of filename expansion.  The filenames ‘.’ and ‘..’ must always be matched
##   explicitly, even if dotglob is set.
##
## execfail - If this is set, a non-interactive shell will not exit if it cannot
##   execute the file specified as an argument to the exec builtin command.  An
##   interactive shell does not exit if exec fails.
##
## expand_aliases - If set, aliases are expanded as described below under
##   Aliases, Aliases.  This option is enabled by default for interactive
##   shells.
##
## extdebug - If set at shell invocation, or in a shell startup file, arrange to
##   execute the debugger profile before the shell starts, identical to the
##   --debugger option.  If set after invocation, behavior intended for use by
##   debuggers is enabled:
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
## extglob - If set, the extended pattern matching features described above (see
##   Pattern Matching) are enabled.
##
## extquote - If set, $'string' and $"string" quoting is performed within
##   ${parameter} expansions enclosed in double quotes. T his option is enabled
##   by default.
##
## failglob - If set, patterns which fail to match filenames during filename
## expansion result in an expansion error.
##
## force_fignore - If set, the suffixes specified by the FIGNORE shell variable
##   cause words to be ignored when performing word completion even if the
##   ignored words are the only possible completions.  See Bash Variables, for a
##   description of FIGNORE.  This option is enabled by default.
##
## globasciiranges - If set, range expressions used in pattern matching bracket
##   expressions (see Pattern Matching) behave as if in the traditional C locale
##   when performing comparisons.  That is, the current locale’s collating
##   sequence is not taken into account, so ‘b’ will not collate between ‘A’ and
##   ‘B’, and upper-case and lower-case ASCII characters will collate together.
##
## globskipdots - If set, filename expansion will never match the filenames ‘.’
##   and ‘..’, even if the pattern begins with a ‘.’. This option is enabled by
##  default.
##
## globstar - If set, the pattern ‘**’ used in a filename expansion context will
##   match all files and zero or more directories and subdirectories.  If the
##   pattern is followed by a ‘/’, only directories and subdirectories match.
##
## gnu_errfmt - If set, shell error messages are written in the standard GNU
##   error message format.
##
## histappend - If set, the history list is appended to the file named by the
##   value of the HISTFILE variable when the shell exits, rather than
##   overwriting the file.
##
## histreedit - If set, and Readline is being used, a user is given the 
##   opportunity to re-edit a failed history substitution.
##
## histverify - If set, and Readline is being used, the results of history 
##   substitution are not immediately passed to the shell parser.  Instead, the 
##   resulting line is loaded into the Readline editing buffer, allowing further 
##   modification.
##
## hostcomplete - If set, and Readline is being used, Bash will attempt to 
##   perform hostname completion when a word containing a ‘@’ is being completed 
##  (see Letting Readline Type For You).  This option is enabled by default.
##
## huponexit - If set, Bash will send SIGHUP to all jobs when an interactive 
##   login shell exits (see Signals).
##
## inherit_errexit - If set, command substitution inherits the value of the 
##   errexit option, instead of unsetting it in the subshell environment.  This 
##   option is enabled when POSIX mode is enabled.
##
## interactive_comments - Allow a word beginning with ‘#’ to cause that word and 
##   all remaining characters on that line to be ignored in an interactive 
##   shell.  This option is enabled by default.
##
## lastpipe - If set, and job control is not active, the shell runs the last 
##   command of a pipeline not executed in the background in the current shell 
##   environment.
## 
## lithist - If enabled, and the cmdhist option is enabled, multi-line commands 
##   are saved to the history with embedded newlines rather than using semicolon 
##   separators where possible.
##
## localvar_inherit - If set, local variables inherit the value and attributes 
##   of a variable of the same name that exists at a previous scope before any 
##   new value is assigned.  The nameref attribute is not inherited.
##
## localvar_unset - If set, calling unset on local variables in previous 
##   function scopes marks them so subsequent lookups find them unset until that 
##   function returns.  This is identical to the behavior of unsetting local 
##   variables at the current function scope.
##
## login_shell - The shell sets this option if it is started as a login shell 
##   (see Invoking Bash).  The value may not be changed.
##
## mailwarn - If set, and a file that Bash is checking for mail has been 
##   accessed since the last time it was checked, the message "The mail in 
##   mailfile has been read" is displayed.
##
## no_empty_cmd_completion - If set, and Readline is being used, Bash will not 
##   attempt to search the PATH for possible completions when completion is 
##   attempted on an empty line.
##
## nocaseglob - If set, Bash matches filenames in a case-insensitive fashion 
##   when performing filename expansion.
##
## nocasematch - If set, Bash matches patterns in a case-insensitive fashion 
##   when performing matching while executing case or [[ conditional commands 
##   (see Conditional Constructs, when performing pattern substitution word 
##   expansions, or when filtering possible completions as part of programmable 
##   completion.
##
## noexpand_translation - If set, Bash encloses the translated results of $"..." 
##   quoting in single quotes instead of double quotes. If the string is not 
##   translated, this has no effect.
##
## nullglob - If set, Bash allows filename patterns which match no files to 
##   expand to a null string, rather than themselves.
##
## patsub_replacement - If set, Bash expands occurrences of ‘&’ in the 
##   replacement string of pattern substitution to the text matched by the 
##   pattern, as described above (see Shell Parameter Expansion).  This option 
##   is enabled by default.
##
## progcomp - If set, the programmable completion facilities (see Programmable 
##   Completion) are enabled. This option is enabled by default.
##
## progcomp_alias - If set, and programmable completion is enabled, Bash treats 
##   a command name that doesn’t have any completions as a possible alias and 
##   attempts alias expansion. If it has an alias, Bash attempts programmable 
##   completion using the command word resulting from the expanded alias.
##
## promptvars - If set, prompt strings undergo parameter expansion, command 
##   substitution, arithmetic expansion, and quote removal after being expanded 
##   as described below (see Controlling the Prompt). This option is enabled by 
##   default.
##
## restricted_shell - The shell sets this option if it is started in restricted 
##   mode (see The Restricted Shell).  The value may not be changed. This is not 
##   reset when the startup files are executed, allowing the startup files to 
##   discover whether or not a shell is restricted.
##
## shift_verbose - If this is set, the shift builtin prints an error message 
##   when the shift count exceeds the number of positional parameters.
##
shopt -s shift_verbose;
##
## sourcepath - If set, the . (source) builtin uses the value of PATH to find 
##   the directory containing the file supplied as an argument. This option is 
##   enabled by default.
##
## varredir_close - If set, the shell automatically closes file descriptors 
##   assigned using the {varname} redirection syntax (see Redirections) instead 
##   of leaving them open when the command completes.
##
## xpg_echo - If set, the echo builtin expands backslash-escape sequences by 
##   default.
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
