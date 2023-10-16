
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



##! @file logger.sh
##!
##! @brief Logger for bash.
##!
##! @details Logger for bash similar as log4j.



## < include guard <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

## Prevent from including this file more than once.  Check include guard.

[[ -v _LIBLOGGER_SH_ ]] && return 0;

## > include guard >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



## < head <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

## << shell options <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

## >> shell options >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

## > head >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

## < body <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

## << debugging <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

## >> debugging >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

## << include files <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

## >> include files >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

## << global constants <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

## log4j Logging levels:
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

##! @var LOG_LEVEL_ALL
##! @brief Log level ALL.
##! @details Show all log messages.  Enable log messages.

declare -r -i LOG_LEVEL_ALL=0;

##! @var LOG_LEVEL_TRACE
##! @brief Log level TRACE.
##! @details Show log messages from TRACE and below.

declare -r -i LOG_LEVEL_TRACE=1;

##! @var LOG_LEVEL_DEBUG
##! @brief Log level DEBUG.
##! @details Show log messages from DEBUG and below.

declare -r -i LOG_LEVEL_DEBUG=2;

##! @var LOG_LEVEL_INFO
##! @brief Log level INFO.
##! @details Show log messages from INFO and below.

declare -r -i LOG_LEVEL_INFO=3;

##! @var LOG_LEVEL_WARN
##! @brief Log level WARN.
##! @details Show log messages from WARN and below.

declare -r -i LOG_LEVEL_WARN=4;

##! @var LOG_LEVEL_ERROR
##! @brief Log level ERROR.
##! @details Show log messages from ERROR and below.

declare -r -i LOG_LEVEL_ERROR=5;

##! @var LOG_LEVEL_FATAL
##! @brief Log level FATAL.
##! @details Show log messages from FATAL and below.

declare -r -i LOG_LEVEL_FATAL=6;

##! @var LOG_LEVEL_OFF
##! @brief Log level OFF.
##! @details Show no log messages.  Disable log messages.

declare -r -i LOG_LEVEL_OFF=7;

##! @var LOGGING_ON
##! @brief Constant to switch logging on.
##! @details Constant to switch logging on.

declare -r -i LOGGING_ON=0;

##! @var LOGGING_OFF
##! @brief Constant to switch logging off.
##! @details Constant to switch logging off.

declare -r -i LOGGING_OFF=1;

## >> global constants >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

## << global variables <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

##! @var log_level
##! @brief The selected log level.
##! @details The default log level.

declare -i log_level="${LOG_LEVEL_ERROR}";

##! @var logging_state
##! @brief Wether to enable or disable logging.
##! @details Wether to enable or disable logging.

declare -i logging_state="${LOGGING_ON}";

## >> global variables >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

## << global functions <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

##! @fn dumpStackTraceCaller()
##! @brief Dump a stack trace.
##! @details Create a stack trace using bash caller builtin.
##! @param[in] void<br />n/a
##! @return sting stack_trace<br />return value: The stack trace.<br />return
##! code: The return code of the last executed command.

function dumpStackTraceCaller() {
  local    -i line_number=0;
  local       function_name='';
  local       file_name='';
  local    -i frame=0;
  local       stack_trace='context of subroutine call:';
  local       line='';
  while IFS=' ' read -r \
                     'line_number' \
                     'function_name' \
                     'file_name' < <( caller "${frame}" || return ); do
    printf -v 'line' \
           '\n  (%d) %s at %s:%d' \
           "${frame}" \
           "${function_name}" \
           "${file_name}" \
           "${line_number}";
    stack_trace+="${line}";
    frame="$(( ${frame} + 1 ))";
  done
  printf '%b\n' "${stack_trace}";
  return "${?}";
}
readonly -f dumpStackTraceCaller;

