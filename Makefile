
################################################################################
################################################################################
##                                                                            ##
## This file is part of the RaSt git-gnu-project package.                     ##
##                                                                            ##
## RaSt git-gnu-project - create a local working directory with a local Git   ##
## repository and within this a local GNU project containing predefined       ##
## directories and standard readme files.                                     ##
##                                                                            ##
## Copyright (C)  2023  Ralf Stephan  <me@ralf-stephan.name>                  ##
##                                                                            ##
## GNU All-Permissive License: Copying and distribution of this file, with or ##
## without modification, are permitted in any medium without royalty provided ##
## the copyright notice and this notice are preserved.  This file is offered  ##
## as-is, without any warranty.                                               ##
##                                                                            ##
################################################################################
################################################################################
##                                                                            ##
## RaSt git-gnu-project Makefile file.                                        ##
##                                                                            ##
## This Makefile file serves the purpose to describes the relationships among ##
## files in your program, and provides commands for updating each file.       ##
##                                                                            ##
################################################################################
################################################################################



## From "6.14 Other Special Variables" https://www.gnu.org/software/make/manual/
## html_node/Special-Variables.html>

## .DEFAULT_GOAL
##
##   Sets the default goal to be used if no targets were specified on the
##   command line (see Arguments to Specify the Goals).  The .DEFAULT_GOAL
##   variable allows you to discover the current default goal, restart the
##   default goal selection algorithm by clearing its value, or to explicitly
##   set the default goal. The following example illustrates these cases:
##
##     # Query the default goal.
##     ifeq ($(.DEFAULT_GOAL),)
##       $(warning no default goal is set)
##     endif
##
##     .PHONY: foo
##     foo: ; @echo $@
##
##     $(warning default goal is $(.DEFAULT_GOAL))
##
##     # Reset the default goal.
##     .DEFAULT_GOAL :=
##
##     .PHONY: bar
##     bar: ; @echo $@
##
##     $(warning default goal is $(.DEFAULT_GOAL))
##
##     # Set our own.
##     .DEFAULT_GOAL := foo

.DEFAULT_GOAL = all

## .RECIPEPREFIX
##
##   The first character of the value of this variable is used as the character
##   make assumes is introducing a recipe line.  If the variable is empty (as it
##   is by default) that character is the standard tab character.  For example,
##   this is a valid makefile:
##
##     .RECIPEPREFIX = >
##     all:
##     > @echo Hello, world
##
##   The value of .RECIPEPREFIX can be changed multiple times; once set it stays
##   in effect for all rules parsed until it is modified.

.RECIPEPREFIX := $() $()



## From "16.5 Variables for Installation Directories" <https://www.gnu.org/
## software/make/manual/html_node/Directory-Variables.html>.

## These first two variables set the root for the installation.  All the other
## installation directories should be subdirectories of one of these two, and
## nothing should be directly installed into these two directories.

## prefix
##
##   A prefix used in constructing the default values of the variables listed
##   below.  The default value of prefix should be /usr/local.  When building
##   the complete GNU system, the prefix will be empty and /usr will be a
##   symbolic link to /.  (If you are using Autoconf, write it as '@prefix@'.)
##
##   Running 'make install' with a different value of prefix from the one used
##   to build the program should not recompile the program.

prefix = /usr/local

## exec_prefix
##
##   A prefix used in constructing the default values of some of the variables
##   listed below.  The default value of exec_prefix should be $(prefix).
##   (If you are using Autoconf, write it as '@exec_prefix@'.)
##
##   Generally, $(exec_prefix) is used for directories that contain
##   machine-specific files (such as executables and subroutine libraries),
##   while $(prefix) is used directly for other directories.
##
##   Running 'make install' with a different value of exec_prefix from the one
##   used to build the program should not recompile the program.

exec_prefix = ${prefix}

## Executable programs are installed in one of the following directories.

## bindir
##
##   The directory for installing executable programs that users can run.  This
##   should normally be /usr/local/bin, but write it as $(exec_prefix)/bin.
##   (If you are using Autoconf, write it as '@bindir@'.)

bindir = ${exec_prefix}/bin

