// Copyright 2022 Flavien Solt, ETH Zurich.
// Licensed under the General Public License, Version 3.0, see LICENSE for details.
// SPDX-License-Identifier: GPL-3.0-only

#include <svdpi.h>

#include <string>
#include <vector>
#include <map>
#include <iostream>
#include <fstream>
#include <sstream>
#include <stdint.h>
#include <unordered_map>
#include <cassert>

// main dimension: taint id.
// pair <word address, content>
// std::vector<std::vector<std::pair<uint64_t, std::vector<uint8_t>>>> taint_assignments;

// Zeroth dim: taint id.
// First  dim: absolute word address.
// Second dim: content.
std::vector<std::unordered_map<size_t, std::vector<uint8_t>>> word_taint_contents;
static size_t glob_word_width_bytes = -1;

extern "C" {
  void init_taint_vectors(long long num_taints);
  char read_taint_section(long long taint_id, long int *word_address, const svOpenArrayHandle svbuffer);
  void read_taints(const char* filename, int word_width_bytes);
  char get_next_taint_word(long long taint_id, long int *word_address, const svOpenArrayHandle svbuffer);
}

extern "C" void init_taint_vectors(long long num_taints) {
  word_taint_contents.resize(num_taints);
}

static inline char char_to_hex(char c) {
  if (c >= '0' && c <= '9')
    return c-'0';
  else if (c >= 'a' && c <= 'f')
    return c-'a'+10;
  else if (c >= 'A' && c <= 'F')
    return c-'A'+10;

  std::cerr << "Error in taint assignment string. Unexpected character: `" << c << "`" << std::endl;
  exit(0);
}

// @return 1 if this is a valid response, 0 if there is nothing anymore to supply, and the outputs should be ignored.
extern "C" char get_next_taint_word(long long taint_id, long int *word_address, const svOpenArrayHandle svbuffer) {
  static auto itr = word_taint_contents[taint_id].begin();

  // If the end of the structure was reached.
  if (itr == word_taint_contents[taint_id].end()) {
    // Set it back to the beginning so another mem can read it as well (used in Ibex).
    itr = word_taint_contents[taint_id].begin();
    return 0;
  }

  // Supply the word address
  *word_address = itr->first;
  printf("Next taint word addr: %lx\n", *word_address);

  // Fill the svbuffer with the word contents
  unsigned char* buf = (unsigned char*)svGetArrayPtr(svbuffer);
  for (size_t byte_id_in_word = 0; byte_id_in_word < glob_word_width_bytes; byte_id_in_word++){
    // printf("  Byte %d: %lx\n", byte_id_in_word, itr->second[byte_id_in_word]);
    buf[byte_id_in_word] = itr->second[byte_id_in_word];
  }

  // Increment the iterator and return that the result is valid.
  itr++;
  return 1;
}

extern "C" void read_taints(const char* filename, int word_width_bytes) {
  assert (word_width_bytes > 0);
  glob_word_width_bytes = word_width_bytes;

  std::ifstream f;
  f.open(filename);

  uint64_t taint_id;
  uint64_t base_addr;
  std::string base_addr_str;
  uint64_t num_bytes;
  std::string num_bytes_str;
  std::string byte_taint_contents_str;

  std::string tmp_line;
  while (std::getline(f, tmp_line)) {
    if (!tmp_line.size())
        continue;
    std::istringstream isstream(tmp_line);
    isstream >> taint_id;
    isstream >> base_addr_str;
    isstream >> num_bytes_str;
    isstream >> byte_taint_contents_str;

    std::istringstream str_to_hex_stream_base_addr(base_addr_str);
    str_to_hex_stream_base_addr >> std::hex >> base_addr;

    std::istringstream str_to_hex_stream_num_bytes(num_bytes_str);
    str_to_hex_stream_num_bytes >> std::hex >> num_bytes;

    assert(num_bytes > 0);

    if (byte_taint_contents_str.size() < 2*num_bytes) {
      std::cerr << "Error: Bytes mask is not long enough in line: `" << tmp_line << "`." << std::endl;
      exit(1);
    }

    // WARNING curr_word_id has an offset: curr_word_id does NOT correspond to address 0!
    for (size_t curr_byte_addr = base_addr; curr_byte_addr < base_addr+num_bytes; curr_byte_addr ++) {
      size_t curr_abs_word_addr = curr_byte_addr / word_width_bytes;
      // Compute the curr byte content
      size_t byte_offset = curr_byte_addr - base_addr;
      uint8_t byte_val = (char_to_hex(byte_taint_contents_str[2*byte_offset]) << 4) | char_to_hex(byte_taint_contents_str[2*byte_offset+1]); 

      // If the word is not yet in the new words struct, then add it.
      if (word_taint_contents[taint_id].find(curr_abs_word_addr) == word_taint_contents[taint_id].end()) {
        std::vector<uint8_t> new_word_content(word_width_bytes, 0);
        word_taint_contents[taint_id].insert({curr_abs_word_addr, new_word_content});
      }

      // Add the content to the word
      size_t byte_id_in_word = curr_byte_addr % word_width_bytes;
      word_taint_contents[taint_id][curr_abs_word_addr][byte_id_in_word] = byte_val;
    }
  }

  f.close();
}

extern "C" char read_taint_section(long long taint_id, long long address, const svOpenArrayHandle buffer) {
  // get actual poitner
  void* buf = svGetArrayPtr(buffer);
  // interpret the taint assignment string.
  std::string taint_assignment_str = taint_assignments[taint_id][address];
  size_t num_bytes = taint_assignment_str.size() / 2;

  for (int byte_offset = 0; byte_offset < num_bytes; byte_offset++) {
    char byte_val = (char_to_hex(taint_assignment_str[2*byte_offset]) << 4) | char_to_hex(taint_assignment_str[2*byte_offset+1]); 
    *((char *) buf + byte_offset) = byte_val;
  }
  return 0;
}
