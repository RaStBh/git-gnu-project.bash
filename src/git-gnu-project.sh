#! /usr/bin/env bash
################################################################################
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
################################################################################



##! @mainpage
##!
##! RaSt git-gnu-project package
##!
##! With the RaSt git-gnu-project you can create a Git repository and a GNU
##! project tree in a local directory.
##!
##! 1.0.0
##!
##! 2023-09-18 14:17:21 +00:00:00
##!
##! Copyright (C)  2023  Ralf Stephan  \<me\@ralf-stephan.name\>



##! @file git-gnu-project.sh
##!
##! @brief The main script of the RaSt git-gnu-project.
##!
##! @details The main script of the RaSt git-gnu-project handling the command
##! git-gnu-project and the subcommands gittify and gnutify.



## Data types for Doxygen @param and @return:
##
##   integer
##   string
##
##   indexed-array-of-integer
##   indexed-array-of-string
##
##   hashed-array-of-integer
##   hashed-array-of-string



## < head <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

## << shell options <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

## Bash Shell Options

## Bash shell options:
##
## (1) bash$ set --help
##
## (2) bash$ set -o
##
## (3) bash$ set +o
##
## (4) bash$ man set
##
## (5) bash$ info set
##
## (6) /usr/local/doc/
##
## (7) /usr/src/
##
## (8) 4.3.1 The Set Builtin
##     <https://www.gnu.org/software/bash/manual/bash.html#The-Set-Builtin>
##
##
##
## from (3):
##
## Bash Shell Options:
## option name                |option character
## ---------------------------+----------------
## set -o allexport           |set -a
## set -o braceexpand         |set -B
## set -o emacs               |
## set -o errexit             |set -e
## set -o errtrace            |set -E
## set -o functrace           |set -T
## set -o hashall             |set -h
## set -o histexpand          |set -H
## set -o history             |
## set -o igncr               |
## set -o ignoreeof           |
## set -o interactive-comments|
## set -o keyword             |set -k
## set -o monitor             |set -m
## set -o noclobber           |set -C
## set -o noexec              |set -n
## set -o noglob              |set -f
## set -o nolog               |
## set -o notify              |set -b
## set -o nounset             |set -u
## set -o onecmd              |set -t
## set -o physical            |set -P
## set -o pipefail            |
## set -o posix               |
## set -o privileged          |set -p
## set -o verbose             |set -v
## set -o vi                  |
## set -o xtrace              |set -x
##
##
##
## from (8):
##
## allexport (-a)
##
##   Each variable or function that is created or modified is given the export
##   attribute and marked for export to the environment of subsequent commands.
##
## braceexpand (-B)
##
##   The shell will perform brace expansion (see Brace Expansion).  This option
##   is on by default.
##
## emacs
##
##   Use an emacs-style line editing interface (see Command Line Editing).  This
##   also affects the editing interface used for read -e.
##
## errexit (-e)
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
## errtrace (-E)
##
##   If set, any trap on ERR is inherited by shell functions, command
##   substitutions, and commands executed in a subshell environment.  The ERR
##   trap is normally not inherited in such cases.
##
## functrace (-T)
##
##   If set, any trap on DEBUG and RETURN are inherited by shell functions,
##   command substitutions, and commands executed in a subshell environment.
##   The DEBUG and RETURN traps are normally not inherited in such cases.
##
## hashall (-h)
##
##   Locate and remember (hash) commands as they are looked up for execution.
##   This option is enabled by default.
##
## histexpand (-H)
##
##   Enable '!' style history substitution (see History Expansion).  This option
##   is on by default for interactive shells.
##
## history
##
##   Enable command history, as described in Bash History Facilities.  This
##   option is on by default in interactive shells.
##
## igncr
##
##   On Cygwin, ignore \r in line endings.
##
## ignoreeof
##
##   An interactive shell will not exit upon reading EOF.
##
## interactive-comments
##
##   Allow comments to appear in interactive commands.
##
## keyword (-k)
##
##   All arguments in the form of assignment statements are placed in the
##   environment for a command, not just those that precede the command name.
##
## monitor (-m)
##
##   Job control is enabled (see Job Control).  All processes run in a separate
##   process group.  When a background job completes, the shell prints a line
##   containing its exit status.
##
## noclobber (-C)
##
##   Prevent output redirection using '>', '>&', and '<>' from overwriting
##   existing files.
##
## noexec (-n)
##
##   Read commands but do not execute them.  This may be used to check a script
##   for syntax errors. This option is ignored by interactive shells.
##
## noglob (-f)
##
##   Disable filename expansion (globbing).
##
## nolog
##
##   Currently ignored.
##
## notify (-b)
##
##   Cause the status of terminated background jobs to be reported immediately,
##   rather than before printing the next primary prompt.
##
## nounset (-u)
##
##   Treat unset variables and parameters other than the special parameters '@'
##   or '*', or array variables subscripted with '@' or '*', as an error when
##   performing parameter expansion.  An error message will be written to the
##   standard error, and a non-interactive shell will exit.
##
## onecmd (-t)
##
##   Exit after reading and executing one command.
##
## physical (-P)
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
## privileged (-p)
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
## verbose (-v)
##
##   Print shell input lines as they are read.
##
## vi
##
##   Use a vi-style line editing interface.  This also affects the editing
##   interface used for read -e.
##
## xtrace (-x)
##
##   Print a trace of simple commands, for commands, case commands, select
##   commands, and arithmetic for commands and their arguments or associated
##   word lists after they are expanded and before they are executed.  The value
##   of the PS4 variable is expanded and the resultant value is printed before
##   the command and its expanded arguments.
##
## ??? (-r)
##
##   Enable restricted shell mode.  This option cannot be unset once it has been
##   set.

## Recommended options to enable for debugging:
##
##   bash> set -E          -e         -u         -x        -o pipefail;
##
##   which is same as
##
##   bash> set -o errtrace -o errexit -o nounset -o xtrace -o pipefail;

#set -o 'verbose';
#set -o 'xtrace';

set -o 'errexit';
set -o 'errtrace';
set -o 'functrace';
set -o 'nounset';
set -o 'pipefail';

