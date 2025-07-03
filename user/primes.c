#include "kernel/types.h"
#include "kernel/stat.h"
#include "user.h"

void new_proc(int original_pipe[]);

    int 
main(void)
{
    int pipe_0[2];
    int p = 2;
    int n = p;
    pipe(pipe_0);

    if(fork() == 0) {
        //child
        new_proc(pipe_0);
    } else {
        //parent
        printf("prime %d\n", p);

        close(pipe_0[0]);

        while(n <= 35) {
            n++;
            if(n % p != 0) {
                write(pipe_0[1], &n, sizeof(int));
            }
        }
    }
    close(pipe_0[1]);
    wait(0);
    exit(0);
}

void new_proc(int original_pipe[]) {
    close(original_pipe[1]);

    int receive_prime = 0;
    int whether_continue_fork = 0;
    whether_continue_fork = read(original_pipe[0], &receive_prime, sizeof(int));
    /* printf("getpid: %d, whether_continue_fork %d\n", getpid(), whether_continue_fork); */
    /* printf("getpid: %d, original_pipe[0] %d\n", getpid(), original_pipe[0]); */
    if(whether_continue_fork == 0) {
        /*no need fork, declare not receive prime this time*/
        exit(0);
    }

    printf("prime %d\n", receive_prime);
    int new_pipe[2];
    pipe(new_pipe);

    if(fork() == 0) {
        //child
        close(original_pipe[0]);
        new_proc(new_pipe);
    } else {
        //parent
        close(new_pipe[0]);
        int ret = -100;
        int check_prime_num = 0;

        while(ret != 0) {
            ret = read(original_pipe[0], &check_prime_num, sizeof(int));
            /* printf("debug, pid:%d ret: %d, check_prime_num: %d\n", getpid(), ret, check_prime_num); */
            if(ret == 0) {
                break;
            }
            if(check_prime_num % receive_prime != 0) {
                write(new_pipe[1], &check_prime_num, sizeof(int));
            }
        }

        close(new_pipe[1]);
        wait(0);
        exit(0);
    }
}
