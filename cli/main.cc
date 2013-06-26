
#include <iostream>
#include <fstream>
#include <cstdio>
#include <cstdlib>

#include <cstdio>
#include <cstdlib>
#include <csignal>
#include <execinfo.h>
#include <stdio.h>
#include <stdlib.h>
#include <apr_getopt.h>
#include <apr_file_info.h>
#include <apr_thread_proc.h>
#include "asr_engine.h"

int main(int argc, const char * const *argv)
{
  asr_engine_t *engine;

  /* APR global initialization */
  if(apr_initialize() != APR_SUCCESS) {
    apr_terminate();
    return 0;
  }

  /* create asr engine */
  engine = asr_engine_create(
      "/vagrant/engine",
      APT_PRIO_INFO,
      APT_LOG_OUTPUT_CONSOLE);
  std::string audio = "/vagrant/data/one-8kHz.pcm";
  if(engine) {
    printf("Launching");

    asr_session_t *session = asr_session_create(engine, "nss");
    if(session) {
      if (asr_session_file_recognize(session,"/vagrant/data/grammar.xml", audio.c_str())) {
        const char *result = asr_session_wait_for_termination(session);
        if(result) {
          printf("Recog Result [%s]",result);
        }
      }
      asr_session_destroy(session);
    }
    /* destroy demo framework */
    asr_engine_destroy(engine);
    }

    /* APR global termination */
    apr_terminate();
    return 0;
  }