##! @fn dumpStackTraceFuncname()
##! @brief Dump a stack trace.
##! @details Create a stack trace using $FUNCNAME, $BASH_SOURCE and
##! $BASH_LINENO.
##! @startglobal
##! @itemglobal{in,array-of-string,FUNCNAME<br />The names of all shell
##! functions currently in the execution call stack.}
##! @itemglobal{in,array-of-string,BASH_SOURCE<br />The file names where the
##! shell functions of FUNCNAME are defined.}
##! @itemglobal{in,integer,BASH_LINENO<br />The line numbers in the files where
##! the shell functions of FUNCNAME are defined.}
##! @endglobal
##! @param[in] void<br />n/a
##! @return sting stack_trace<br />return value: The stack trace.<br />return
##! code: The return code of the last executed command.

function dumpStackTraceFuncname() {
  local -r -a function_names=( "${FUNCNAME[@]}" );
  local -r -a file_names=( "${BASH_SOURCE[@]}" );
  local -r -a line_numbers=( "${BASH_LINENO[@]}" );
  local       function_name='';
  local       file_name='';
  local    -i line_number=0;
  local -r -i count="$(( ${#function_names[@]} - 0 ))";

  local    -i frame=0;
  local       stack_trace='current execution call stack:';
  local       line='';

  for (( frame=1; frame<"${count}"; frame++ )); do
    function_name="${function_names[$(( "${frame}" - 0 ))]}";
    [ "x${function_name}" = 'x' ] && function_name='MAIN';
    file_name="${file_names[$(( "${frame}" - 0 ))]}";
    [ "x${file_name}" = 'x' ] && file_name='NON-FILE-SOURCE';
    line_number="${line_numbers[$(( "${frame}" - 1 ))]}";
    printf -v 'line' \
           '\n  (%d) %s at %s:%d' \
           "${frame}" \
           "${function_name}" \
           "${file_name}" \
           "${line_number}";
    stack_trace+="${line}";
  done
  printf '%b\n' "${stack_trace}";
  return "${?}";
}
readonly -f dumpStackTraceFuncname;

##! @fn dumpStackTraceFromTo()
##! @brief Dump a stack trace.
##! @details Create a stack trace using $FUNCNAME, $BASH_SOURCE and
##! $BASH_LINENO.  It shows from where a function is called.
##! @startglobal
##! @itemglobal{in,array-of-string,FUNCNAME<br />The names of all shell
##! functions currently in the execution call stack.}
##! @itemglobal{in,array-of-string,BASH_SOURCE<br />The file names where the
##! shell functions of FUNCNAME are defined.}
##! @itemglobal{in,integer,BASH_LINENO<br />The line numbers in the files where
##! the shell functions of FUNCNAME are defined.}
##! @endglobal
##! @param[in] void<br />n/a
##! @return sting stack_trace<br />return value: The stack trace.<br />return
##! code: The return code of the last executed command.

function dumpStackTraceFromTo() {
  local -r -a function_names=( "${FUNCNAME[@]}" );
  local -r -a file_names=( "${BASH_SOURCE[@]}" );
  local -r -a line_numbers=( "${BASH_LINENO[@]}" );
  local       function_name='';
  local       file_name='';
  local    -i line_number=0;
  local -r -i count="$(( ${#function_names[@]} - 0 ))";

  local    -i frame=0;
  local       stack_trace='stack trace dump:';
  local       line='';
  local    -a target=();

  for (( frame=1; frame<"${count}"; frame++ )); do
    function_name="${function_names[$(( "${frame}" - 0 ))]}";
    #[ "x${function_name}" = 'x' ] && function_name='MAIN';
    file_name="${file_names[$(( "${frame}" - 0 ))]}";
    #[ "x${file_name}" = 'x' ] && file_name='NON-FILE-SOURCE';
    line_number="${line_numbers[$(( "${frame}" - 1 ))]}";
    printf -v line \
           "\n  (%d) %s at %s:%d" \
           "${frame}" \
           "${function_name}" \
           "${file_name}" \
           "${line_number}";
    stack_trace+="${line}";
    stack_trace+=' ';
    stack_trace+='-->';
    stack_trace+=' ';
    readarray -d ' ' target < <( declare -F "${FUNCNAME[$(( "${frame}" - 1 ))]}" );
    function_name="${target[0]}";
    function_name="${function_name% }";
    file_name="${target[2]}";
    file_name="${file_name%$'\n'}";
    line_number="${target[1]}";
    line_number="${line_number% }";
    printf -v line \
           "%s at %s:%d" \
           "${function_name}" \
           "${file_name}" \
           "${line_number}";
    stack_trace+="${line}";
  done
  printf '%b\n' "${stack_trace}";
  return "${?}";
}
readonly -f dumpStackTraceFromTo;

