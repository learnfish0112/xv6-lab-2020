#include "kernel/types.h"
#include "kernel/stat.h"
#include "user.h"

int 
main(int argc, char* argv[])
{
    if(argc >= 2) {
        fprintf(2, "Usage: pingpong\n");
        exit(1);
    }
    int p1[2];
    int p2[2];

    pipe(p1);
    pipe(p2);

    if(fork() == 0) {
        //child
        char ch;
        int ret;
        close(p1[1]);
        close(p2[0]);
        ret = read(p1[0], &ch, (int)sizeof(char));
        if(ret != 1) {
            fprintf(2, "<%d>: read char failed\n", getpid());
            exit(1);
        }
        printf("<%d>: received ping\n", getpid());
        ret = write(p2[1], &ch, (int)sizeof(char));
        if(ret != 1) {
            fprintf(2, "<%d>: write char failed\n", getpid());
            exit(1);
        }
    } else {
        //parent
        char c = 'a';
        int ret;
        close(p1[0]);
        close(p2[1]);

        ret = write(p1[1], &c, (int)sizeof(char));
        if(ret != 1) {
            fprintf(2, "<%d>: write char failed %s\n", getpid());
            exit(1);
        }
        ret = read(p2[0], &c, (int)sizeof(char));
        if(ret != 1) {
            fprintf(2, "<%d>: read char failed %s\n", getpid());
            exit(1);
        }
        printf("<%d>: received pong\n", getpid());
    }
    exit(0);
}

