//
// Created by wookie on 3/19/24.
//

/*
 * This program consists of two parts: a client and a server, which communicate
 * using POSIX message queues.
 *
 * The client program is called with one parameter - the name of the server's
 * queue (one of the three). The client creates its own queue named after its
 * PID. Then, until EOF is read, it reads lines containing two numbers from the
 * standard input. After reading a line, the client sends a message consisting
 * of its PID number and the two read numbers to the server's queue and waits
 * for a response in its queue. After receiving a response, it prints it. If it
 * does not receive a response within 100ms, it terminates. Upon termination,
 * the program removes its queue.
 * The server creates three named message queues: PID_s, PID_d, and PID_m, where
 * PID is the process identifier. It then prints the names of the created queues.
 *
 * The queues are removed when the programs are closed. Full error handling is
 * implemented.
 */

#include <unistd.h>
#include <stdlib.h>
#include <mqueue.h>
#include <stdio.h>
#include <time.h>
#include <sys/time.h>
#include <errno.h>

#define ERR(source) (perror(source),\
                     fprintf(stderr,"%s:%d\n",__FILE__,__LINE__),\
                     exit(EXIT_FAILURE))
#define MAYBE_UNUSED(x) (void)(x)
#define MSG_QUEUE_NAME_SIZE 256

#define MSG_SIZE sizeof(pid_t) + 2 * sizeof(int64_t)
#define TIMEOUT_MS 100

void usage(char* pname) {
    fprintf(stderr, "Usage: %s [name of the servers message queue]\n", pname);
    exit(EXIT_FAILURE);
}

int main(int argc, char** argv) {
    // Initialize the server message queue name
    if(argc != 2) usage(argv[0]);
    char server_mq_name[MSG_QUEUE_NAME_SIZE];
    if (sprintf(server_mq_name, "/%s", argv[1]) < 0) ERR("sprintf");

    // Set up the clients message queue
    mqd_t mq_c;

    struct mq_attr attr;
    attr.mq_flags = 0;
    attr.mq_maxmsg = 10;
    // The message size is set to the size of the int64_t type (8 bytes)
    // Because the client will only receive a single integer from the server as a response
    attr.mq_msgsize = sizeof(int64_t);

    // Set the message queue name of the client to its PID
    char name_mq_s[MSG_QUEUE_NAME_SIZE];
    if (sprintf(name_mq_s, "/%d", getpid()) < 0) ERR("sprintf");

    if ( (mq_c = mq_open(name_mq_s, O_CREAT | O_RDWR | O_NONBLOCK, 0666, &attr) ) == (mqd_t) -1) ERR("mq_open");
    // Log the message queue name
    printf("Client message queue name: %s\n", name_mq_s);

    // Open the server_mq message queue
    mqd_t server_mq;
    if ((server_mq = mq_open(server_mq_name, O_RDWR)) == (mqd_t) -1) ERR("mq_open");
    printf("Server message queue opened: %s\n", server_mq_name);

    // Declare the integers to operate on and the message buffer
    int64_t a, b;
    char buffer[MSG_SIZE];

    // Enter the main loop

    int run = 1;
    while(run){
        // Send my PID to the server_mq and two integers to operate on
        // Read 2 integers from the user
        int result;
        printf("Enter two integers to operate on:\n");
        if ( (result = scanf("%ld %ld", &a, &b) ) != 2){
            if (result == EOF) break;
            else ERR("scanf");
        }

        // Create the message buffer and fill it with the PID and the two integers
        *((pid_t*)buffer) = getpid();
        *((int64_t*)(buffer + sizeof(pid_t))) = a;
        *((int64_t*)(buffer + sizeof(pid_t) + sizeof(int64_t))) = b;

        if (mq_send(server_mq, buffer, MSG_SIZE, 0) == -1) ERR("mq_send");
        printf("Client sent operation request with arguments: %ld, %ld\n",
               *((int64_t*)(buffer + sizeof(pid_t))),
               *((int64_t*)(buffer + sizeof(pid_t) + sizeof(int64_t)))
        );

        // Receive the summation result from the server
        struct timespec ts;
        int res;
        ts.tv_sec = TIMEOUT_MS / 1000;
        ts.tv_nsec = (TIMEOUT_MS % 1000) * 1000000;
        do {
            if (mq_receive(mq_c, buffer, sizeof(int64_t), NULL) == sizeof(int64_t)) {
                printf("Client received operation result: %ld\n", *((int64_t*)buffer));
                break;
            }
            else if (errno != EAGAIN) ERR("mq_receive");

            res = nanosleep(&ts, &ts);
        } while(res == -1 && erno == EINTR);
        if(res == -1) printf("Client timed out\n");
    }

    // Cleanup
    if(mq_close(mq_c) == -1) ERR("mq_close");
    if(mq_unlink(name_mq_s) == -1) ERR("mq_unlink");

    return EXIT_SUCCESS;
}