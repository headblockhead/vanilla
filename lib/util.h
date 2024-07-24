#ifndef VANILLA_UTIL_H
#define VANILLA_UTIL_H

#include <stddef.h>
#include <stdio.h>
#include <stdint.h>
#include <sys/types.h>

#define MIN(a,b) (((a)<(b))?(a):(b))
#define MAX(a,b) (((a)>(b))?(a):(b))
#define CLAMP(x, min, max) (MIN(MAX(x, min), max))

size_t read_line_from_fd(int fd, char *output, size_t max_output_size);
size_t read_line_from_file(FILE *file, char *output, size_t max_output_size);
size_t get_home_directory(char *buf, size_t buf_size);
size_t get_home_directory_file(const char *filename, char *buf, size_t buf_size);
size_t get_max_path_length();

uint32_t htonl(uint32_t s);
uint16_t htons(uint16_t s);
uint32_t ntohl(uint32_t s);
uint16_t ntohs(uint16_t s);

void clear_interrupt();
int is_interrupted();
void force_interrupt();
void install_interrupt_handler();
void uninstall_interrupt_handler();

int start_process(const char **argv, pid_t *pid_out, int *stdout_pipe, int *stderr_pipe);

const char *get_wireless_authenticate_config_filename();
const char *get_wireless_connect_config_filename();

uint16_t crc16(const void* data, size_t len);

#endif // VANILLA_UTIL_H