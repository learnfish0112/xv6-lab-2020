#include "kernel/types.h"
#include "kernel/stat.h"
#include "kernel/fs.h"
#include "kernel/fcntl.h"
#include "user/user.h"


    void
find(char *path, char* search_file)
{
    char buf[512], *p;
    int fd;
    struct dirent de;
    struct stat st;

#if 0
    O_RDONLY exist problem?
    if((fd = open(path, O_RDONLY) < 0)) {
        fprintf(2, "cannot open: %s\n", path);
        return;
    }

    if(fstat(fd, &st) < 0) {
        fprintf(2, "cannot fstat: %s\n", path);
        return;
    }
#endif
  if((fd = open(path, 0)) < 0){
    fprintf(2, " cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
    fprintf(2, " cannot stat %s\n", path);
    close(fd);
    return;
  }

  /* printf("find, path = %s, st.type = %d\n", path, st.type); */
    switch(st.type) {
    case T_DIR:
        /* printf("Enter T_DIR\n"); */
        if(strlen(path) + 1 + DIRSIZ + 1 > sizeof(buf)) {
            fprintf(2, "path too long\n");
            break;
        }

        strcpy(buf, path);
        p = buf+strlen(buf);
        *p++ = '/';
        while(read(fd, &de, sizeof(de)) == sizeof(de)){
            if(de.inum == 0)
                continue;
            memmove(p, de.name, DIRSIZ);
            p[DIRSIZ] = 0;

            if(strcmp(de.name, search_file) == 0) {
                //print search_file path && file name
                printf("%s/%s\n", path, search_file);
            }
            if(stat(buf, &st) != 0) {
                printf("find: cannot stat %s\n", buf);
                continue;
            } else {
                if(st.type == T_DIR) {
                    if(strcmp(de.name, ".") == 0 || \
                       strcmp(de.name, "..") == 0) {
                        /* printf("Do not recursive %s\n", de.name); */
                        continue;
                    }
                    /* printf("debug, recursive case\n"); */
                    find(buf, search_file);
                }
            }
        }

        break;
    default:
        fprintf(2, "arg %s illegal, file type err\n", path);
        break;
    }

    close(fd);
    return;
}

    int
main(int argc, char *argv[])
{
    if(argc < 3 || argc > 3){
        fprintf(2, "Usage: hope argc 3, find search_path search_file\n");
        exit(1);
    }

    find(argv[1], argv[2]);
    exit(0);
    return 0;
}