## Bash additional shell options:
##
## (1) bash$ shopt --help
##
## (2) bash$ shopt -p
##
## (3) bash$ man shopt
##
## (4) bash$ info shopt
##
## (5) /usr/local/doc/
##
## (6) /usr/src/
##
## (7) 4.3.2 The Shopt Builtin
##     <https://www.gnu.org/software/bash/manual/bash.html#The-Shopt-Builtin>
##
##
##
## from (2):
##
## Bash Additional Shell Options:
## option name                     |option character
## --------------------------------+----------------
## shopt -s autocd                 |
## shopt -s assoc_expand_once      |
## shopt -s cdable_vars            |
## shopt -s cdspell                |
## shopt -s checkhash              |
## shopt -s checkjobs              |
## shopt -s checkwinsize           |
## shopt -s cmdhist                |
## shopt -s compat31               |
## shopt -s compat32               |
## shopt -s compat40               |
## shopt -s compat41               |
## shopt -s compat42               |
## shopt -s compat43               |
## shopt -s compat44               |
## shopt -s completion_strip_exe   |
## shopt -s complete_fullquote     |
## shopt -s direxpand              |
## shopt -s dirspell               |
## shopt -s dotglob                |
## shopt -s execfail               |
## shopt -s expand_aliases         |
## shopt -s extdebug               |
## shopt -s extglob                |
## shopt -s extquote               |
## shopt -s failglob               |
## shopt -s force_fignore          |
## shopt -s globasciiranges        |
## shopt -s globskipdots           |
## shopt -s globstar               |
## shopt -s gnu_errfmt             |
## shopt -s histappend             |
## shopt -s histreedit             |
## shopt -s histverify             |
## shopt -s hostcomplete           |
## shopt -s huponexit              |
## shopt -s inherit_errexit        |
## shopt -s interactive_comments   |
## shopt -s lastpipe               |
## shopt -s lithist                |
## shopt -s localvar_inherit       |
## shopt -s localvar_unset         |
## shopt -s login_shell            |
## shopt -s mailwarn               |
## shopt -s no_empty_cmd_completion|
## shopt -s nocaseglob             |
## shopt -s nocasematch            |
## shopt -s noexpand_translation   |
## shopt -s nullglob               |
## shopt -s patsub_replacement     |
## shopt -s progcomp               |
## shopt -s progcomp_alias         |
## shopt -s promptvars             |
## shopt -s restricted_shell       |
## shopt -s shift_verbose          |
## shopt -s sourcepath             |
## shopt -s varredir_close         |
## shopt -s xpg_echo               |
##
##
##
## from (7):
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

shopt -s 'extdebug';
shopt -s 'shift_verbose';

## >> shell options >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

## << debugging <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

## Simple Way to Handle Debugging

##! @var DEBUG_ON
##! @brief Constant to switch debug on.
##! @details Constant to switch debug on.

declare -r -i DEBUG_ON=0;

##! @var DEBUG_OFF
##! @brief Constant to switch debug off.
##! @details Constant to switch debug off.

declare -r -i DEBUG_OFF=1;

##! @var DEBUG_STATE
##! @brief Constant to switch debug on or off.
##! @details Constant to switch debug on or off.

declare -r -i DEBUG_STATE="${DEBUG_ON}";

##! @fn DEBUG()
##! @brief Run commands for debugging.
##! @details Run debugging commands by chaining multiple commands.
##! @startglobal
##! @itemglobal{in,integer,DEBUG_STATE<br />Constant to switch debug on or
##! off.}
##! @endglobal
##! @param[in] array-of-string tokens<br />The chained tokens.
##! @return string message<br />return value: The result after chaining the
##! tokens together und executing the tokens.<br />return code: The return code
##! of the last executed command.

function DEBUG() {
  local -r -a tokens=( "${@}" );
  local       message="$( printf '%s' 'DEBUG: '; "${tokens[@]}"; )";
  (( "${DEBUG_STATE}" )) || { printf '%s\n' "${message}"; }
  return "${?}";
}

## Traping Signals for Debugging