## sbindir
##
##   The directory for installing executable programs that can be run from the
##   shell, but are only generally useful to system administrators.  This should
##   normally be /usr/local/sbin, but write it as $(exec_prefix)/sbin.
##   (If you are using Autoconf, write it as '@sbindir@'.)

sbindir = ${exec_prefix}/sbin

## libexecdir
##
##   The directory for installing executable programs to be run by other
##   programs rather than by users.  This directory should normally be
##   /usr/local/libexec, but write it as $(exec_prefix)/libexec.  (If you are
##   using Autoconf, write it as '@libexecdir@'.)
##
##   The definition of 'libexecdir' is the same for all packages, so you should
##   install your data in a subdirectory thereof.  Most packages install their
##   data under $(libexecdir)/package-name/, possibly within additional
##   subdirectories thereof, such as $(libexecdir)/package-name/machine/version.

libexecdir = ${exec_prefix}/libexec

## Data files used by the program during its execution are divided into
## categories in two ways.
##
## * Some files are normally modified by programs; others are never normally
##   modified (though users may edit some of these).
##
## * Some files are architecture-independent and can be shared by all machines
##   at a site; some are architecture-dependent and can be shared only by
##   machines of the same kind and operating system; others may never be shared
##   between two machines.
##
## This makes for six different possibilities.  However, we want to discourage
## the use of architecture-dependent files, aside from object files and
## libraries.  It is much cleaner to make other data files
## architecture-independent, and it is generally not hard.
##
## Here are the variables Makefiles should use to specify directories to put
## these various kinds of files in:

## datarootdir
##
##   The root of the directory tree for read-only architecture-independent data
##   files.  This should normally be /usr/local/share, but write it as
##   $(prefix)/share.  (If you are using Autoconf, write it as '@datarootdir@'.)
##   'datadir''s default value is based on this variable; so are 'infodir',
##   'mandir', and others.

datarootdir = ${prefix}/share

## datadir
##
##   The directory for installing idiosyncratic read-only
##   architecture-independent data files for this program.  This is usually the
##   same place as 'datarootdir', but we use the two separate variables so that
##   you can move these program-specific files without altering the location for
##   Info files, man pages, etc.
##
##   This should normally be /usr/local/share, but write it as $(datarootdir).
##   (If you are using Autoconf, write it as '@datadir@'.)
##
##   The definition of 'datadir' is the same for all packages, so you should
##   install your data in a subdirectory thereof.  Most packages install their
##   data under $(datadir)/package-name/.

datadir = ${datarootdir}

## sysconfdir
##
##   The directory for installing read-only data files that pertain to a single
##   machine–that is to say, files for configuring a host.  Mailer and network
##   configuration files, /etc/passwd, and so forth belong here.  All the files
##   in this directory should be ordinary ASCII text files.  This directory
##   should normally be /usr/local/etc, but write it as $(prefix)/etc.  (If you
##   are using Autoconf, write it as '@sysconfdir@'.)
##
##   Do not install executables here in this directory (they probably belong in
##   $(libexecdir) or $(sbindir)). Also do not install files that are modified
##   in the normal course of their use (programs whose purpose is to change the
##   configuration of the system excluded). Those probably belong in
##   $(localstatedir).

sysconfdir = ${prefix}/etc

## sharedstatedir
##
##   The directory for installing architecture-independent data files which the
##   programs modify while they run.  This should normally be /usr/local/com,
##   but write it as $(prefix)/com.  (If you are using Autoconf, write it as
##   '@sharedstatedir@'.)

sharedstatedir = ${prefix}/com

## localstatedir
##
##   The directory for installing data files which the programs modify while
##   they run, and that pertain to one specific machine.  Users should never
##   need to modify files in this directory to configure the package's
##   operation; put such configuration information in separate files that go in
##   $(datadir) or $(sysconfdir). $(localstatedir) should normally be
##   /usr/local/var, but write it as $(prefix)/var.  (If you are using Autoconf,
##   write it as '@localstatedir@'.)

localstatedir = ${prefix}/var

