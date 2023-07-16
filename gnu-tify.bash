#! /usr/bin/env -S bash -e
################################################################################
##
## This file is part of the RaSt git-gnu-project.bash package.
##
## RaSt git-gnu-project.bash is to  manage a directory as a Git  and a GNU style
## project using Bash.
##
## Copyright (C)  2023  Ralf Stephan  <me@ralf-stephan.name>
##
## RaSt git-gnu-project.bash  is free software:  you can redistribute  it and/or
## modify it under the  terms of the GNU General Public  License as published by
## the Free  Software Foundation, either version  3 of the License,  or (at your
## option) any later version.
##
## RaSt git-gnu-project.bash is distributed in the  hope that it will be useful,
## but   WITHOUT  ANY   WARRANTY;   without  even   the   implied  warranty   of
## MERCHANTABILITY or  FITNESS FOR  A PARTICULAR PURPOSE.   See the  GNU General
## Public License for more details.
##
## You should have received a copy of  the GNU General Public License along with
## this package.  If not, see <https://www.gnu.org/licenses/>.
##
################################################################################



################################################################################
##
## $Version: 0.6.0 (2023-07-16 07:35:21 +00:00:00) $
##
################################################################################



################################################################################
##
## GNU-TIFY.BASH - 1 - 2023-06-12 - RaSt - RaSt git-gnu-project.bash Manual
##
## NAME
##
##   gnu-tify.bash - manage directory as GNU style project
##
## SYNOPSIS
##
##   gnu-tify.bash [--working-directory=<working directory>]
##                 [--empty-readme-files]
##                 [--readme-file=<readme file>]
##                 [--type=<type>]
##                 [--empty-common-tree]
##                 [--common-tree=<common tree item>]
##                 [--empty-program-tree]
##                 [--program-tree=<program tree item>]
##                 [--empty-library-tree]
##                 [--library-tree=<library tree item>]
##                 [--empty-document-tree]
##                 [--document-tree=<document tree item>]
##                 [--empty-package-tree]
##                 [--package-tree=<package tree item>]
##                 [--legal-notice=<legal notice>]
##                 [--empty-license-file]
##                 [--license-file=<license file>]
##                 [--help]
##                 [--version]
##
## DESCRIPTION
##
##   RaSt gnu-tify.bash is  a Bash script to  manage a directory as  a GNU style
##   project.
##
##   The directory then contains a GNU  style project tree for program, library,
##   documentation or package projects.
##
##   The  Git working  directory  is  for example  </home/john_dow/repositories/
##   foobar/>.
##
##   The Git  repository directory is for  example </home/john_dow/repositories/
##   foobar/.git/>.
##
##   This script does:
##
##   Step 1: Asking the  user for confirmation  before creating the  Git working
##           directory.
##   Step 2: Create the GNU standard readme files.
##   Step 3: Create  the  project  tree   (for  program,  library,  document  or
##           package).
##   Step 4: Copy licenses files.
##   Step 5: Cleanup and optimize the Git repository.
##
## OPTIONS
##
##   --working-directory         - set Git working directory
##   --empty-readme-files        - set  GNU standard  readme  files  list to  an
##                                 empty list, use this before --readme-file
##   --readme-file               - add GNU standard readme  file to GNU standard
##                                 readme   files    list,   use    this   after
##                                 --empty-readme-files
##   --type                      - set project type
##   --empty-common-tree         - set GNU  common tree  list to an  empty list,
##                                 use this before --common-tree
##   --common-tree               - add GNU  common tree item to  GNU common tree
##                                 list, use this after --empty-common-tree
##   --empty-program-tree        - set GNU  program tree  list to an  empty list,
##                                 use this before --program-tree
##   --program-tree              - add GNU program tree item to GNU program tree
##                                 list, use this after --empty-program-tree
##   --empty-library-tree        - set GNU  library tree list to  an empty list,
##                                 use this before --library-tree
##   --library-tree              - add GNU library tree item to GNU library tree
##                                 list, use this after --empty-library-tree
##   --empty-document-tree       - set GNU document tree  list to an empty list,
##                                 use this before --document-tree
##   --document-tree             - add GNU  document tree  item to  GNU document
##                                 tree      list,      use      this      after
##                                 --empty-document-tree
##   --empty-package-tree        - set GNU  package tree list to  an empty list,
##                                 use this before --readme-file
##   --package-tree              - add GNU package tree item to GNU package tree
##                                 list, use this after --empty-package-tree
##   --legal-notice              - set the legal notice
##   --empty-license-file        - set license  file list to an  empty list, use
##                                 this before --empty-package-tree
##   --license-file              - add license  file to license files  list, use
##                                 this after --empty-license-file
##   --help                      - print help
##   --version                   - print version
##
##   Allowed values for  project type:
##
##     program  | prg
##     library  | lib
##     document | doc
##     package  | pkg
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
##   gnu-tify.bash --working-directory='/home/john_dow/repositories/foobar/' \
##                 --empty-readme-files \
##                 --readme-file='AUTHORS' \
##                 --readme-file='BACKLOG' \
##                 --readme-file='BUGS' \
##                 --readme-file='CHANGELOG' \
##                 --readme-file='CONTRIBUTING' \
##                 --readme-file='COPYING' \
##                 --readme-file='FAQ' \
##                 --readme-file='HACKING' \
##                 --readme-file='INSTALL' \
##                 --readme-file='NEWS' \
##                 --readme-file='README' \
##                 --readme-file='THANKS' \
##                 --readme-file='TODO' \
##                 --type='pkg' \
##                 --empty-common-tree \
##                 --common-tree='.gitkeep' \
##                 --empty-program-tree \
##                 --program-tree='Makefile.am' \
##                 --program-tree='build/.gitkeep' \
##                 --program-tree='configure.ac' \
##                 --program-tree='data/.gitkeep' \
##                 --program-tree='docs/.gitkeep' \
##                 --program-tree='examples/.gitkeep' \
##                 --program-tree='external/.gitkeep' \
##                 --program-tree='extras/.gitkeep' \
##                 --program-tree='include/.gitkeep' \
##                 --program-tree='libs/.gitkeep' \
##                 --program-tree='src/.gitkeep' \
##                 --program-tree='src/Makefile.am' \
##                 --program-tree='src/main.c' \
##                 --program-tree='src/main.h' \
##                 --program-tree='tests/.gitkeep' \
##                 --program-tree='tools/.gitkeep' \
##                 --empty-library-tree \
##                 --library-tree='Makefile.am' \
##                 --library-tree='build/.gitkeep' \
##                 --library-tree='configure.ac' \
##                 --library-tree='data/.gitkeep' \
##                 --library-tree='docs/.gitkeep' \
##                 --library-tree='examples/.gitkeep' \
##                 --library-tree='external/.gitkeep' \
##                 --library-tree='extras/.gitkeep' \
##                 --library-tree='include/.gitkeep' \
##                 --library-tree='libs/.gitkeep' \
##                 --library-tree='src/.gitkeep' \
##                 --library-tree='src/Makefile.am' \
##                 --library-tree='src/libmain.c' \
##                 --library-tree='src/libmain.h' \
##                 --library-tree='tests/.gitkeep' \
##                 --library-tree='tools/.gitkeep' \
##                 --empty-document-tree \
##                 --document-tree='Makefile.am' \
##                 --document-tree='build/.gitkeep' \
##                 --document-tree='configure.ac' \
##                 --document-tree='data/.gitkeep' \
##                 --document-tree='doc/Makefile.am' \
##                 --document-tree='doc/main.ltx' \
##                 --document-tree='docs/.gitkeep' \
##                 --document-tree='examples/.gitkeep' \
##                 --document-tree='external/.gitkeep' \
##                 --document-tree='extras/.gitkeep' \
##                 --document-tree='include/.gitkeep' \
##                 --document-tree='libs/.gitkeep' \
##                 --document-tree='src/.gitkeep' \
##                 --document-tree='tests/.gitkeep' \
##                 --document-tree='tools/.gitkeep' \
##                 --empty-package-tree \
##                 --package-tree='Makefile.am' \
##                 --package-tree='build/.gitkeep' \
##                 --package-tree='configure.ac' \
##                 --package-tree='data/.gitkeep' \
##                 --package-tree='doc/Makefile.am' \
##                 --package-tree='doc/main.ltx' \
##                 --package-tree='docs/.gitkeep' \
##                 --package-tree='examples/.gitkeep' \
##                 --package-tree='external/.gitkeep' \
##                 --package-tree='extras/.gitkeep' \
##                 --package-tree='include/.gitkeep' \
##                 --package-tree='libs/.gitkeep' \
##                 --package-tree='src/.gitkeep' \
##                 --package-tree='src/Makefile.am' \
##                 --package-tree='src/libmain.c' \
##                 --package-tree='src/libmain.h' \
##                 --package-tree='src/main.c' \
##                 --package-tree='src/main.h' \
##                 --package-tree='tests/.gitkeep' \
##                 --package-tree='tools/.gitkeep' \
##                 --legal-notice=="## This file is part of JD foobar package.
##                 ##
##                 ## JD foobar is ...
##                 ##
##                 ## Copyright (C)  2023  John Dow  <john_dow@example.com>
##                 ##
##                 ## GNU All-Permissive  License: Copying and  distribution of this file,  with or
##                 ## without modification,  are permitted in  any medium without  royalty provided
##                 ## the copyright  notice and this  notice are  preserved.  This file  is offered
##                 ## as-is, without any warranty." \
##                --empty-license-file \
##                --license-file='COPYING.DOC;/home/john_dow/licenses/licenses/gnu_fdl-1.3.txt' \
##                --license-file='COPYING.PRG;/home/john_dow/licenses/licenses/gnu_gpl-3.0.txt' \
##                --license-file='COPYING.LIB;/home/john_dow/licenses/licenses/gnu_lgpl-3.0.txt' \
##                --license-file='COPYING;/home/john_dow/licenses/licenses/gnu_gpl-3.0.txt'
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
## GLOBAL FUNCTONS
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

  read -p "Create project tree in '${dirname}/${basename}/'? (y/n): " 'confirmation';
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
      echo "Error: unknown confirmation '${confirmation}'.";
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



