// Copyright Flavien Solt, ETH Zurich.
// Licensed under the General Public License, Version 3.0, see LICENSE for details.
// SPDX-License-Identifier: GPL-3.0-only

#include "VTEMPLATE_TOP_MODULE_NAME.h"
#include "verilated.h"

#if VM_TRACE
#if VM_TRACE_FST
#include <verilated_fst_c.h>
#else
#include <verilated_vcd_c.h>
#endif // VM_TRACE_FST
#endif // VM_TRACE

#include <iostream>
#include <stdlib.h>

#ifndef TESTBENCH_H
#define TESTBENCH_H

#if VM_TRACE
// Depth of the trace.
const int kTraceLevel = 6;
#endif // VM_TRACE

#include <cassert>
#include <sstream>
#include <fstream>
#include <queue>

static const char *cl_get_tracefile(void)
{
#if VM_TRACE
  const char *trace_env = std::getenv("TRACEFILE"); // allow override for batch execution from python
  if(trace_env == NULL) { std::cerr << "TRACEFILE environment variable not set." << std::endl; exit(1); }
  return trace_env;
#else
  return "";
#endif
}

// Then, each line contains the next list of values for these inputs, **except for the clock**.
// An output is produced for each clock cycle.
bool is_input_file_open = false;
std::queue<uint64_t> input_values;
static void open_input_file()
{
  const char* path_to_input_file_env = std::getenv("PATH_TO_SRAM_PROTO_INPUT_FILE");
  if(path_to_input_file_env == NULL) { std::cerr << "PATH_TO_SRAM_PROTO_INPUT_FILE environment variable not set." << std::endl; exit(1); }
  std::string path_to_input_file = path_to_input_file_env;
  std::cout << "Input file: " << path_to_input_file << std::endl;

  is_input_file_open = true;
  // Read it entirely line by line.
  std::ifstream input_file(path_to_input_file.c_str());
  if (!input_file.is_open()) {
    std::cerr << "Could not open input file for reading." << std::endl;
    exit(1);
  }

  std::string line;
  while (std::getline(input_file, line)) { // Read the file line by line
      std::istringstream iss(line);
      std::string token;
      while (iss >> token) { // Extract tokens from each line
          input_values.push(std::stoull(token));
      }
  }

  // std::string line;
  // std::getline(input_file, line);;
  // size_t num_inputs;
  // // Get the first integer from the file
  // num_inputs = std::stoull(line);
  // while (std::getline(iss, token, ',')) {
  //   // Add the input to the queue.
  //   input_values.push(std::stoull(token));
  // }
  // input_file.close();
}

static size_t get_num_remaining_inputs() {
  return input_values.size();
}

static int get_next_input() {
  if (!is_input_file_open) {
    open_input_file();
  }

  if (input_values.empty()) {
    std::cout << "No more inputs to read." << std::endl;
    exit(1);
  }

  int ret = input_values.front();
  input_values.pop();
  return ret;
}

typedef VTEMPLATE_TOP_MODULE_NAME Module;

// This class implements elementary interaction with the design under test.
class Testbench {
 public:
  Testbench(const std::string &trace_filename = "")
      : module_(new Module), tick_count_(0l) {
#if VM_TRACE
#if VM_TRACE_FST
    trace_ = new VerilatedFstC;
#else // VM_TRACE_FST
    trace_ = new VerilatedVcdC;
#endif // VM_TRACE_FST
    module_->trace(trace_, kTraceLevel);
    trace_->open(trace_filename.c_str());
#endif // VM_TRACE
  }

  ~Testbench(void) { close_trace(); }

  void close_trace(void) {
#if VM_TRACE  
    trace_->close();
#endif // VM_TRACE
  }

  /**
   * Performs one or multiple clock cycles.
   *
   * @param num_ticks the number of ticks to perform.
   */
   // @return false.
  void tick(int num_ticks = 1) {
    for (size_t i = 0; i < num_ticks || num_ticks == -1; i++) {
      tick_count_++;

TEMPLATE_CLOCK_DOWN
      module_->eval();

#if VM_TRACE
      trace_->dump(5 * tick_count_ - 1);
#endif // VM_TRACE

TEMPLATE_CLOCK_UP
      module_->eval();

#if VM_TRACE
      trace_->dump(5 * tick_count_);
#endif // VM_TRACE

TEMPLATE_CLOCK_DOWN
      module_->eval();

#if VM_TRACE
      trace_->dump(5 * tick_count_ + 2);
      trace_->flush();
#endif // VM_TRACE
    }
    return;
  }

  std::unique_ptr<Module> module_;
 private:
  vluint32_t tick_count_;

#if VM_TRACE
#if VM_TRACE_FST
  VerilatedFstC *trace_;
#else // VM_TRACE_FST
  VerilatedVcdC *trace_;
#endif // VM_TRACE_FST
#endif // VM_TRACE
};

#endif // TESTBENCH_H