##! @fn setLogLevel()
##! @brief Set the current log level.
##! @details Set the current log level using one of the log levels:<br /><br />
##! TRACE (1, lowest) < DEBUG (2) < INFO (3) < WARN (4) < ERROR (5) < FATAL (6,
##! highest)
##! @startglobal
##! @itemglobal{out,integer,log_level<br />The selected log level.}
##! @endglobal
##! @param[in] integer level<br />The current log level.
##! @return void<br />
##! return value: n/a<br />
##! return code: The return code of the last executed command.

function setLogLevel() {
  local -r -i level="${1}";
  log_level="${level}";
  return "${?}";
}
readonly -f setLogLevel;

##! @fn getLogLevel()
##! @brief Get current log level.
##! @details Get the current log level using one of the log levels:<br /><br />
##! TRACE (1, lowest) < DEBUG (2) < INFO (3) < WARN (4) < ERROR (5) < FATAL (6,
##! highest)
##! @startglobal
##! @itemglobal{in,integer,log_level<br />The selected log level.}
##! @endglobal
##! @param[in] void<br />n/a
##! @return integer level<br />
##! return value: The currently selected log level<br />
##! return code: The return code of the last executed command.

function getLogLevel() {
  local -r -i level="${log_level}";
  echo "${level}";
  return "${?}";
}
readonly -f getLogLevel;

##! @fn enableLogging()
##! @brief Enable logging.
##! @brief Enable logging.
##! @startglobal
##! @itemglobal{in,integer,LOGGING_ON<br />Constant to switch logging on.}
##! @endglobal
##! @param[in] void<br />n/a
##! @return void<br />
##! return value: n/a<br />
##! return code: The return code of the last executed command.

function enableLogging() {
  local -r -i state="${LOGGING_ON}";
  logging_state="${state}";
  return "${?}";
}
readonly -f enableLogging;

##! @fn disableLogging()
##! @brief Disable logging.
##! @brief Disable logging.
##! @startglobal
##! @itemglobal{in,integer,LOGGING_OFF<br />Constant to switch logging off.}
##! @endglobal
##! @param[in] void<br />n/a
##! @return integer state<br />
##! return value: State if logging is enabled or disabled.<br />
##! return code: The return code of the last executed command.

function disableLogging() {
  local -r -i state="${LOGGING_OFF}";
  logging_state="${state}";
  return "${?}";
}
readonly -f disableLogging;

##! @fn setLoggingState()
##! @brief Set the logging state.
##! @details Set the logging state.
##! @param[in] integer state<br />The logger state.
##! @return void<br />
##! return value: n/a<br />
##! return code: The return code of the last executed command.

function setLoggingState() {
  local -r -i state="${1}";
  logging_state="${state}";
  return "${?}";
}
readonly -f setLoggingState;

##! @fn getLoggingState()
##! @brief Get the logging state.
##! @details Get the logging state.
##! @param[in] void<br />n/a
##! @return integer state<br />
##! return value: The logger state.<br />
##! return code: The return code of the last executed command.

function getLoggingState() {
  local -r -i state="${logging_state}";
  echo "${state}";
  return "${?}";
}
readonly -f getLoggingState;

