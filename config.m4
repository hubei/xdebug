dnl $Id: config.m4,v 1.23 2006-09-25 20:20:01 derick Exp $
dnl config.m4 for extension xdebug

PHP_ARG_ENABLE(xdebug, whether to enable eXtended debugging support,
[  --enable-xdebug         Enable Xdebug support])

if test "$PHP_XDEBUG" != "no"; then
dnl We need to set optimization to 0 because my GCC otherwise optimizes too
dnl much out.
  CFLAGS=`echo $CFLAGS | sed 's/O2/O0/'`
  
  PHP_NEW_EXTENSION(xdebug, xdebug.c xdebug_code_coverage.c xdebug_com.c xdebug_compat.c xdebug_handler_dbgp.c xdebug_handler_gdb.c xdebug_handler_php3.c xdebug_handlers.c xdebug_llist.c xdebug_hash.c xdebug_private.c xdebug_profiler.c xdebug_set.c xdebug_str.c xdebug_superglobals.c xdebug_var.c xdebug_xml.c usefulstuff.c, $ext_shared)
  AC_DEFINE(HAVE_XDEBUG,1,[ ])

dnl Check for new current_execute_data field in zend_executor_globals
  old_CPPFLAGS=$CPPFLAGS
  CPPFLAGS="$INCLUDES $CPPFLAGS"

  AC_TRY_COMPILE([
#include <zend_compile.h>
#include <zend_globals.h>
  ], [static struct _zend_executor_globals zeg; zend_execute_data *zed = zeg.current_execute_data],
    [AC_DEFINE(HAVE_EXECUTE_DATA_PTR, 1, [ ])]
  )
  AC_CHECK_FUNCS(gettimeofday)

  CPPFLAGS=$old_CPPFLAGS
fi
