AC_PREREQ([2.59])
AC_INIT([gnomemm-website], [2.91.4],
        [http://bugzilla.gnome.org/enter_bug.cgi?product=gtkmm],
        [gnomemm-website], [http://www.gtkmm.org/])

AC_CONFIG_SRCDIR([docs/C/index.docbook])
AC_CONFIG_AUX_DIR([build])
AC_CONFIG_MACRO_DIR([build])

AM_INIT_AUTOMAKE([1.9 -Wno-portability dist-bzip2 no-define nostdinc tar-ustar foreign])
m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES])
AM_MAINTAINER_MODE
AC_ARG_VAR([ACLOCAL_FLAGS], [aclocal flags, e.g. -I <macro dir>])

AC_LANG([C++])

YELP_HELP_INIT

AC_CONFIG_FILES([Makefile
                 docs/Makefile])
AC_OUTPUT
