// Copyright Flavien Solt, ETH Zurich.
// Licensed under the General Public License, Version 3.0, see LICENSE for details.
// SPDX-License-Identifier: GPL-3.0-only

#include <iomanip>

#include "testbench.h"

/**
 * Runs the testbench.
 *
 * @param tb a pointer to a testbench instance
 * @param simlen the number of cycles to run
 */
static unsigned long run_test(Testbench *tb) {

TEMPLATE_RESET_SIGNAL

  auto start = std::chrono::steady_clock::now();
  for(size_t cycle_id = 0; get_num_remaining_inputs(); cycle_id++) {  
TEMPLATE_FEED_INPUTS
    tb->tick(1);

    if ((uint32_t)(TEMPLATE_RDATA))
      std::cout << "Output at cycle " << std::setw(4) << cycle_id << ": " << (uint32_t)(TEMPLATE_OUTPUT_SIGNAL) << std::endl;
  }
  auto stop = std::chrono::steady_clock::now();
  long ret = std::chrono::duration_cast<std::chrono::milliseconds>(stop - start).count();
  return ret;
}

int main(int argc, char **argv, char **env) {

  Verilated::commandArgs(argc, argv);
  Verilated::traceEverOn(VM_TRACE);
#ifdef HAS_COVERAGE
  char *coveragepath;
  coveragepath = getenv("COVERAGEFILE");
#endif // HAS_COVERAGE

  ////////
  // Get the env vars early to avoid Verilator segfaults.
  ////////

  open_input_file();

  ////////
  // Initialize testbench.
  ////////

  Testbench *tb = new Testbench(cl_get_tracefile());


  ////////
  // Run the testbench.
  ////////

  unsigned int duration = run_test(tb);

  ////////
  // Print the duration.
  ////////

  std::cout << "Simulation took " << duration << " ms." << std::endl;

  delete tb;
  exit(0);
}