## @brief Create GNU standard readme files.
## @details Create GNU standard readme files.
##   If there  is a Git  repository in the working  directory, add files  to the
##   repository.
## @param[in] legal_notice
##   The copyright and license notice.
## @param[in] readme_files
##   The readme files.
## @return
##   The exit code of the last command.

function createReadmeFiles()
{
  # The Legal notice.

  local -a legal_notice="${1}"; shift;

  # The GNU standard readme files.

  local -a readme_files=( "${@}" );

  # Create the files.

  local readme_file='';
  for readme_file in "${readme_files[@]}"; do
    echo "
${legal_notice}" > "./${readme_file}";
    if [[ 'true' == "$( git rev-parse --is-inside-work-tree 2> /dev/null )" ]]; then
      git add "./${readme_file}";
      git commit --message="$( echo "Add file." | fold --spaces --width='50' )

$( echo "* ${readme_file}: add file." | fold --spaces --width='72' )";
    else
      # do nothing
      :;
    fi
  done

  # Return from the function.

  return;
}



## @brief Create project tree directories and files.
## @details Create project tree directories and files.
## @param[in] project_tree
##   The project tree directories and files.
## @return
##   The exit code of the last command.

function createProjectTree()
{
  # The project tree.

  local -a project_tree=( "${@}" );

  # Create the directories and files.

  local project_item='';
  for project_item in "${project_tree[@]}"; do
    mkdir -p "$( dirname "./${project_item}" )";
    echo "
${legal_notice}" > "./${project_item}";
    if [[ 'true' == "$( git rev-parse --is-inside-work-tree 2> /dev/null )" ]]; then
      git add "./${project_item}";
      git commit --message="$( echo "Add file." | fold --spaces --width='50' )

$( echo "* ${project_item}: add file." | fold --spaces --width='72' )";
    else
      # do nothing
      :;
    fi
  done

  # Return from the function.

  return;
}



