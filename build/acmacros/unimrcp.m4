AC_DEFUN([POMPEIUS_CHECK_UNIMRCP],
[
	# Get APR library and include locations
	AC_ARG_WITH([apr-include-path],
	  [AS_HELP_STRING([--with-apr-include-path],
	    [location of the APR headers, defaults to /usr/local/apr/include/apr-1/])],
	  [APR_CPPFLAGS="-I$withval"],
	  [APR_CPPFLAGS="-I/usr/local/apr/include/apr-1"])

	#AC_SUBST([APR_CPPFLAGS])

	AC_ARG_WITH([apr-lib-path],
	  [AS_HELP_STRING([--with-apr-lib-path], [location of the APR libraries, defaults to /usr/local/apr/lib])],
	  [APR_LDFLAGS="-Wl,--rpath-link -Wl,$withval -L$withval"],
	  [APR_LDFLAGS="-Wl,--rpath-link -Wl,/usr/local/apr/lib/ -L/usr/local/apr/lib/"])
	#AC_SUBST([APR_LDFLAGS])

	CPPFLAGS="$CPPFLAGS $APR_CPPFLAGS"
	LDFLAGS="$LDFLAGS $APR_LDFLAGS"

	# Get Unimrcp library and include locations
	AC_ARG_WITH([unimrcp-include-path],
	  [AS_HELP_STRING([--with-unimrcp-include-path],
	    [location of the Unimrcp headers, defaults to /usr/local/unimrcp/include and /usr/src/unimrcp/libs/apr-toolkit/include/])],
	  [UNIMRCP_CPPFLAGS="-I$withval"],
	  [UNIMRCP_CPPFLAGS="-I/usr/local/unimrcp/include -I/usr/src/unimrcp/libs/apr-toolkit/include"])
	#AC_SUBST([APR_CPPFLAGS])

	AC_ARG_WITH([unimrcp-lib-path],
	  [AS_HELP_STRING([--with-unimrcp-lib-path], [location of the Unimrcp libraries, defaults to /usr/local/unimrcp/lib])],
	  [UNIMRCP_LDFLAGS="-Wl,--rpath-link -Wl,$withval -L$withval"],
	  [UNIMRCP_LDFLAGS="-Wl,--rpath-link -Wl,/usr/local/unimrcp/lib -L/usr/local/unimrcp/lib/"])
	#AC_SUBST([UNIMRCP_LDFLAGS])

	CPPFLAGS_BAK="$CPPFLAGS"
	LDFLAGS_BAK="$LDFLAGS"
	# CXXFLAGS="$CXXGLAGS -m32"

	CPPFLAGS="$CPPFLAGS $APR_CPPFLAGS $UNIMRCP_CPPFLAGS"
	LDFLAGS="$LDFLAGS $APR_CPPFLAGS $UNIMRCP_LDFLAGS"

	# Checks for header files.
	AC_CHECK_HEADERS(unimrcp_client.h)

	AM_CONDITIONAL(HAVE_UNIMRCP, test "$ac_cv_header_unimrcp_client_h" == yes)

	if test "$ac_cv_header_unimrcp_client_h" == no; then
		echo "-----------------------------------------------------------"
		echo "unimrcp_client.h is missing! MRCP Engine won't be compiled." 
		echo "-----------------------------------------------------------"
		CPPFLAGS="$CPPFLAGS_BAK"
		LDFLAGS="$LDFLAGS_BAK"
	else
		# Checks for libraries.
		AC_CHECK_LIB([unimrcpclient], [unimrcp_client_create])
		AC_CHECK_LIB([apr-1], [apr_file_open])
	fi
])
