#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.63])
AC_INIT([pompeius], [1.0])
AC_CONFIG_AUX_DIR([build])
AC_CONFIG_MACRO_DIR([build/acmacros])
AM_INIT_AUTOMAKE

AC_CONFIG_SRCDIR([cli/main.cc])
AC_CONFIG_HEADERS([config.h:config.in])

# Checks for programs.
AC_PROG_CXX
AC_PROG_CC
AC_LANG(C++)
AC_PROG_INSTALL
AC_PROG_RANLIB
AM_PROG_CC_C_O
AC_PROG_MAKE_SET

POMPEIUS_CHECK_UNIMRCP

# Checks for typedefs, structures, and compiler characteristics.
# AC_CHECK_HEADER_STDBOOL
AC_TYPE_SIZE_T

# Checks for library functions.
AC_FUNC_ERROR_AT_LINE

AC_CONFIG_FILES([Makefile
                 cli/Makefile])

AC_OUTPUT
