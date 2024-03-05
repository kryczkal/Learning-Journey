//
// Created by wookie on 3/5/24.
//

/*
This is a simple server program written in C for inter-process communication
using FIFOs (named pipes).

The 'read_from_fifo' function reads data from the FIFO. It reads the data into
a buffer and prints the sender's PID and the message received. It continues
reading until there is no more data to read.

The 'main' function is the entry point of the program. It checks the
command-line arguments, creates a FIFO with the specified name (if it doesn't
already exist), opens the FIFO for reading, and calls 'read_from_fifo' to read
the data. After reading the data, it closes the FIFO and exits the program.

The ERR macro is defined to handle errors. It prints the error message, the
file name, and the line number where the error occurred, then exits the program.

The 'usage' function is used to display the correct usage of the program if the
user provides incorrect arguments.

The program expects one command-line argument: the name of the FIFO file. If
the user does not provide this argument, the program displays the correct usage
and exits.
*/

#include "server.h"

#include <ctype.h>
#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <unistd.h>
#include <linux/limits.h>

#define ERR(source) (perror(source), fprintf(stderr, "%s:%d\n", __FILE__, __LINE__), exit(EXIT_FAILURE))

void usage(char *name)
{
    fprintf(stderr, "USAGE: %s fifo_file\n", name);
    exit(EXIT_FAILURE);
}

void read_from_fifo(int fifo)
{
    ssize_t count;
    char buffer[PIPE_BUF];
    pid_t sender_pid;
    do
    {
        if ((count = read(fifo, &buffer, PIPE_BUF)) < 0)
            ERR("read");
        if (count > 0) {
            sender_pid = *((pid_t *) buffer);
            printf("Sender pid: %d | Message: ", sender_pid);
            for(int i = sizeof(pid_t); i < PIPE_BUF; i++)
            {
                if(isalnum(buffer[i]))
                    printf("%c", buffer[i]);
            }
            printf("\n");
        }
    } while (count > 0);
}

int main(int argc, char **argv)
{
    int fifo;
    if (argc != 2)
        usage(argv[0]);

    if (mkfifo(argv[1], S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP) < 0)
        if (errno != EEXIST)
            ERR("create fifo");
    if ((fifo = open(argv[1], O_RDONLY)) < 0)
        ERR("open");
    read_from_fifo(fifo);
    if (close(fifo) < 0)
        ERR("close fifo:");
    return EXIT_SUCCESS;
}