##! @fn printLog()
##! @brief Print log message to STDOUT.
##! @details Print log message to STDOUT.
##! Example:
##! @code
##! printLog INFO a message
##! @endcode
##! @startglobal
##! @itemglobal{in,integer,log_level<br />The selected log level.}
##! @itemglobal{in,integer,LOG_LEVEL_ALL<br />Log level ALL.}
##! @itemglobal{in,integer,LOG_LEVEL_TRACE<br />Log level TRACE.}
##! @itemglobal{in,integer,LOG_LEVEL_DEBUG<br />Log level DEBUG.}
##! @itemglobal{in,integer,LOG_LEVEL_INFO<br />Log level INFO.}
##! @itemglobal{in,integer,LOG_LEVEL_WARN<br />Log level WARN.}
##! @itemglobal{in,integer,LOG_LEVEL_ERROR<br />Log level ERROR.}
##! @itemglobal{in,integer,LOG_LEVEL_FATAL<br />Log level FATAL.}
##! @itemglobal{in,integer,LOG_LEVEL_OFF<br />Log level OFF.}
##! @endglobal
##! @param[in] integer level<br />The log level.
##! @param[in] array-of-string message<br />The log message.
##! @return string result<br />
##! return value: The log entry.<br />
##! return code: The return code of the last executed command.

function printLog() {
  local -r -i level="${1}"; shift 1;
  local -r -a message=( "${@}" );
  local -r    timestamp="${EPOCHREALTIME}";
  local -r    format='[%010s] [%- 5s] %s';
  local       result='';

  if    (( "${log_level}" <= LOG_LEVEL_ALL )) \
     && (( level == LOG_LEVEL_ALL )); then
    printf -v 'result' "${format}" "${timestamp}" 'ALL' "$( echo "${message[@]}" )";
  else
    :;
  fi
  if    (( "${log_level}" <= LOG_LEVEL_TRACE )) \
     && (( level == LOG_LEVEL_TRACE )); then
    printf -v 'result' "${format}" "${timestamp}" 'TRACE' "$( echo "${message[@]}" )";
    result+="\n";
    result+="$( dumpStackTraceFromTo )";
  else
    :;
  fi
  if    (( "${log_level}" <= LOG_LEVEL_DEBUG )) \
     && (( level == LOG_LEVEL_DEBUG )); then
    printf -v 'result' "${format}" "${timestamp}" 'DEBUG' "$( echo "${message[@]}" )";
  else
    :;
  fi
  if    (( "${log_level}" <= LOG_LEVEL_INFO )) \
     && (( level == LOG_LEVEL_INFO )); then
    printf -v 'result' "${format}" "${timestamp}" 'INFO' "$( echo "${message[@]}" )";
  else
    :;
  fi
  if    (( "${log_level}" <= LOG_LEVEL_WARN )) \
     && (( level == LOG_LEVEL_WARN )); then
    printf -v 'result' "${format}" "${timestamp}" 'WARN' "$( echo "${message[@]}" )";
  else
    :;
  fi
  if    (( "${log_level}" <= LOG_LEVEL_ERROR )) \
     && (( level == LOG_LEVEL_ERROR )); then
    printf -v 'result' "${format}" "${timestamp}" 'ERROR' "$( echo "${message[@]}" )";
  else
    :;
  fi
  if    (( "${log_level}" <= LOG_LEVEL_FATAL )) \
     && (( level == LOG_LEVEL_FATAL )); then
    printf -v 'result' "${format}" "${timestamp}" 'FATAL' "$( echo "${message[@]}" )";
  else
    :;
  fi
  if    (( "${log_level}" == LOG_LEVEL_OFF )) \
     && (( level == LOG_LEVEL_OFF )); then
    printf -v 'result' "${format}" "${timestamp}" 'OFF' "$( echo "${message[@]}" )";
  else
    :;
  fi

  printf '%b\n' "${result}";
  return;
}
readonly -f printLog;