## @brief Copy license files.
## @details Copy license files.
##   1. See  that the  Git  remote contains  a  key.  A  remote  has the  format
##      'key;value'.
##   2. See that the key has a value.
##   3. Set Git remote.
## @param[in] license_files
##   The license files.
## @return
##   The exit code of the last command.

function copyLicenseFiles()
{
  # The license files.

  local -a license_files=( "${@}" );

  # See if the keys of the license files are not empty.

  local index=0;

  local -a key_value=();
  local key='';
  local value='';

  for (( index=0; index<"${#license_files[@]}"; index++ )); do
    # Split the files into the key and the value.

    key_value=();
    key='';
    value='';
    IFS=';' read -a 'key_value' -r <<< "${license_files[${index}]}";
    key="${key_value[0]}";
    value="${key_value[1]}";# See that the key is not empty.

    if [[ -n "${key}" ]]; then
      # do nothing
      :;
    else
      echo "Error: variable 'license_files' has empty key (${value}).";
      exit 1;
    fi

    # See the key has a value.

    if [[ -n "${value}" ]]; then
      # do nothing
      :;
    else
      echo "Error: variable 'license_files' key (${key}) has empty value.";
      exit 1;
    fi

    # Copy the license files.

    cat "${value}" > "./${key}";
    if [[ 'true' == "$( git rev-parse --is-inside-work-tree 2> /dev/null )" ]]; then
      git add "./${key}";
      git commit --message="$( echo "Add file." | fold --spaces --width='50' )

$( echo "* ${key}: add file." | fold --spaces --width='72' )";
    else
      # do nothing
      :;
    fi
  done

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

  # The Version of this script.

  local version="$( cat << 'END'
gnu-tify.bash (RaSt git-gnu-project.bash)
0.6.0 (2023-07-16 07:35:21 +00:00:00)
Copyright (C)  2023  Ralf Stephan  <me@ralf-stephan.name>
License GPLv3+ (GNU GPL version 3 or later,
see <https://gnu.org/licenses/gpl.html>)
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
END
)";

  # The usage of the script

  local usage=" cat << 'END'
SYNOPSIS

  gnu-tify.bash [--working-directory=<working directory>]
                [--empty-readme-files]
                [--readme-file=<readme file>]
                [--type=<type>]
                [--empty-common-tree]
                [--common-tree=<common tree item>]
                [--empty-program-tree]
                [--program-tree=<program tree item>]
                [--empty-library-tree]
                [--library-tree=<library tree item>]
                [--empty-document-tree]
                [--document-tree=<document tree item>]
                [--empty-package-tree]
                [--package-tree=<package tree item>]
                [--legal-notice=<legal notice>]
                [--empty-license-file]
                [--license-file=<license file>]
                [--help]
                [--version]

OPTIONS

  --working-directory         - set Git working directory
  --empty-readme-files        - set  GNU standard  readme  files  list to  an
                                empty list, use this before --readme-file
  --readme-file               - add GNU standard readme  file to GNU standard
                                readme   files    list,   use    this   after
                                --empty-readme-files
  --type                      - set project type
  --empty-common-tree         - set GNU  common tree  list to an  empty list,
                                use this before --common-tree
  --common-tree               - add GNU  common tree item to  GNU common tree
                                list, use this after --empty-common-tree
  --empty-program-tree        - set GNU  program tree  list to an  empty list,
                                use this before --program-tree
  --program-tree              - add GNU program tree item to GNU program tree
                                list, use this after --empty-program-tree
  --empty-library-tree        - set GNU  library tree list to  an empty list,
                                use this before --library-tree
  --library-tree              - add GNU library tree item to GNU library tree
                                list, use this after --empty-library-tree
  --empty-document-tree       - set GNU document tree  list to an empty list,
                                use this before --document-tree
  --document-tree             - add GNU  document tree  item to  GNU document
                                tree      list,      use      this      after
                                --empty-document-tree
  --empty-package-tree        - set GNU  package tree list to  an empty list,
                                use this before --readme-file
  --package-tree              - add GNU package tree item to GNU package tree
                                list, use this after --empty-package-tree
  --legal-notice              - set the legal notice
  --empty-license-file        - set license  file list to an  empty list, use
                                this before --empty-package-tree
  --license-file              - add license  file to license files  list, use
                                this after --empty-license-file
  --help                      - print help
  --version                   - print version

  Allowed values for  project type:

    program  | prg
    library  | lib
    document | doc
    package  | pkg

Report bugs to:
Package home page:
General help using RaSt software:

  https://github.com/RaStBh/
  https://gitlab.com/RaStBh/
END
";

  # The Git working directory.

  local working_directory='';

  # GNU standard readme files.

  local -a readme_files=();

  # The package type.

  local type='';

  # Package project tree - common files and directories.

  local -a common_tree=();

  # Package project tree - files and directories for program projects.

  local -a pogram_tree=();

  # Package project tree - files and directories for library projects.

  local -a library_tree=();

  # Package project tree - files and directories for document projects.

  local -a document_tree=();

  # Package project tree - files and directories for package projects.

  local -a package_tree=();

  # The Legal notice.

  local legal_notice='';

  # Files containing licenses texts.

  local -a license_files=();

  # Get the command line arguments.

  local short_options='';
  local long_options='';

  long_options+='working-directory:,';
  long_options+='empty-readme-files,';
  long_options+='readme-file:,';
  long_options+='type:,';
  long_options+='empty-common-tree,';
  long_options+='common-tree:,';
  long_options+='empty-program-tree,';
  long_options+='program-tree:,';
  long_options+='empty-library-tree,';
  long_options+='library-tree:,';
  long_options+='empty-document-tree,';
  long_options+='document-tree:,';
  long_options+='empty-package-tree,';
  long_options+='package-tree:,';
  long_options+='legal-notice:,';
  long_options+='empty-license-file,';
  long_options+='license-file:,';
  long_options+='help,';
  long_options+='version,';

  eval arguments=( "$( getopt --alternative \
                              --options "${short_options}" \
                              --longoptions "${long_options}" \
                              --shell 'bash' \
                              -- \
                              "${@}" )" );

  local option_name='';
  local option_argument='';
  local -i previous_position=0;
  local -i current_position=0;
  local -i next_position=0;

  while true; do
    option_name="${arguments[$(( "${current_position}" + 0 ))]}";
    option_argument="${arguments[$(( "${current_position}" + 1 ))]}";
    next_position="$(( "${next_position}" + 1 ))";
    case "${option_name}" in

      '--working-directory' )
        working_directory="${option_argument}";
        next_position="$(( "${next_position}" + 1 ))";
        ;;

      '--empty-readme-files' )
        local_options=();
        next_position="$(( "${next_position}" + 0 ))";
        ;;

      '--readme-file' )
        readme_files["${#readme_files[@]}"]="${option_argument}";
        next_position="$(( "${next_position}" + 1 ))";
        ;;

      '--type' )
        type="${option_argument}";
        next_position="$(( "${next_position}" + 1 ))";
        ;;

      '--empty-common-tree' )
        local_options=();
        next_position="$(( "${next_position}" + 0 ))";
        ;;

      '--common-tree' )
        common_tree["${#common_tree[@]}"]="${option_argument}";
        next_position="$(( "${next_position}" + 1 ))";
        ;;

      '--empty-program-tree' )
        local_options=();
        next_position="$(( "${next_position}" + 0 ))";
        ;;

      '--program-tree' )
        program_tree["${#program_tree[@]}"]="${option_argument}";
        next_position="$(( "${next_position}" + 1 ))";
        ;;

      '--empty-library-tree' )
        local_options=();
        next_position="$(( "${next_position}" + 0 ))";
        ;;

      '--library-tree' )
        library_tree["${#library_tree[@]}"]="${option_argument}";
        next_position="$(( "${next_position}" + 1 ))";
        ;;

      '--empty-document-tree' )
        local_options=();
        next_position="$(( "${next_position}" + 0 ))";
        ;;

      '--document-tree' )
        document_tree["${#document_tree[@]}"]="${option_argument}";
        next_position="$(( "${next_position}" + 1 ))";
        ;;

      '--empty-package-tree' )
        local_options=();
        next_position="$(( "${next_position}" + 0 ))";
        ;;

      '--package-tree' )
        package_tree["${#package_tree[@]}"]="${option_argument}";
        next_position="$(( "${next_position}" + 1 ))";
        ;;

      '--legal-notice' )
        legal_notice="${option_argument}";
        next_position="$(( "${next_position}" + 1 ))";
        ;;

      '--empty-license-file' )
        license_files=();
        next_position="$(( "${next_position}" + 0 ))";
        ;;

      '--license-file' )
        license_files["${#license_files[@]}"]="${option_argument}";
        next_position="$(( "${next_position}" + 1 ))";
        ;;

      '--help' )
        echo "${usage}";
        exit 0;
        ;;

      '--version' )
        echo "${version}";
        exit 0;
        ;;

      '--' )
        break;
        ;;

      *)
        echo "Error: unknown option name '${option_name}'."
        echo '';
        echo "${usage}";
        exit 1;
        ;;

    esac
    previous_position="${current_position}";
    current_position="${next_position}";
  done

  # Get the variables from the configuration file if the file it is present.

  if [[ -f './config.inc.bash' ]]; then
    echo "Info: configuration file './config.inc.bash' present.";
    echo "Info: loading configuraton file './config.inc.bash'.";
    source './config.inc.bash';
  else
    echo "Info: configuration file './config.inc.bash' not present.";
    echo "Info: not loading configuration file './config.inc.bash'.";
  fi

  # See if the variables are set and not empty.

  if [[ -n "${working_directory}" ]]; then
    echo "Info: variable 'working_directory' (${working_directory}) present.";
  else
    echo "Error: variable 'working_directory' not present.";
    exit 1;
  fi
  if (( 0 < "${#readme_files[@]}" )); then
    echo "Info: variable 'readme_files' (${#readme_files[@]}) (${readme_files[@]}) present.";
  else
    echo "Error: variable 'readme_files' not present.";
    exit 1;
  fi
  if [[ -n "${type}" ]]; then
    echo "Info: variable 'type' (${type}) present.";
  else
    echo "Error: variable 'type' not present.";
    exit 1;
  fi
  if (( 0 <= "${#common_tree[@]}" )); then
    echo "Info: variable 'common_tree' (${#common_tree[@]}) (${common_tree[@]}) present.";
  else
    echo "Error: variable 'common_tree' not present.";
    exit 1;
  fi
  if (( 0 < "${#pogram_tree[@]}" )); then
    echo "Info: variable 'pogram_tree' (${#pogram_tree[@]}) (${pogram_tree[@]}) present.";
  else
    echo "Error: variable 'pogram_tree' not present.";
    exit 1;
  fi
  if (( 0 < "${#library_tree[@]}" )); then
    echo "Info: variable 'library_tree' (${#library_tree[@]}) (${library_tree[@]}) present.";
  else
    echo "Error: variable 'library_tree' not present.";
    exit 1;
  fi
  if (( 0 < "${#document_tree[@]}" )); then
    echo "Info: variable 'document_tree' (${#document_tree[@]}) (${document_tree[@]}) present.";
  else
    echo "Error: variable 'document_tree' not present.";
    exit 1;
  fi
  if (( 0 < "${#package_tree[@]}" )); then
    echo "Info: variable 'package_tree' (${#package_tree[@]}) (${package_tree[@]}) present.";
  else
    echo "Error: variable 'package_tree' not present.";
    exit 1;
  fi
  if (( 0 < "${#license_files[@]}" )); then
    echo "Info: variable 'license_files' (${#license_files[@]}) (${license_files[@]}) present.";
  else
    echo "Error: variable 'license_files' not present.";
    exit 1;
  fi
  if [[ -n "${legal_notice}" ]]; then
    echo "Info: variable 'legal_notice' (${legal_notice}) present.";
  else
    echo "Error: variable 'legal_notice' not present.";
    exit 1;
  fi

  # See if we have a GNU working directory.

  local dirname="$( dirname "${working_directory}" )";
  local basename="$( basename "${working_directory}" )";
  testDirectory "${dirname}" "${basename}";
  working_directory="${dirname}/${basename}/";

  # Ask the user for confirmation before creating the Git working directory.

  askConfirmation;

  # Change the Bash working directory to the Git working directory.

  echo "Info: changing directory to '${working_directory}' ...";
  cd "${working_directory}";
  echo '... done';

  # Create the GNU standard readme files.

  echo "Info: creating readme files in '${working_directory}' ...";
  createReadmeFiles "${legal_notice}" "${readme_files[@]}";
  echo '... done';

  # Create the project tree.

  echo "Info: creating GNU project in '${working_directory}' ...";
  local -a project_tree=();
  type="${type,,}";
  if      [[ 'prg' == "${type}" ]] \
       || [[ 'program' == "${type}" ]]; then
    project_tree=( "${common_tree[@]}" "${pogram_tree[@]}" );
  elif    [[ 'lib' == "${type}" ]] \
       || [[ 'library' == "${type}" ]]; then
    project_tree=( "${common_tree[@]}" "${library_tree[@]}" );
  elif    [[ 'doc' == "${type}" ]] \
       || [[ 'document' == "${type}" ]]; then
    project_tree=( "${common_tree[@]}" "${document_tree[@]}" );
  elif [[ 'pkg' == "${type}" ]] \
       || [[ 'package' == "${type}" ]]; then
    project_tree=( "${common_tree[@]}" "${package_tree[@]}" );
  else
    echo "Error: unknown package type '${type}'.";
    exit 1;
  fi
  createProjectTree "${project_tree[@]}";
  echo '... done';

  # Copy licenses files.

  echo "Info: copying licenses files to '${working_directory}' ...";
  copyLicenseFiles "${license_files[@]}";
  echo '... done';

  # Cleanup and optimize the Git repository.

  echo "Info: cleaning and optimizing Git repository in '${working_directory}' ...";
  runHousekeeping;
  echo '... done';

  # Return from the function.

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
