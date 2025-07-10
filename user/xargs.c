#include "kernel/types.h"
#include "kernel/stat.h"
#include "kernel/param.h"
#include "user.h"

int main(int argc, char* argv[])
{
    if(argc < 2) {
        fprintf(2, "xargs Usage: transpara_cmd [argvs]\n");
        exit(1);
    }

    char* transfer_argv[MAXARG];
    for(int i = 1; i < argc; i++) {
        transfer_argv[i - 1] = malloc(strlen(argv[i]) + 1);
        strcpy(transfer_argv[i - 1], argv[i]);
        printf("transfer_argv[%d] = %s\n", i - 1, transfer_argv[i - 1]);
        //current cannot read sh script arg: ., it exist in stdin
    }

    if(fork() == 0) {
        /*child*/
        exec(argv[1], transfer_argv); 
        fprintf(2, "exec failed\n");
        exit(1);
    } else {    
        int ret = 0;
        ret = wait(0);
        printf("child return %d\n", ret);
        printf("should never seen before grep over\n");
    }
    return 0;
}