##! @fn printLogTRACE()
##! @brief Print TRACE log message.
##! @details Print TRACE log message. Make a stack trace also.
##! @param[in] array-of-string message<br />The message.
##! @return string log_message<br />
##! return value: The log message<br />
##! return code: The return code of the last executed command.

function printLogTRACE() {
  local -r -a message=( "${@}" );
  local log_message="$( printLog "${LOG_LEVEL_TRACE}" "${message[@]}" )";
  printf '%s\n' "${log_message}";
  return;
}
readonly -f printLogTRACE;

##! @fn printLogDEBUG()
##! @brief Print DEBUG log message.
##! @details Print DEBUG log message.
##! @param[in] array-of-string message<br />The message.
##! @return string log_message<br />
##! return value: The log message<br />
##! return code: The return code of the last executed command.

function printLogDEBUG() {
  local -r -a message=( "${@}" );
  local log_message="$( printLog "${LOG_LEVEL_DEBUG}" "${message[@]}" )";
  if (( 0 == "${logging_state}" )); then
    printf '%s\n' "${log_message}";
  else
    :;
  fi
  return;
}
readonly -f printLogDEBUG;

##! @fn printLogINFO()
##! @brief Print INFO log message.
##! @details Print INFO log message.
##! @param[in] array-of-string message<br />The message.
##! @return string log_message<br />
##! return value: The log message<br />
##! return code: The return code of the last executed command.

function printLogINFO() {
  local -r -a message=( "${@}" );
  local log_message="$( printLog "${LOG_LEVEL_INFO}" "${message[@]}" )";
  if (( 0 == "${logging_state}" )); then
    printf '%s\n' "${log_message}";
  else
    :;
  fi
  return;
}
readonly -f printLogINFO;

##! @fn printLogWARN()
##! @brief Print WARN log message.
##! @details Print WARN log message.
##! @param[in] array-of-string message<br />The message.
##! @return string log_message<br />
##! return value: The log message<br />
##! return code: The return code of the last executed command.

function printLogWARN() {
  local -r -a message=( "${@}" );
  local log_message="$( printLog "${LOG_LEVEL_WARN}" "${message[@]}" )";
  if (( 0 == "${logging_state}" )); then
    printf '%s\n' "${log_message}";
  else
    :;
  fi
  return;
}
readonly -f printLogWARN;

##! @fn printLogERROR()
##! @brief Print ERROR log message.
##! @details Print ERROR log message.
##! @param[in] array-of-string message<br />The message.
##! @return string log_message<br />
##! return value: The log message<br />
##! return code: The return code of the last executed command.

function printLogERROR() {
  local -r -a message=( "${@}" );
  local log_message="$( printLog "${LOG_LEVEL_ERROR}" "${message[@]}" )";
  if (( 0 == "${logging_state}" )); then
    printf '%s\n' "${log_message}";
  else
    :;
  fi
  return;
}
readonly -f printLogERROR;

##! @fn printLogFATAL()
##! @brief Print FATAL log message.
##! @details Print FATAL log message.
##! @param[in] array-of-string message<br />The message.
##! @return string log_message<br />
##! return value: The log message<br />
##! return code: The return code of the last executed command.

function printLogFATAL() {
  local -r -a message=( "${@}" );
  local log_message="$( printLog "${LOG_LEVEL_FATAL}" "${message[@]}" )";
  if (( 0 == "${logging_state}" )); then
    printf '%s\n' "${log_message}";
  else
    :;
  fi
  return;
}
readonly -f printLogFATAL;

## >> global functions >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

## > body >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



## < include guard <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

## Prevent from including this file more than once.  Set include guard.

declare -r -i _LIBLOGGER_SH_=0;

## > include guard >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



## < tail <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

## << return <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

## Return from the included file.  The return status is 0 (success).

return "${?}";

## >> return >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

## > tail >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