## runstatedir
##
##   The directory for installing data files which the programs modify while
##   they run, that pertain to one specific machine, and which need not persist
##   longer than the execution of the program-which is generally long-lived, for
##   example, until the next reboot.  PID files for system daemons are a typical
##   use.  In addition, this directory should not be cleaned except perhaps at
##   reboot, while the general /tmp (TMPDIR) may be cleaned arbitrarily.  This
##   should normally be /var/run, but write it as $(localstatedir)/run.  Having
##   it as a separate variable allows the use of /run if desired, for example.
##   (If you are using Autoconf 2.70 or later, write it as '@runstatedir@'.)

runstatedir = ${localstatedir}/run

## These variables specify the directory for installing certain specific types
## of files, if your program has them.  Every GNU package should have Info
## files, so every program needs 'infodir', but not all need 'libdir' or
## 'lispdir'.

## includedir
##
##   The directory for installing header files to be included by user programs
##   with the C '#include' preprocessor directive.  This should normally be
##   /usr/local/include, but write it as $(prefix)/include.  (If you are using
##   Autoconf, write it as '@includedir@'.)
##
##   Most compilers other than GCC do not look for header files in directory
##   /usr/local/include.  So installing the header files this way is only useful
##   with GCC.  Sometimes this is not a problem because some libraries are only
##   really intended to work with GCC.  But some libraries are intended to work
##   with other compilers.  They should install their header files in two
##   places, one specified by includedir and one specified by oldincludedir.

includedir = ${prefix}/include

## oldincludedir
##
##   The directory for installing '#include' header files for use with compilers
##   other than GCC.  This should normally be /usr/include.  (If you are using
##   Autoconf, you can write it as '@oldincludedir@'.)
##
##   The Makefile commands should check whether the value of oldincludedir is
##   empty.  If it is, they should not try to use it; they should cancel the
##   second installation of the header files.
##
##   A package should not replace an existing header in this directory unless
##   the header came from the same package.  Thus, if your Foo package provides
##   a header file foo.h, then it should install the header file in the
##   oldincludedir directory if either (1) there is no foo.h there or (2) the
##   foo.h that exists came from the Foo package.
##
##   To tell whether foo.h came from the Foo package, put a magic string in the
##   file-part of a comment-and grep for that string.

oldincludedir = /usr/include

## docdir
##
##   The directory for installing documentation files (other than Info) for this
##   package.  By default, it should be /usr/local/share/doc/yourpkg, but it
##   should be written as $(datarootdir)/doc/yourpkg.  (If you are using
##   Autoconf, write it as '@docdir@'.)  The yourpkg subdirectory, which may
##   include a version number, prevents collisions among files with common
##   names, such as README.

docdir = ${datarootdir}/doc/${package_name}

## infodir
##
##   The directory for installing the Info files for this package.  By default,
##   it should be /usr/local/share/info, but it should be written as
##   $(datarootdir)/info.  (If you are using Autoconf, write it as '@infodir@'.)
##   infodir is separate from docdir for compatibility with existing practice.

infodir = ${datarootdir}/info

## htmldir
##
##   Directories for installing documentation files in the particular format.
##   They should all be set to $(docdir) by default.  (If you are using
##   Autoconf, write them as '@htmldir@', '@dvidir@', etc.)  Packages which
##   supply several translations of their documentation should install them in
##   '$(htmldir)/'ll, '$(pdfdir)/'ll, etc. where ll is a locale abbreviation
##   such as 'en' or 'pt_BR'.

htmldir = ${docdir}

## dvidir
##
##   See htmldir.

dvidir = ${docdir}

## dvidir
##
##   See htmldir.

pdfdir = ${docdir}

## dvidir
##
##   See htmldir.

psdir = ${docdir}

## libdir
##
##   The directory for object files and libraries of object code.  Do not
##   install executables here, they probably ought to go in $(libexecdir)
##   instead.  The value of libdir should normally be /usr/local/lib, but write
##   it as $(exec_prefix)/lib.  (If you are using Autoconf, write it as
##   '@libdir@'.)

libdir = ${exec_prefix}/lib

## lispdir
##
##   The directory for installing any Emacs Lisp files in this package.  By
##   default, it should be /usr/local/share/emacs/site-lisp, but it should be
##   written as $(datarootdir)/emacs/site-lisp.
##
##   If you are using Autoconf, write the default as '@lispdir@'.  In order to
##   make '@lispdir@' work, you need the following lines in your configure.ac
##   file:
##
##     lispdir='${datarootdir}/emacs/site-lisp'
##     AC_SUBST(lispdir)

