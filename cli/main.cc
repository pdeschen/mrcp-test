
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

    std::cout <<"Loading audio [" + audio + "]." << std::endl;
    std::ifstream file(audio.c_str(), std::ios::in | std::ios::binary | std::ios::ate);
    if (!file) {
      std::cerr <<"Cannot open audio file [" + audio + "]." << std::endl;
      return -1;
    }

    long size = file.tellg();
    file.seekg(0, std::ios::beg);
    char buffer[size];
    file.read(buffer, size);
    file.close();

    asr_session_t *session = asr_session_create(engine, "nss");
    if(session) {
      if (asr_session_file_recognize(session,"/vagrant/data/grammar.xml", audio.c_str())) {
      //if (asr_session_stream_recognize(session,"/vagrant/data/grammar.xml")) {
       // asr_session_stream_write(session, buffer, size);
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