## Trap signals and conditions.
##
##  (1) bash$ trap --help
##
##  (2) bash$ trap -l
##
##  (3) bash$ man trap
##
##  (4) bash$ info trap
##
##  (5) bash$ kill --help
##
##  (6) bash$ kill -l
##
##  (7) bash$ man kill
##
##  (8)bash$  info kill
##
##  (9) bash$ stty --all
##
## (10) bash$ man stty
##
## (11) bash$ info stty
##
## (12) /usr/local/doc/
##
## (13) /usr/src/
##
## (14) termios, tcgetattr, tcsetattr, tcsendbreak, tcdrain, tcflush, tcflow,
##      cfmakeraw, cfgetospeed, cfgetispeed, cfsetispeed, cfsetospeed,
##      cfsetspeed - get and set terminal attributes, line control, get and set
##      baud rate
##      <https://manpages.debian.org/bookworm/manpages-dev/termios.3.en.html>
##
## (15) signal - ANSI C signal handling
##      <https://manpages.debian.org/bookworm/manpages-dev/signal.2.en.html>
##
## (16) signal - overview of signals
##      <https://manpages.debian.org/bookworm/manpages/signal.7.en.html>
##
## (17) 4.1 Bourne Shell Builtins
##      <https://www.gnu.org/software/bash/manual/bash.html#Bourne-Shell-Builtins>
##
## (18) 17.4.9.2 Characters that Cause Signals
##      <https://www.gnu.org/software/libc/manual/html_mono/libc.html#Signal-Characters>
##
## (19) 24.2.2 Termination Signals
##      <https://www.gnu.org/ software/libc/manual/html_mono/libc.html#Termination-Signals>
##
## (20) 24.2.5 Job Control Signals
##      <https://www.gnu.org/software/libc/manual/html_mono/libc.html#Job-Control-Signals>
##
## (21) POSIX signals
##      <https://en.wikipedia.org/wiki/Signal_(IPC)#POSIX_signals>
##
##
##
## from (2):
## from (6):
##
## Signals:
##
##  1) SIGHUP       2) SIGINT       3) SIGQUIT      4) SIGILL       5) SIGTRAP
##  6) SIGABRT      7) SIGEMT       8) SIGFPE       9) SIGKILL     10) SIGBUS
## 11) SIGSEGV     12) SIGSYS      13) SIGPIPE     14) SIGALRM     15) SIGTERM
## 16) SIGURG      17) SIGSTOP     18) SIGTSTP     19) SIGCONT     20) SIGCHLD
## 21) SIGTTIN     22) SIGTTOU     23) SIGIO       24) SIGXCPU     25) SIGXFSZ
## 26) SIGVTALRM   27) SIGPROF     28) SIGWINCH    29) SIGPWR      30) SIGUSR1
## 31) SIGUSR2     32) SIGRTMIN    33) SIGRTMIN+1  34) SIGRTMIN+2  35) SIGRTMIN+3
## 36) SIGRTMIN+4  37) SIGRTMIN+5  38) SIGRTMIN+6  39) SIGRTMIN+7  40) SIGRTMIN+8
## 41) SIGRTMIN+9  42) SIGRTMIN+10 43) SIGRTMIN+11 44) SIGRTMIN+12 45) SIGRTMIN+13
## 46) SIGRTMIN+14 47) SIGRTMIN+15 48) SIGRTMIN+16 49) SIGRTMAX-15 50) SIGRTMAX-14
## 51) SIGRTMAX-13 52) SIGRTMAX-12 53) SIGRTMAX-11 54) SIGRTMAX-10 55) SIGRTMAX-9
## 56) SIGRTMAX-8  57) SIGRTMAX-7  58) SIGRTMAX-6  59) SIGRTMAX-5  60) SIGRTMAX-4
## 61) SIGRTMAX-3  62) SIGRTMAX-2  63) SIGRTMAX-1  64) SIGRTMAX
##
##
##
## from (1):
##
## Other Conditions:
##
## * If a SIGNAL_SPEC is EXIT (0) ARG is executed on exit from the shell.
##
## * If a SIGNAL_SPEC is DEBUG, ARG is executed before every simple command.
##
## * If a SIGNAL_SPEC is RETURN, ARG is executed each time a shell function or a
##   script run by the . or source builtins finishes executing.
##
## * A SIGNAL_SPEC of ERR means to execute ARG each time a command's failure
##   would cause the shell to exit when the -e option is enabled.
##
##
##
## from (7):
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
##
##
## from (8):
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
##
##
## from (9):
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
##
##
## from (11):
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
##
##
## from (14):
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
## below.
##
##
##
## from (16):
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
##
##
## from (16):
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
##
##
## from (16):
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
##
##
## from (17):
##
## If a sigspec is 0 or EXIT, arg is executed when the shell exits.
##
## If a sigspec is DEBUG, the command arg is executed before every simple
## command, for command, case command, select command, every arithmetic for
## command, and before the first command executes in a shell function.  Refer to
## the description of the extdebug option to the shopt builtin (see The Shopt
## Builtin) for details of its effect on the DEBUG trap.
##
## If a sigspec is RETURN, the command arg is executed each time a shell
## function or a script executed with the . or source builtins finishes
## executing.
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
##
##
## from (18):
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
##
##
## from (19):
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
##
##
## from (20):
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
##
##
## from (21):
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
##
##
## from (21):
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
##
##
## from (20):
##
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
##
##
##
## from (21):
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

##! @fn trapSIGHUP()
##! @brief Trap function for the SIGHUP signal.
##! @details Trap function for the SIGHUP signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGHUP signal.<br />return code: The return code of the last executed
##! command.