lispdir = ${datarootdir}/emacs/site-lisp

## localedir
##
##   The directory for installing locale-specific message catalogs for this
##   package.  By default, it should be /usr/local/share/locale, but it should
##   be written as $(datarootdir)/locale.  (If you are using Autoconf, write it
##   as '@localedir@'.) This directory usually has a subdirectory per locale.

localedir = ${datarootdir}/locale

## Unix-style man pages are installed in one of the following:

## mandir
##
##   The top-level directory for installing the man pages (if any) for this
##   package.  It will normally be /usr/local/share/man, but you should write it
##   as $(datarootdir)/man.  (If you are using Autoconf, write it as
##   '@mandir@'.)
##
##   Don't make the primary documentation for any GNU software be a man page.
##   Write a manual in Texinfo instead.  Man pages are just for the sake of
##   people running GNU software on Unix, which is a secondary application only.

mandir = ${datarootdir}/man

## man1dir
##
## The directory for installing section 1 man pages.  Write it as
## $(mandir)/man1.

man1dir = ${mandir}/man1

## man2dir
##
## The directory for installing section 2 man pages.  Write it as
## $(mandir)/man2.

man2dir = ${mandir}/man2

## man3dir
##
## The directory for installing section 3 man pages.  Write it as
## $(mandir)/man3.

man3dir = ${mandir}/man3

## man4dir
##
## The directory for installing section 4 man pages.  Write it as
## $(mandir)/man4.

man4dir = ${mandir}/man4

## man5dir
##
## The directory for installing section 5 man pages.  Write it as
## $(mandir)/man5.

man5dir = ${mandir}/man5

## man6dir
##
## The directory for installing section 6 man pages.  Write it as
## $(mandir)/man6.

man6dir = ${mandir}/man6

## man7dir
##
## The directory for installing section 7 man pages.  Write it as
## $(mandir)/man7.

man7dir = ${mandir}/man7

## man8dir
##
## The directory for installing section 8 man pages.  Write it as
## $(mandir)/man8.

man8dir = ${mandir}/man8

## man9dir
##
## The directory for installing section 9 man pages.  Write it as
## $(mandir)/man9.

man9dir = ${mandir}/man9

## manext
##
##   The file name extension for the installed man page.  This should contain a
##   period followed by the appropriate digit; it should normally be '.1'.

manext = 1

## man1ext
##
##   The file name extension for installed section 1 man pages.

man1ext = 1

## man2ext
##
##   The file name extension for installed section 2 man pages.

man2ext = 2

## man3ext
##
##   The file name extension for installed section 3 man pages.

man4ext = 3

## man1ext
##
##   The file name extension for installed section 4 man pages.

man4ext = 4

## man5ext
##
##   The file name extension for installed section 5 man pages.

man5ext = 5

## man6ext
##
##   The file name extension for installed section 6 man pages.

man6ext = 6

## man7ext
##
##   The file name extension for installed section 7 man pages.

man7ext = 7

## man8ext
##
##   The file name extension for installed section 8 man pages.

man8ext = 8

## man9ext
##
##   The file name extension for installed section 9 man pages.

man9ext = 9

## And finally, you should set the following variable:

## srcdir
##
##   The directory for the sources being compiled.  The value of this variable
##   is normally inserted by the configure shell script.  (If you are using
##   Autoconf, use 'srcdir = @srcdir@'.)

srcdir = $(dir $(abspath $(lastword $(MAKEFILE_LIST))))



## From "9.2 Arguments to Specify the Goals" <https://www.gnu.org/software/make/
## manual/html_node/Goals.html>.

## all
##
##   Make all the top-level targets the makefile knows about.

all:
  @echo "Target 'all': This target has not yet been implemented.";

## clean
##
##   Delete all files that are normally created by running make.

clean:
## Remove Notepad++ backup files and directories.
  find "${srcdir}" -depth -path '*/nppBackup/*' -type f -exec rm --verbose "{}" \;
  find "${srcdir}" -depth -path '*/nppBackup' -type d -exec rmdir --verbose "{}" \;
