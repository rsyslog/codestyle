                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ(2.61)
AC_INIT([liblognorm], [2.0.2], [rgerhards@adiscon.com])
AM_INIT_AUTOMAKE
m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])
AC_CONFIG_SRCDIR([stylecheck.c])
AC_CONFIG_HEADER([config.h])

AC_USE_SYSTEM_EXTENSIONS

# Checks for programs.
AC_PROG_CC
AM_PROG_CC_C_O
AC_PROG_CC_C99

m4_ifdef([AX_IS_RELEASE], [
	AX_IS_RELEASE([git-directory])
	m4_ifdef([AX_COMPILER_FLAGS], [
		AX_COMPILER_FLAGS()
	], [
		if test "$GCC" = "yes"
		then CFLAGS="$CFLAGS -W -Wall -Wformat-security -Wshadow -Wcast-align -Wpointer-arith -Wmissing-format-attribute -g"
		fi
		AC_MSG_WARN([missing AX_COMPILER_FLAGS macro, not using it])
	])
], [
	CFLAGS="$CFLAGS -W -Werror -Wall -Wformat-security -Wshadow -Wcast-align -Wpointer-arith -Wmissing-format-attribute -g"
	AC_MSG_WARN([missing AX_IS_RELEASE macro, not using AX_COMPILER_FLAGS macro because of this])
])


AC_CONFIG_FILES([Makefile])
AC_OUTPUT
AC_CONFIG_MACRO_DIR([m4])