function trapSIGHUP() {
  local message='trapSIGHUP: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGHUP;

#trap 'trapSIGHUP' 'SIGHUP';

##! @fn trapSIGINT()
##! @brief Trap function for the SIGINT signal.
##! @details Trap function for the SIGINT signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGINT signal.<br />return code: The return code of the last executed
##! command.
##! @note CTRL+C

function trapSIGINT() {
  local message='trapSIGINT: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGINT;

#trap 'trapSIGINT' 'SIGINT';

##! @fn trapSIGQUIT()
##! @brief Trap function for the SIGQUIT signal.
##! @details Trap function for the SIGQUIT signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGQUIT signal.<br />return code: The return code of the last executed
##! command.
##! @note CTRL-\\

function trapSIGQUIT() {
  local message='trapSIGQUIT: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGQUIT;

#trap 'trapSIGQUIT' 'SIGQUIT';

##! @fn trapSIGILL()
##! @brief Trap function for the SIGILL signal.
##! @details Trap function for the SIGILL signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGILL signal.<br />return code: The return code of the last executed
##! command.

function trapSIGILL() {
  local message='trapSIGILL: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGILL;

#trap 'trapSIGILL' 'SIGILL';

##! @fn trapSIGTRAP()
##! @brief Trap function for the SIGTRAP signal.
##! @details Trap function for the SIGTRAP signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGTRAP signal.<br />return code: The return code of the last executed
##! command.

function trapSIGTRAP() {
  local message='trapSIGTRAP: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGTRAP;

#trap 'trapSIGTRAP' 'SIGTRAP';

##! @fn trapSIGABRT()
##! @brief Trap function for the SIGABRT signal.
##! @details Trap function for the SIGABRT signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGABRT signal.<br />return code: The return code of the last executed
##! command.

function trapSIGABRT() {
  local message='trapSIGABRT: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGABRT;

#trap 'trapSIGABRT' 'SIGABRT';

##! @fn trapSIGEMT()
##! @brief Trap function for the SIGEMT signal.
##! @details Trap function for the SIGEMT signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGEMT signal.<br />return code: The return code of the last executed
##! command.

function trapSIGEMT() {
  local message='trapSIGEMT: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGEMT;

#trap 'trapSIGEMT' 'SIGEMT';

##! @fn trapSIGFPE()
##! @brief Trap function for the SIGFPE signal.
##! @details Trap function for the SIGFPE signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGFPE signal.<br />return code: The return code of the last executed
##! command.

function trapSIGFPE() {
  local message='trapSIGFPE: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGFPE;

#trap 'trapSIGFPE' 'SIGFPE';

##! @fn trapSIGKILL()
##! @brief Trap function for the SIGKILL signal.
##! @details Trap function for the SIGKILL signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGKILL signal.<br />return code: The return code of the last executed
##! command.

function trapSIGKILL() {
  local message='trapSIGKILL: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGKILL;

#trap 'trapSIGKILL' 'SIGKILL';

##! @fn trapSIGBUS()
##! @brief Trap function for the SIGBUS signal.
##! @details Trap function for the SIGBUS signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGBUS signal.<br />return code: The return code of the last executed
##! command.

function trapSIGBUS() {
  local message='trapSIGBUS: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGBUS;

#trap 'trapSIGBUS' 'SIGBUS';

##! @fn trapSIGSEGV()
##! @brief Trap function for the SIGSEGV signal.
##! @details Trap function for the SIGSEGV signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGSEGV signal.<br />return code: The return code of the last executed
##! command.

function trapSIGSEGV() {
  local message='trapSIGSEGV: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGSEGV;

#trap 'trapSIGSEGV' 'SIGSEGV';

##! @fn trapSIGSYS()
##! @brief Trap function for the SIGSYS signal.
##! @details Trap function for the SIGSYS signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGSYS signal.<br />return code: The return code of the last executed
##! command.

function trapSIGSYS() {
  local message='trapSIGSYS: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGSYS;

#trap 'trapSIGSYS' 'SIGSYS';

##! @fn trapSIGPIPE()
##! @brief Trap function for the SIGPIPE signal.
##! @details Trap function for the SIGPIPE signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGPIPE signal.<br />return code: The return code of the last executed
##! command.

function trapSIGPIPE() {
  local message='trapSIGPIPE: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGPIPE;

#trap 'trapSIGPIPE' 'SIGPIPE';

##! @fn trapSIGALRM()
##! @brief Trap function for the SIGALRM signal.
##! @details Trap function for the SIGALRM signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGALRM signal.<br />return code: The return code of the last executed
##! command.

function trapSIGALRM() {
  local message='trapSIGALRM: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGALRM;

#trap 'trapSIGALRM' 'SIGALRM';

##! @fn trapSIGTERM()
##! @brief Trap function for the SIGTERM signal.
##! @details Trap function for the SIGTERM signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGTERM signal.<br />return code: The return code of the last executed
##! command.

function trapSIGTERM() {
  local message='trapSIGTERM: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGTERM;

#trap 'trapSIGTERM' 'SIGTERM';

##! @fn trapSIGURG()
##! @brief Trap function for the SIGURG signal.
##! @details Trap function for the SIGURG signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGURG signal.<br />return code: The return code of the last executed
##! command.

function trapSIGURG() {
  local message='trapSIGURG: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGURG;

#trap 'trapSIGURG' 'SIGURG';

##! @fn trapSIGSTOP()
##! @brief Trap function for the SIGSTOP signal.
##! @details Trap function for the SIGSTOP signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGSTOP signal.<br />return code: The return code of the last executed
##! command.

function trapSIGSTOP() {
  local message='trapSIGSTOP: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGSTOP;

#trap 'trapSIGSTOP' 'SIGSTOP';

##! @fn trapSIGTSTP()
##! @brief Trap function for the SIGTSTP signal.
##! @details Trap function for the SIGTSTP signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGTSTP signal.<br />return code: The return code of the last executed
##! command.
##! @note CTRL-Z

function trapSIGTSTP() {
  local message='trapSIGTSTP: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGTSTP;

#trap 'trapSIGTSTP' 'SIGTSTP';

##! @fn trapSIGCONT()
##! @brief Trap function for the SIGCONT signal.
##! @details Trap function for the SIGCONT signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGCONT signal.<br />return code: The return code of the last executed
##! command.

function trapSIGCONT() {
  local message='trapSIGCONT: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGCONT;

#trap 'trapSIGCONT' 'SIGCONT';

##! @fn trapSIGCHLD()
##! @brief Trap function for the SIGCHLD signal.
##! @details Trap function for the SIGCHLD signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGCHLD signal.<br />return code: The return code of the last executed
##! command.

function trapSIGCHLD() {
  local message='trapSIGCHLD: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGCHLD;

#trap 'trapSIGCHLD' 'SIGCHLD';

##! @fn trapSIGTTIN()
##! @brief Trap function for the SIGTTIN signal.
##! @details Trap function for the SIGTTIN signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGTTIN signal.<br />return code: The return code of the last executed
##! command.

function trapSIGTTIN() {
  local message='trapSIGTTIN: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGTTIN;

#trap 'trapSIGTTIN' 'SIGTTIN';

##! @fn trapSIGTTOU()
##! @brief Trap function for the SIGTTOU signal.
##! @details Trap function for the SIGTTOU signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGTTOU signal.<br />return code: The return code of the last executed
##! command.

function trapSIGTTOU() {
  local message='trapSIGTTOU: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGTTOU;

#trap 'trapSIGTTOU' 'SIGTTOU';

##! @fn trapSIGIO()
##! @brief Trap function for the SIGIO signal.
##! @details Trap function for the SIGIO signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGIO signal.<br />return code: The return code of the last executed
##! command.

function trapSIGIO() {
  local message='trapSIGIO: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGIO;

#trap 'trapSIGIO' 'SIGIO';

##! @fn trapSIGXCPU()
##! @brief Trap function for the SIGXCPU signal.
##! @details Trap function for the SIGXCPU signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGXCPU signal.<br />return code: The return code of the last executed
##! command.

function trapSIGXCPU() {
  local message='trapSIGXCPU: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGXCPU;

#trap 'trapSIGXCPU' 'SIGXCPU';

##! @fn trapSIGXFSZ()
##! @brief Trap function for the SIGXFSZ signal.
##! @details Trap function for the SIGXFSZ signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGXFSZ signal.<br />return code: The return code of the last executed
##! command.

function trapSIGXFSZ() {
  local message='trapSIGXFSZ: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGXFSZ;

#trap 'trapSIGXFSZ' 'SIGXFSZ';

##! @fn trapSIGVTALRM()
##! @brief Trap function for the SIGVTALRM signal.
##! @details Trap function for the SIGVTALRM signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGVTALRM signal.<br />return code: The return code of the last executed
##! command.

function trapSIGVTALRM() {
  local message='trapSIGVTALRM: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGVTALRM;

#trap 'trapSIGVTALRM' 'SIGVTALRM';

##! @fn trapSIGPROF()
##! @brief Trap function for the SIGPROF signal.
##! @details Trap function for the SIGPROF signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGPROF signal.<br />return code: The return code of the last executed
##! command.

function trapSIGPROF() {
  local message='trapSIGPROF: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGPROF;

#trap 'trapSIGPROF' 'SIGPROF';

##! @fn trapSIGWINCH()
##! @brief Trap function for the SIGWINCH signal.
##! @details Trap function for the SIGWINCH signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGWINCH signal.<br />return code: The return code of the last executed
##! command.

function trapSIGWINCH() {
  local message='trapSIGWINCH: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGWINCH;

#trap 'trapSIGWINCH' 'SIGWINCH';

##! @fn trapSIGPWR()
##! @brief Trap function for the SIGPWR signal.
##! @details Trap function for the SIGPWR signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGPWR signal.<br />return code: The return code of the last executed
##! command.

function trapSIGPWR() {
  local message='trapSIGPWR: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGPWR;

#trap 'trapSIGPWR' 'SIGPWR';

##! @fn trapSIGUSR1()
##! @brief Trap function for the SIGUSR1 signal.
##! @details Trap function for the SIGUSR1 signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGUSR1 signal.<br />return code: The return code of the last executed
##! command.

function trapSIGUSR1() {
  local message='trapSIGUSR1: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGUSR1;

#trap 'trapSIGUSR1' 'SIGUSR1';

##! @fn trapSIGUSR2()
##! @brief Trap function for the SIGUSR2 signal.
##! @details Trap function for the SIGUSR2 signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGUSR2 signal.<br />return code: The return code of the last executed
##! command.

function trapSIGUSR2() {
  local message='trapSIGUSR2: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGUSR2;

#trap 'trapSIGUSR2' 'SIGUSR2';

##! @fn trapSIGRTMIN()
##! @brief Trap function for the SIGRTMIN signal.
##! @details Trap function for the SIGRTMIN signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGRTMIN signal.<br />return code: The return code of the last executed
##! command.

function trapSIGRTMIN() {
  local message='trapSIGRTMIN: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGRTMIN;

#trap 'trapSIGRTMIN' 'SIGRTMIN';

##! @fn trapSIGRTMIN1()
##! @brief Trap function for the SIGRTMIN+1 signal.
##! @details Trap function for the SIGRTMIN+1 signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGRTMIN+1 signal.<br />return code: The return code of the last executed
##! command.

function trapSIGRTMIN1() {
  local message='trapSIGRTMIN1: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGRTMIN1;

#trap 'trapSIGRTMIN1' 'SIGRTMIN+1';

##! @fn trapSIGRTMIN2()
##! @brief Trap function for the SIGRTMIN+2 signal.
##! @details Trap function for the SIGRTMIN+2 signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGRTMIN+2 signal.<br />return code: The return code of the last executed
##! command.

function trapSIGRTMIN2() {
  local message='trapSIGRTMIN2: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGRTMIN2;

#trap 'trapSIGRTMIN2' 'SIGRTMIN+2';

##! @fn trapSIGRTMIN3()
##! @brief Trap function for the SIGRTMIN+3 signal.
##! @details Trap function for the SIGRTMIN+3 signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGRTMIN+3 signal.<br />return code: The return code of the last executed
##! command.

function trapSIGRTMIN3() {
  local message='trapSIGRTMIN3: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGRTMIN3;

#trap 'trapSIGRTMIN3' 'SIGRTMIN+3';

##! @fn trapSIGRTMIN4()
##! @brief Trap function for the SIGRTMIN+4 signal.
##! @details Trap function for the SIGRTMIN+4 signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGRTMIN+4 signal.<br />return code: The return code of the last executed
##! command.

function trapSIGRTMIN4() {
  local message='trapSIGRTMIN4: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGRTMIN4;

#trap 'trapSIGRTMIN4' 'SIGRTMIN+4';

##! @fn trapSIGRTMIN5()
##! @brief Trap function for the SIGRTMIN+5 signal.
##! @details Trap function for the SIGRTMIN+5 signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGRTMIN+5 signal.<br />return code: The return code of the last executed
##! command.

function trapSIGRTMIN5() {
  local message='trapSIGRTMIN5: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGRTMIN5;

#trap 'trapSIGRTMIN5' 'SIGRTMIN+5';

##! @fn trapSIGRTMIN6()
##! @brief Trap function for the SIGRTMIN+6 signal.
##! @details Trap function for the SIGRTMIN+6 signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGRTMIN+6 signal.<br />return code: The return code of the last executed
##! command.

function trapSIGRTMIN6() {
  local message='trapSIGRTMIN6: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGRTMIN6;

#trap 'trapSIGRTMIN6' 'SIGRTMIN+6';

##! @fn trapSIGRTMIN7()
##! @brief Trap function for the SIGRTMIN+7 signal.
##! @details Trap function for the SIGRTMIN+7 signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGRTMIN+7 signal.<br />return code: The return code of the last executed
##! command.

function trapSIGRTMIN7() {
  local message='trapSIGRTMIN7: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGRTMIN7;

#trap 'trapSIGRTMIN7' 'SIGRTMIN+7';

##! @fn trapSIGRTMIN8()
##! @brief Trap function for the SIGRTMIN+8 signal.
##! @details Trap function for the SIGRTMIN+8 signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGRTMIN+8 signal.<br />return code: The return code of the last executed
##! command.

function trapSIGRTMIN8() {
  local message='trapSIGRTMIN8: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGRTMIN8;

#trap 'trapSIGRTMIN8' 'SIGRTMIN+8';

##! @fn trapSIGRTMIN9()
##! @brief Trap function for the SIGRTMIN+9 signal.
##! @details Trap function for the SIGRTMIN+9 signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGRTMIN+9 signal.<br />return code: The return code of the last executed
##! command.

function trapSIGRTMIN9() {
  local message='trapSIGRTMIN9: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGRTMIN9;

#trap 'trapSIGRTMIN9' 'SIGRTMIN+9';

##! @fn trapSIGRTMIN10()
##! @brief Trap function for the SIGRTMIN+10 signal.
##! @details Trap function for the SIGRTMIN+10 signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGRTMIN+10 signal.<br />return code: The return code of the last executed
##! command.

function trapSIGRTMIN10() {
  local message='trapSIGRTMIN10: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGRTMIN10;

#trap 'trapSIGRTMIN10' 'SIGRTMIN+10';

##! @fn trapSIGRTMIN11()
##! @brief Trap function for the SIGRTMIN+11 signal.
##! @details Trap function for the SIGRTMIN+11 signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGRTMIN+11 signal.<br />return code: The return code of the last executed
##! command.

function trapSIGRTMIN11() {
  local message='trapSIGRTMIN11: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGRTMIN11;

#trap 'trapSIGRTMIN11' 'SIGRTMIN+11';

##! @fn trapSIGRTMIN12()
##! @brief Trap function for the SIGRTMIN+12 signal.
##! @details Trap function for the SIGRTMIN+12 signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGRTMIN+12 signal.<br />return code: The return code of the last executed
##! command.

function trapSIGRTMIN12() {
  local message='trapSIGRTMIN12: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGRTMIN12;

#trap 'trapSIGRTMIN12' 'SIGRTMIN+12';

##! @fn trapSIGRTMIN13()
##! @brief Trap function for the SIGRTMIN+13 signal.
##! @details Trap function for the SIGRTMIN+13 signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGRTMIN+13 signal.<br />return code: The return code of the last executed
##! command.

function trapSIGRTMIN13() {
  local message='trapSIGRTMIN13: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGRTMIN13;

#trap 'trapSIGRTMIN13' 'SIGRTMIN+13';

##! @fn trapSIGRTMIN14()
##! @brief Trap function for the SIGRTMIN+14 signal.
##! @details Trap function for the SIGRTMIN+14 signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGRTMIN+14 signal.<br />return code: The return code of the last executed
##! command.

function trapSIGRTMIN14() {
  local message='trapSIGRTMIN14: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGRTMIN14;

#trap 'trapSIGRTMIN14' 'SIGRTMIN+14';

##! @fn trapSIGRTMIN15()
##! @brief Trap function for the SIGRTMIN+15 signal.
##! @details Trap function for the SIGRTMIN+15 signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGRTMIN+15 signal.<br />return code: The return code of the last executed
##! command.

function trapSIGRTMIN15() {
  local message='trapSIGRTMIN15: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGRTMIN15;

#trap 'trapSIGRTMIN15' 'SIGRTMIN+15';

##! @fn trapSIGRTMIN16()
##! @brief Trap function for the SIGRTMIN+16 signal.
##! @details Trap function for the SIGRTMIN+16 signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGRTMIN+16 signal.<br />return code: The return code of the last executed
##! command.

function trapSIGRTMIN16() {
  local message='trapSIGRTMIN16: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGRTMIN16;

#trap 'trapSIGRTMIN16' 'SIGRTMIN+16';

##! @fn trapSIGRTMAX15()
##! @brief Trap function for the SIGRTMAX-15 signal.
##! @details Trap function for the SIGRTMAX-15 signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGRTMAX-15 signal.<br />return code: The return code of the last executed
##! command.

function trapSIGRTMAX15() {
  local message='trapSIGRTMAX15: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGRTMAX15;

#trap 'trapSIGRTMAX15' 'SIGRTMAX-15';

##! @fn trapSIGRTMAX14()
##! @brief Trap function for the SIGRTMAX-14 signal.
##! @details Trap function for the SIGRTMAX-14 signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGRTMAX-14 signal.<br />return code: The return code of the last executed
##! command.

function trapSIGRTMAX14() {
  local message='trapSIGRTMAX14: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGRTMAX14;

#trap 'trapSIGRTMAX14' 'SIGRTMAX-14';

##! @fn trapSIGRTMAX13()
##! @brief Trap function for the SIGRTMAX-13 signal.
##! @details Trap function for the SIGRTMAX-13 signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGRTMAX-13 signal.<br />return code: The return code of the last executed
##! command.

function trapSIGRTMAX13() {
  local message='trapSIGRTMAX13: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGRTMAX13;

#trap 'trapSIGRTMAX13' 'SIGRTMAX-13';

##! @fn trapSIGRTMAX12()
##! @brief Trap function for the SIGRTMAX-12 signal.
##! @details Trap function for the SIGRTMAX-12 signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGRTMAX-12 signal.<br />return code: The return code of the last executed
##! command.

function trapSIGRTMAX12() {
  local message='trapSIGRTMAX12: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGRTMAX12;

#trap 'trapSIGRTMAX12' 'SIGRTMAX-12';

##! @fn trapSIGRTMAX11()
##! @brief Trap function for the SIGRTMAX-11 signal.
##! @details Trap function for the SIGRTMAX-11 signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGRTMAX-11 signal.<br />return code: The return code of the last executed
##! command.

function trapSIGRTMAX11() {
  local message='trapSIGRTMAX11: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGRTMAX11;

#trap 'trapSIGRTMAX11' 'SIGRTMAX-11';

##! @fn trapSIGRTMAX10()
##! @brief Trap function for the SIGRTMAX-10 signal.
##! @details Trap function for the SIGRTMAX-10 signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGRTMAX-10 signal.<br />return code: The return code of the last executed
##! command.

function trapSIGRTMAX10() {
  local message='trapSIGRTMAX10: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGRTMAX10;

#trap 'trapSIGRTMAX10' 'SIGRTMAX-10';

##! @fn trapSIGRTMAX9()
##! @brief Trap function for the SIGRTMAX-9 signal.
##! @details Trap function for the SIGRTMAX-9 signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGRTMAX-9 signal.<br />return code: The return code of the last executed
##! command.

function trapSIGRTMAX9() {
  local message='trapSIGRTMAX9: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGRTMAX9;

#trap 'trapSIGRTMAX9' 'SIGRTMAX-9';

##! @fn trapSIGRTMAX8()
##! @brief Trap function for the SIGRTMAX-8 signal.
##! @details Trap function for the SIGRTMAX-8 signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGRTMAX-8 signal.<br />return code: The return code of the last executed
##! command.

function trapSIGRTMAX8() {
  local message='trapSIGRTMAX8: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGRTMAX8;

#trap 'trapSIGRTMAX8' 'SIGRTMAX-8';

##! @fn trapSIGRTMAX7()
##! @brief Trap function for the SIGRTMAX-7 signal.
##! @details Trap function for the SIGRTMAX-7 signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGRTMAX-7 signal.<br />return code: The return code of the last executed
##! command.

function trapSIGRTMAX7() {
  local message='trapSIGRTMAX7: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGRTMAX7;

#trap 'trapSIGRTMAX7' 'SIGRTMAX-7';

##! @fn trapSIGRTMAX6()
##! @brief Trap function for the SIGRTMAX-6 signal.
##! @details Trap function for the SIGRTMAX-6 signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGRTMAX-6 signal.<br />return code: The return code of the last executed
##! command.

function trapSIGRTMAX6() {
  local message='trapSIGRTMAX6: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGRTMAX6;

#trap 'trapSIGRTMAX6' 'SIGRTMAX-6';

##! @fn trapSIGRTMAX5()
##! @brief Trap function for the SIGRTMAX-5 signal.
##! @details Trap function for the SIGRTMAX-5 signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGRTMAX-5 signal.<br />return code: The return code of the last executed
##! command.

function trapSIGRTMAX5() {
  local message='trapSIGRTMAX5: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGRTMAX5;

#trap 'trapSIGRTMAX5' 'SIGRTMAX-5';

##! @fn trapSIGRTMAX4()
##! @brief Trap function for the SIGRTMAX-4 signal.
##! @details Trap function for the SIGRTMAX-4 signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGRTMAX-4 signal.<br />return code: The return code of the last executed
##! command.

function trapSIGRTMAX4() {
  local message='trapSIGRTMAX4: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGRTMAX4;

#trap 'trapSIGRTMAX4' 'SIGRTMAX-4';

##! @fn trapSIGRTMAX3()
##! @brief Trap function for the SIGRTMAX-3 signal.
##! @details Trap function for the SIGRTMAX-3 signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGRTMAX-3 signal.<br />return code: The return code of the last executed
##! command.

function trapSIGRTMAX3() {
  local message='trapSIGRTMAX3: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGRTMAX3;

#trap 'trapSIGRTMAX3' 'SIGRTMAX-3';

##! @fn trapSIGRTMAX2()
##! @brief Trap function for the SIGRTMAX-2 signal.
##! @details Trap function for the SIGRTMAX-2 signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGRTMAX-2 signal.<br />return code: The return code of the last executed
##! command.

function trapSIGRTMAX2() {
  local message='trapSIGRTMAX2: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGRTMAX2;

#trap 'trapSIGRTMAX2' 'SIGRTMAX-2';

##! @fn trapSIGRTMAX1()
##! @brief Trap function for the SIGRTMAX-1 signal.
##! @details Trap function for the SIGRTMAX-1 signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGRTMAX-1 signal.<br />return code: The return code of the last executed
##! command.

function trapSIGRTMAX1() {
  local message='trapSIGRTMAX1: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGRTMAX1;

#trap 'trapSIGRTMAX1' 'SIGRTMAX-1';

##! @fn trapSIGRTMAX()
##! @brief Trap function for the SIGRTMAX signal.
##! @details Trap function for the SIGRTMAX signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! SIGRTMAX signal.<br />return code: The return code of the last executed
##! command.

function trapSIGRTMAX() {
  local message='trapSIGRTMAX: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapSIGRTMAX;

#trap 'trapSIGRTMAX' 'SIGRTMAX';

##! @fn trapEXIT()
##! @brief Trap function for the EXIT signal.
##! @details Trap function for the EXIT signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! EXIT signal.<br />return code: The return code of the last executed
##! command.

function trapEXIT() {
  local message='trapEXIT: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapEXIT;

#trap 'trapEXIT' 'EXIT';

##! @fn trapDEBUG()
##! @brief Trap function for the DEBUG signal.
##! @details Trap function for the DEBUG signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! DEBUG signal.<br />return code: The return code of the last executed
##! command.

function trapDEBUG() {
  local message='trapDEBUG: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapDEBUG;

#trap 'trapDEBUG' 'DEBUG';

##! @fn trapRETURN()
##! @brief Trap function for the RETURN signal.
##! @details Trap function for the RETURN signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! RETURN signal.<br />return code: The return code of the last executed
##! command.

function trapRETURN() {
  local message='trapRETURN: This function is not yet fully implemented.';
  printf '%s\n' "${message}";
  return "${?}";
}
readonly -f trapRETURN;

#trap 'trapRETURN' 'RETURN';

##! @fn trapERR()
##! @brief Trap function for the ERR signal.
##! @details Trap function for the ERR signal.
##! @param[in] void<br />n/a
##! @return string message<br />return value: The message shown in case of the
##! ERR signal.<br />return code: The return code of the last executed
##! command.

function trapERR() {
  local -r -i line_number="${1}";
  local -r -i exit_status="${2}";
  local -r    bash_commannd="${3}";

  local       message='trapERR: This function is not yet fully implemented.';
  local       format='';

  format+='%s';
  format+='\n';
  format+="  line number : '%s'";
  format+='\n';
  format+="  exit status : '%s'";
  format+='\n';
  format+="  bash command: '%s'";
  format+='\n';

  format+="$( dumpStackTraceFromTo; )";
  format+='\n';


  printf "${format}" \
         "${message}" \
         "${line_number}" \
         "${exit_status}" \
         "${bash_commannd}";

  return "${?}";
}
readonly -f trapERR;

trap 'trapERR "${LINENO}" "${?}" "${BASH_COMMAND}"' 'ERR';

## >> debugging >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

## > head >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

                                                                                DEBUG printf '%s\n' 'begin shell script ...';

## < body <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

## << include files <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

## get the directory where this script is.

##! @var SOURCE_DIRECTORY
##! @brief The source directory.
##! @details The source directory.

declare -r SOURCE_DIRECTORY="${BASH_SOURCE%/*}";

## include liblogger.sh

if [[ -e "${SOURCE_DIRECTORY}/liblogger.sh" ]]; then
  source "${SOURCE_DIRECTORY}/liblogger.sh";
else
  printf '%s\n' "Error: The file 'liblogger.sh' is required.";
  exit 1;
fi

enableLogging;
setLogLevel "${LOG_LEVEL_ALL}";
                                                                                DEBUG printf '%s\n' "The logger state is set to '$( getLoggingState; )'";
                                                                                DEBUG printf '%s\n' "The logger level is set to '$( getLogLevel; )'";

## >> include files >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

## << global constants <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

## Command Line Arguments

##! @var _ARG0
##! @brief The name of the shell script.
##! @details The special parameter $0 expands to the name of the shell or shell
##! script.
##! @note $BASH_ARGV0

declare -r    _ARG0="${0}";                                                     DEBUG printf '%s\n' "$( declare -p _ARG0; )";

##! @var _ARGC
##! @brief The number of positional parameters.
##! @details The special parameter $# expands to the number of positional
##! parameters.
##! @note $BASH_ARGC

declare -r -i _ARGC="${#}";                                                     DEBUG printf '%s\n' "$( declare -p _ARGC; )";

##! @var _ARGV
##! @brief The positional parameters.
##! @details The special parameter $@ expands to the positional parameters.
##! @note $BASH_ARGV

declare -r -a _ARGV=( "${@}" );                                                 DEBUG printf '%s\n' "$( declare -p _ARGV; )";

## Exit Codes and Return Codes

## Exit Codes
##
## (1) bash$ trap -l
##
## (2) Appendix E. Exit Codes With Special Meanings
##     <https://tldp.org/LDP/abs/html/exitcodes.html>
##
##
##
## from (2):
##
## Reserved Exit Codes:
## exit code|meaning
## ---------+------------------------------
##     1    |catchall for general errors
##     2    |misuse of shell builtins
##   126    |command invoked cannot execute
##   127    |command not found
##   128    |invalid argument to exit
##   128 + n|fatal error signal "n"
##          |  n = 1 ... 64 => 129 ... 192
##   255    |exit status out of range
##
##
##
## from (1):
##
## Signals
##
##  1) SIGHUP       2) SIGINT       3) SIGQUIT      4) SIGILL       5) SIGTRAP
##  6) SIGABRT      7) SIGEMT       8) SIGFPE       9) SIGKILL     10) SIGBUS
## 11) SIGSEGV     12) SIGSYS      13) SIGPIPE     14) SIGALRM     15) SIGTERM
## 16) SIGURG      17) SIGSTOP     18) SIGTSTP     19) SIGCONT     20) SIGCHLD
## 21) SIGTTIN     22) SIGTTOU     23) SIGIO       24) SIGXCPU     25) SIGXFSZ
## 26) SIGVTALRM   27) SIGPROF     28) SIGWINCH    29) SIGPWR      30) SIGUSR1
## 31) SIGUSR2     32) SIGRTMIN    33) SIGRTMIN+1  34) SIGRTMIN+2  35) SIGRTMIN+3
## 36) SIGRTMIN+4  37) SIGRTMIN+5  38) SIGRTMIN+6  39) SIGRTMIN+7  40) SIGRTMIN+8
## 41) SIGRTMIN+9  42) SIGRTMIN+10 43) SIGRTMIN+11 44) SIGRTMIN+12 45) SIGRTMIN+13
## 46) SIGRTMIN+14 47) SIGRTMIN+15 48) SIGRTMIN+16 49) SIGRTMAX-15 50) SIGRTMAX-14
## 51) SIGRTMAX-13 52) SIGRTMAX-12 53) SIGRTMAX-11 54) SIGRTMAX-10 55) SIGRTMAX-9
## 56) SIGRTMAX-8  57) SIGRTMAX-7  58) SIGRTMAX-6  59) SIGRTMAX-5  60) SIGRTMAX-4
## 61) SIGRTMAX-3  62) SIGRTMAX-2  63) SIGRTMAX-1  64) SIGRTMAX

##! @var EXIT_NO_ERROR
##! @brief The exit code for no error.
##! @details The exit code to signal that the command executed successfully.
##! @note success

declare -r -i EXIT_NO_ERROR=0;

##! @var EXIT_GENERAL_ERROR
##! @brief The exit code for a general error.
##! @details The exit code to signal that the command did not execute
##! successfully.
##! @note failure

declare -r -i EXIT_GENERAL_ERROR=1;

##! @var RETURN_NO_ERROR
##! @brief The return code for a general error.
##! @details The return code to signal that the function executed successfully.
##! @note success

declare -r -i RETURN_NO_ERROR=0;

##! @var RETURN_GENERAL_ERROR
##! @brief The return code for a general error.
##! @details The return code to signal that the function did not execute
##! successfully.
##! @note failure

declare -r -i RETURN_GENERAL_ERROR=1;

## >> global constants >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

## << global variables <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

## Exit Status

##! @var exit_status
##! @brief The exit status.
##! @details The special parameter $? expands to the exit status of the most
##! recently executed foreground pipeline.

declare    -i exit_status=0;

## >> global variables >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

## << global functions <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

## >> global functions >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

## < main <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

## ???: todo: add comment
function main() {
local -r    ARG0="${1}"; shift 1;
local -r -i ARGC="${1}"; shift 1;
local -r -a ARGV=( "${@}" );
return "${?}";
}
readonly -f main;

## Run main function.

main "${_ARG0}" "${_ARGC}" "${_ARGV}";

## Get the exit status of the function main.

exit_status="${?}";

## >> main >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

## > body >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

                                                                                DEBUG printf '%s\n' '... finished git-gnu-project';

## < tail <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

## << exit <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


## Exit from the shell script.  The exit status is that of the main function.

exit "${exit_status}";

## >> exit >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

## > tail >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