## Remove Dodygen generated files.
  find "${srcdir}" -depth -path "*${srcdir}doc/docbook/*" -type f -exec rm --verbose "{}" \;
  find "${srcdir}" -depth -path "*${srcdir}doc/docbook" -type d -exec rmdir --verbose "{}" \;
  find "${srcdir}" -depth -path "*${srcdir}doc/html/search/*" -type f -exec rm --verbose "{}" \;
  find "${srcdir}" -depth -path "*${srcdir}doc/html/search" -type d -exec rmdir --verbose "{}" \;
  find "${srcdir}" -depth -path "*${srcdir}doc/html/*" -type f -exec rm --verbose "{}" \;
  find "${srcdir}" -depth -path "*${srcdir}doc/html" -type d -exec rmdir --verbose "{}" \;
  find "${srcdir}" -depth -path "*${srcdir}doc/latex/*" -type f -exec rm --verbose "{}" \;
  find "${srcdir}" -depth -path "*${srcdir}doc/latex" -type d -exec rmdir --verbose "{}" \;
  find "${srcdir}" -depth -path "*${srcdir}doc/man/man3/*" -type f -exec rm --verbose "{}" \;
  find "${srcdir}" -depth -path "*${srcdir}doc/man/man3" -type d -exec rmdir --verbose "{}" \;
  find "${srcdir}" -depth -path "*${srcdir}doc/man/*" -type f -exec rm --verbose "{}" \;
  find "${srcdir}" -depth -path "*${srcdir}doc/man" -type d -exec rmdir --verbose "{}" \;
  find "${srcdir}" -depth -path "*${srcdir}doc/rtf/*" -type f -exec rm --verbose "{}" \;
  find "${srcdir}" -depth -path "*${srcdir}doc/rtf" -type d -exec rmdir --verbose "{}" \;
  find "${srcdir}" -depth -path "*${srcdir}doc/xml/*" -type f -exec rm --verbose "{}" \;
  find "${srcdir}" -depth -path "*${srcdir}doc/xml" -type d -exec rmdir --verbose "{}" \;

## mostlyclean
##
##   Like 'clean', but may refrain from deleting a few files that people
##   normally don't want to recompile.  For example, the 'mostlyclean' target
##   for GCC does not delete libgcc.a, because recompiling it is rarely
##   necessary and takes a lot of time.

mostlyclean:
  @echo "Target 'mostlyclean': This target has not yet been implemented.";

## distclean
##
##   Any of these targets (distclean, realclean and clobber) might be defined to
##   delete more files than 'clean' does.  For example, this would delete
##   configuration files or links that you would normally create as preparation
##   for compilation, even if the makefile itself cannot create these files.

distclean:
  @echo "Target 'distclean': This target has not yet been implemented.";

## realclean
##
##   See distclean.

realclean:
  @echo "Target 'realclean': This target has not yet been implemented.";

## clobber
##
##   See distclean.

clobber:
  @echo "Target 'clobber': This target has not yet been implemented.";

## install
##
##   Copy the executable file into a directory that users typically search for
##   commands; copy any auxiliary files that the executable uses into the
##   directories where it will look for them.

install:
  @echo "Target 'install': This target has not yet been implemented.";

## print
##
##   Print listings of the source files that have changed.

print:
  @echo "Target 'print': This target has not yet been implemented.";

## tar
##
##   Create a tar file of the source files.

tar:
  @echo "Target 'tar': This target has not yet been implemented.";

## shar
##
##   Create a shell archive (shar file) of the source files.

shar:
  @echo "Target 'shar': This target has not yet been implemented.";

## dist
##
##   Create a distribution file of the source files.  This might be a tar file,
##   or a shar file, or a compressed version of one of the above, or even more
##   than one of the above.

dist:
  @echo "Target 'dist': This target has not yet been implemented.";

## TAGS
##
##   Update a tags table for this program.

TAGS:
  @echo "Target 'TAGS': This target has not yet been implemented.";

## check
##
##   Perform self tests on the program this makefile builds.

check:
  @echo "Target 'check': This target has not yet been implemented.";

## test
##
##   See check.

test:
  @echo "Target 'test': This target has not yet been implemented.";
