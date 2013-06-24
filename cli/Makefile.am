bin_PROGRAMS = test
test_SOURCES = main.cc \
		asr_engine.c
test_CPPFLAGS = -I$(top_srcdir)/lib -I. $(DEPS_CFLAGS)

check_SCRIPTS = .test.sh
TESTS = $(check_SCRIPTS)
.test.sh:
	echo './test | grep "usage"' > .test.sh
	chmod +x .test.sh

CLEANFILES = .test.sh
