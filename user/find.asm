
user/_find：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <find>:
#include "user/user.h"


    void
find(char *path, char* search_file)
{
   0:	d7010113          	addi	sp,sp,-656
   4:	28113423          	sd	ra,648(sp)
   8:	28813023          	sd	s0,640(sp)
   c:	26913c23          	sd	s1,632(sp)
  10:	27213823          	sd	s2,624(sp)
  14:	27313423          	sd	s3,616(sp)
  18:	27413023          	sd	s4,608(sp)
  1c:	25513c23          	sd	s5,600(sp)
  20:	25613823          	sd	s6,592(sp)
  24:	25713423          	sd	s7,584(sp)
  28:	25813023          	sd	s8,576(sp)
  2c:	23913c23          	sd	s9,568(sp)
  30:	0d00                	addi	s0,sp,656
  32:	892a                	mv	s2,a0
  34:	89ae                	mv	s3,a1
    if(fstat(fd, &st) < 0) {
        fprintf(2, "cannot fstat: %s\n", path);
        return;
    }
#endif
  if((fd = open(path, 0)) < 0){
  36:	4581                	li	a1,0
  38:	00000097          	auipc	ra,0x0
  3c:	4e4080e7          	jalr	1252(ra) # 51c <open>
  40:	06054863          	bltz	a0,b0 <find+0xb0>
  44:	84aa                	mv	s1,a0
    fprintf(2, " cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
  46:	d7840593          	addi	a1,s0,-648
  4a:	00000097          	auipc	ra,0x0
  4e:	4ea080e7          	jalr	1258(ra) # 534 <fstat>
  52:	06054a63          	bltz	a0,c6 <find+0xc6>
    close(fd);
    return;
  }

  /* printf("find, path = %s, st.type = %d\n", path, st.type); */
    switch(st.type) {
  56:	d8041703          	lh	a4,-640(s0)
  5a:	4785                	li	a5,1
  5c:	08f70563          	beq	a4,a5,e6 <find+0xe6>
            }
        }

        break;
    default:
        fprintf(2, "arg %s illegal, file type err\n", path);
  60:	864a                	mv	a2,s2
  62:	00001597          	auipc	a1,0x1
  66:	a0e58593          	addi	a1,a1,-1522 # a70 <malloc+0x15c>
  6a:	4509                	li	a0,2
  6c:	00000097          	auipc	ra,0x0
  70:	7ba080e7          	jalr	1978(ra) # 826 <fprintf>
        break;
    }

    close(fd);
  74:	8526                	mv	a0,s1
  76:	00000097          	auipc	ra,0x0
  7a:	48e080e7          	jalr	1166(ra) # 504 <close>
    return;
}
  7e:	28813083          	ld	ra,648(sp)
  82:	28013403          	ld	s0,640(sp)
  86:	27813483          	ld	s1,632(sp)
  8a:	27013903          	ld	s2,624(sp)
  8e:	26813983          	ld	s3,616(sp)
  92:	26013a03          	ld	s4,608(sp)
  96:	25813a83          	ld	s5,600(sp)
  9a:	25013b03          	ld	s6,592(sp)
  9e:	24813b83          	ld	s7,584(sp)
  a2:	24013c03          	ld	s8,576(sp)
  a6:	23813c83          	ld	s9,568(sp)
  aa:	29010113          	addi	sp,sp,656
  ae:	8082                	ret
    fprintf(2, " cannot open %s\n", path);
  b0:	864a                	mv	a2,s2
  b2:	00001597          	auipc	a1,0x1
  b6:	94e58593          	addi	a1,a1,-1714 # a00 <malloc+0xec>
  ba:	4509                	li	a0,2
  bc:	00000097          	auipc	ra,0x0
  c0:	76a080e7          	jalr	1898(ra) # 826 <fprintf>
    return;
  c4:	bf6d                	j	7e <find+0x7e>
    fprintf(2, " cannot stat %s\n", path);
  c6:	864a                	mv	a2,s2
  c8:	00001597          	auipc	a1,0x1
  cc:	95058593          	addi	a1,a1,-1712 # a18 <malloc+0x104>
  d0:	4509                	li	a0,2
  d2:	00000097          	auipc	ra,0x0
  d6:	754080e7          	jalr	1876(ra) # 826 <fprintf>
    close(fd);
  da:	8526                	mv	a0,s1
  dc:	00000097          	auipc	ra,0x0
  e0:	428080e7          	jalr	1064(ra) # 504 <close>
    return;
  e4:	bf69                	j	7e <find+0x7e>
        if(strlen(path) + 1 + DIRSIZ + 1 > sizeof(buf)) {
  e6:	854a                	mv	a0,s2
  e8:	00000097          	auipc	ra,0x0
  ec:	1b4080e7          	jalr	436(ra) # 29c <strlen>
  f0:	2541                	addiw	a0,a0,16
  f2:	20000793          	li	a5,512
  f6:	00a7fc63          	bleu	a0,a5,10e <find+0x10e>
            fprintf(2, "path too long\n");
  fa:	00001597          	auipc	a1,0x1
  fe:	93658593          	addi	a1,a1,-1738 # a30 <malloc+0x11c>
 102:	4509                	li	a0,2
 104:	00000097          	auipc	ra,0x0
 108:	722080e7          	jalr	1826(ra) # 826 <fprintf>
            break;
 10c:	b7a5                	j	74 <find+0x74>
        strcpy(buf, path);
 10e:	85ca                	mv	a1,s2
 110:	da040513          	addi	a0,s0,-608
 114:	00000097          	auipc	ra,0x0
 118:	138080e7          	jalr	312(ra) # 24c <strcpy>
        p = buf+strlen(buf);
 11c:	da040513          	addi	a0,s0,-608
 120:	00000097          	auipc	ra,0x0
 124:	17c080e7          	jalr	380(ra) # 29c <strlen>
 128:	1502                	slli	a0,a0,0x20
 12a:	9101                	srli	a0,a0,0x20
 12c:	da040793          	addi	a5,s0,-608
 130:	00a78a33          	add	s4,a5,a0
        *p++ = '/';
 134:	001a0a93          	addi	s5,s4,1
 138:	02f00793          	li	a5,47
 13c:	00fa0023          	sb	a5,0(s4)
                printf("%s/%s\n", path, search_file);
 140:	00001b97          	auipc	s7,0x1
 144:	900b8b93          	addi	s7,s7,-1792 # a40 <malloc+0x12c>
                if(st.type == T_DIR) {
 148:	4b05                	li	s6,1
                    if(strcmp(de.name, ".") == 0 || \
 14a:	00001c17          	auipc	s8,0x1
 14e:	916c0c13          	addi	s8,s8,-1770 # a60 <malloc+0x14c>
                       strcmp(de.name, "..") == 0) {
 152:	00001c97          	auipc	s9,0x1
 156:	916c8c93          	addi	s9,s9,-1770 # a68 <malloc+0x154>
        while(read(fd, &de, sizeof(de)) == sizeof(de)){
 15a:	4641                	li	a2,16
 15c:	d9040593          	addi	a1,s0,-624
 160:	8526                	mv	a0,s1
 162:	00000097          	auipc	ra,0x0
 166:	392080e7          	jalr	914(ra) # 4f4 <read>
 16a:	47c1                	li	a5,16
 16c:	f0f514e3          	bne	a0,a5,74 <find+0x74>
            if(de.inum == 0)
 170:	d9045783          	lhu	a5,-624(s0)
 174:	d3fd                	beqz	a5,15a <find+0x15a>
            memmove(p, de.name, DIRSIZ);
 176:	4639                	li	a2,14
 178:	d9240593          	addi	a1,s0,-622
 17c:	8556                	mv	a0,s5
 17e:	00000097          	auipc	ra,0x0
 182:	29c080e7          	jalr	668(ra) # 41a <memmove>
            p[DIRSIZ] = 0;
 186:	000a07a3          	sb	zero,15(s4)
            if(strcmp(de.name, search_file) == 0) {
 18a:	85ce                	mv	a1,s3
 18c:	d9240513          	addi	a0,s0,-622
 190:	00000097          	auipc	ra,0x0
 194:	0d8080e7          	jalr	216(ra) # 268 <strcmp>
 198:	c531                	beqz	a0,1e4 <find+0x1e4>
            if(stat(buf, &st) != 0) {
 19a:	d7840593          	addi	a1,s0,-648
 19e:	da040513          	addi	a0,s0,-608
 1a2:	00000097          	auipc	ra,0x0
 1a6:	1e8080e7          	jalr	488(ra) # 38a <stat>
 1aa:	e529                	bnez	a0,1f4 <find+0x1f4>
                if(st.type == T_DIR) {
 1ac:	d8041783          	lh	a5,-640(s0)
 1b0:	fb6795e3          	bne	a5,s6,15a <find+0x15a>
                    if(strcmp(de.name, ".") == 0 || \
 1b4:	85e2                	mv	a1,s8
 1b6:	d9240513          	addi	a0,s0,-622
 1ba:	00000097          	auipc	ra,0x0
 1be:	0ae080e7          	jalr	174(ra) # 268 <strcmp>
 1c2:	dd41                	beqz	a0,15a <find+0x15a>
                       strcmp(de.name, "..") == 0) {
 1c4:	85e6                	mv	a1,s9
 1c6:	d9240513          	addi	a0,s0,-622
 1ca:	00000097          	auipc	ra,0x0
 1ce:	09e080e7          	jalr	158(ra) # 268 <strcmp>
                    if(strcmp(de.name, ".") == 0 || \
 1d2:	d541                	beqz	a0,15a <find+0x15a>
                    find(buf, search_file);
 1d4:	85ce                	mv	a1,s3
 1d6:	da040513          	addi	a0,s0,-608
 1da:	00000097          	auipc	ra,0x0
 1de:	e26080e7          	jalr	-474(ra) # 0 <find>
 1e2:	bfa5                	j	15a <find+0x15a>
                printf("%s/%s\n", path, search_file);
 1e4:	864e                	mv	a2,s3
 1e6:	85ca                	mv	a1,s2
 1e8:	855e                	mv	a0,s7
 1ea:	00000097          	auipc	ra,0x0
 1ee:	66a080e7          	jalr	1642(ra) # 854 <printf>
 1f2:	b765                	j	19a <find+0x19a>
                printf("find: cannot stat %s\n", buf);
 1f4:	da040593          	addi	a1,s0,-608
 1f8:	00001517          	auipc	a0,0x1
 1fc:	85050513          	addi	a0,a0,-1968 # a48 <malloc+0x134>
 200:	00000097          	auipc	ra,0x0
 204:	654080e7          	jalr	1620(ra) # 854 <printf>
                continue;
 208:	bf89                	j	15a <find+0x15a>

000000000000020a <main>:

    int
main(int argc, char *argv[])
{
 20a:	1141                	addi	sp,sp,-16
 20c:	e406                	sd	ra,8(sp)
 20e:	e022                	sd	s0,0(sp)
 210:	0800                	addi	s0,sp,16
    if(argc < 3 || argc > 3){
 212:	478d                	li	a5,3
 214:	02f50063          	beq	a0,a5,234 <main+0x2a>
        fprintf(2, "Usage: hope argc 3, find search_path search_file\n");
 218:	00001597          	auipc	a1,0x1
 21c:	87858593          	addi	a1,a1,-1928 # a90 <malloc+0x17c>
 220:	4509                	li	a0,2
 222:	00000097          	auipc	ra,0x0
 226:	604080e7          	jalr	1540(ra) # 826 <fprintf>
        exit(1);
 22a:	4505                	li	a0,1
 22c:	00000097          	auipc	ra,0x0
 230:	2b0080e7          	jalr	688(ra) # 4dc <exit>
 234:	872e                	mv	a4,a1
    }

    find(argv[1], argv[2]);
 236:	698c                	ld	a1,16(a1)
 238:	6708                	ld	a0,8(a4)
 23a:	00000097          	auipc	ra,0x0
 23e:	dc6080e7          	jalr	-570(ra) # 0 <find>
    exit(0);
 242:	4501                	li	a0,0
 244:	00000097          	auipc	ra,0x0
 248:	298080e7          	jalr	664(ra) # 4dc <exit>

000000000000024c <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 24c:	1141                	addi	sp,sp,-16
 24e:	e422                	sd	s0,8(sp)
 250:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 252:	87aa                	mv	a5,a0
 254:	0585                	addi	a1,a1,1
 256:	0785                	addi	a5,a5,1
 258:	fff5c703          	lbu	a4,-1(a1)
 25c:	fee78fa3          	sb	a4,-1(a5)
 260:	fb75                	bnez	a4,254 <strcpy+0x8>
    ;
  return os;
}
 262:	6422                	ld	s0,8(sp)
 264:	0141                	addi	sp,sp,16
 266:	8082                	ret

0000000000000268 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 268:	1141                	addi	sp,sp,-16
 26a:	e422                	sd	s0,8(sp)
 26c:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 26e:	00054783          	lbu	a5,0(a0)
 272:	cf91                	beqz	a5,28e <strcmp+0x26>
 274:	0005c703          	lbu	a4,0(a1)
 278:	00f71b63          	bne	a4,a5,28e <strcmp+0x26>
    p++, q++;
 27c:	0505                	addi	a0,a0,1
 27e:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 280:	00054783          	lbu	a5,0(a0)
 284:	c789                	beqz	a5,28e <strcmp+0x26>
 286:	0005c703          	lbu	a4,0(a1)
 28a:	fef709e3          	beq	a4,a5,27c <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
 28e:	0005c503          	lbu	a0,0(a1)
}
 292:	40a7853b          	subw	a0,a5,a0
 296:	6422                	ld	s0,8(sp)
 298:	0141                	addi	sp,sp,16
 29a:	8082                	ret

000000000000029c <strlen>:

uint
strlen(const char *s)
{
 29c:	1141                	addi	sp,sp,-16
 29e:	e422                	sd	s0,8(sp)
 2a0:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 2a2:	00054783          	lbu	a5,0(a0)
 2a6:	cf91                	beqz	a5,2c2 <strlen+0x26>
 2a8:	0505                	addi	a0,a0,1
 2aa:	87aa                	mv	a5,a0
 2ac:	4685                	li	a3,1
 2ae:	9e89                	subw	a3,a3,a0
 2b0:	00f6853b          	addw	a0,a3,a5
 2b4:	0785                	addi	a5,a5,1
 2b6:	fff7c703          	lbu	a4,-1(a5)
 2ba:	fb7d                	bnez	a4,2b0 <strlen+0x14>
    ;
  return n;
}
 2bc:	6422                	ld	s0,8(sp)
 2be:	0141                	addi	sp,sp,16
 2c0:	8082                	ret
  for(n = 0; s[n]; n++)
 2c2:	4501                	li	a0,0
 2c4:	bfe5                	j	2bc <strlen+0x20>

00000000000002c6 <memset>:

void*
memset(void *dst, int c, uint n)
{
 2c6:	1141                	addi	sp,sp,-16
 2c8:	e422                	sd	s0,8(sp)
 2ca:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 2cc:	ce09                	beqz	a2,2e6 <memset+0x20>
 2ce:	87aa                	mv	a5,a0
 2d0:	fff6071b          	addiw	a4,a2,-1
 2d4:	1702                	slli	a4,a4,0x20
 2d6:	9301                	srli	a4,a4,0x20
 2d8:	0705                	addi	a4,a4,1
 2da:	972a                	add	a4,a4,a0
    cdst[i] = c;
 2dc:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 2e0:	0785                	addi	a5,a5,1
 2e2:	fee79de3          	bne	a5,a4,2dc <memset+0x16>
  }
  return dst;
}
 2e6:	6422                	ld	s0,8(sp)
 2e8:	0141                	addi	sp,sp,16
 2ea:	8082                	ret

00000000000002ec <strchr>:

char*
strchr(const char *s, char c)
{
 2ec:	1141                	addi	sp,sp,-16
 2ee:	e422                	sd	s0,8(sp)
 2f0:	0800                	addi	s0,sp,16
  for(; *s; s++)
 2f2:	00054783          	lbu	a5,0(a0)
 2f6:	cf91                	beqz	a5,312 <strchr+0x26>
    if(*s == c)
 2f8:	00f58a63          	beq	a1,a5,30c <strchr+0x20>
  for(; *s; s++)
 2fc:	0505                	addi	a0,a0,1
 2fe:	00054783          	lbu	a5,0(a0)
 302:	c781                	beqz	a5,30a <strchr+0x1e>
    if(*s == c)
 304:	feb79ce3          	bne	a5,a1,2fc <strchr+0x10>
 308:	a011                	j	30c <strchr+0x20>
      return (char*)s;
  return 0;
 30a:	4501                	li	a0,0
}
 30c:	6422                	ld	s0,8(sp)
 30e:	0141                	addi	sp,sp,16
 310:	8082                	ret
  return 0;
 312:	4501                	li	a0,0
 314:	bfe5                	j	30c <strchr+0x20>

0000000000000316 <gets>:

char*
gets(char *buf, int max)
{
 316:	711d                	addi	sp,sp,-96
 318:	ec86                	sd	ra,88(sp)
 31a:	e8a2                	sd	s0,80(sp)
 31c:	e4a6                	sd	s1,72(sp)
 31e:	e0ca                	sd	s2,64(sp)
 320:	fc4e                	sd	s3,56(sp)
 322:	f852                	sd	s4,48(sp)
 324:	f456                	sd	s5,40(sp)
 326:	f05a                	sd	s6,32(sp)
 328:	ec5e                	sd	s7,24(sp)
 32a:	1080                	addi	s0,sp,96
 32c:	8baa                	mv	s7,a0
 32e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 330:	892a                	mv	s2,a0
 332:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 334:	4aa9                	li	s5,10
 336:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 338:	0019849b          	addiw	s1,s3,1
 33c:	0344d863          	ble	s4,s1,36c <gets+0x56>
    cc = read(0, &c, 1);
 340:	4605                	li	a2,1
 342:	faf40593          	addi	a1,s0,-81
 346:	4501                	li	a0,0
 348:	00000097          	auipc	ra,0x0
 34c:	1ac080e7          	jalr	428(ra) # 4f4 <read>
    if(cc < 1)
 350:	00a05e63          	blez	a0,36c <gets+0x56>
    buf[i++] = c;
 354:	faf44783          	lbu	a5,-81(s0)
 358:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 35c:	01578763          	beq	a5,s5,36a <gets+0x54>
 360:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 362:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 364:	fd679ae3          	bne	a5,s6,338 <gets+0x22>
 368:	a011                	j	36c <gets+0x56>
  for(i=0; i+1 < max; ){
 36a:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 36c:	99de                	add	s3,s3,s7
 36e:	00098023          	sb	zero,0(s3)
  return buf;
}
 372:	855e                	mv	a0,s7
 374:	60e6                	ld	ra,88(sp)
 376:	6446                	ld	s0,80(sp)
 378:	64a6                	ld	s1,72(sp)
 37a:	6906                	ld	s2,64(sp)
 37c:	79e2                	ld	s3,56(sp)
 37e:	7a42                	ld	s4,48(sp)
 380:	7aa2                	ld	s5,40(sp)
 382:	7b02                	ld	s6,32(sp)
 384:	6be2                	ld	s7,24(sp)
 386:	6125                	addi	sp,sp,96
 388:	8082                	ret

000000000000038a <stat>:

int
stat(const char *n, struct stat *st)
{
 38a:	1101                	addi	sp,sp,-32
 38c:	ec06                	sd	ra,24(sp)
 38e:	e822                	sd	s0,16(sp)
 390:	e426                	sd	s1,8(sp)
 392:	e04a                	sd	s2,0(sp)
 394:	1000                	addi	s0,sp,32
 396:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 398:	4581                	li	a1,0
 39a:	00000097          	auipc	ra,0x0
 39e:	182080e7          	jalr	386(ra) # 51c <open>
  if(fd < 0)
 3a2:	02054563          	bltz	a0,3cc <stat+0x42>
 3a6:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 3a8:	85ca                	mv	a1,s2
 3aa:	00000097          	auipc	ra,0x0
 3ae:	18a080e7          	jalr	394(ra) # 534 <fstat>
 3b2:	892a                	mv	s2,a0
  close(fd);
 3b4:	8526                	mv	a0,s1
 3b6:	00000097          	auipc	ra,0x0
 3ba:	14e080e7          	jalr	334(ra) # 504 <close>
  return r;
}
 3be:	854a                	mv	a0,s2
 3c0:	60e2                	ld	ra,24(sp)
 3c2:	6442                	ld	s0,16(sp)
 3c4:	64a2                	ld	s1,8(sp)
 3c6:	6902                	ld	s2,0(sp)
 3c8:	6105                	addi	sp,sp,32
 3ca:	8082                	ret
    return -1;
 3cc:	597d                	li	s2,-1
 3ce:	bfc5                	j	3be <stat+0x34>

00000000000003d0 <atoi>:

int
atoi(const char *s)
{
 3d0:	1141                	addi	sp,sp,-16
 3d2:	e422                	sd	s0,8(sp)
 3d4:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3d6:	00054683          	lbu	a3,0(a0)
 3da:	fd06879b          	addiw	a5,a3,-48
 3de:	0ff7f793          	andi	a5,a5,255
 3e2:	4725                	li	a4,9
 3e4:	02f76963          	bltu	a4,a5,416 <atoi+0x46>
 3e8:	862a                	mv	a2,a0
  n = 0;
 3ea:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 3ec:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 3ee:	0605                	addi	a2,a2,1
 3f0:	0025179b          	slliw	a5,a0,0x2
 3f4:	9fa9                	addw	a5,a5,a0
 3f6:	0017979b          	slliw	a5,a5,0x1
 3fa:	9fb5                	addw	a5,a5,a3
 3fc:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 400:	00064683          	lbu	a3,0(a2)
 404:	fd06871b          	addiw	a4,a3,-48
 408:	0ff77713          	andi	a4,a4,255
 40c:	fee5f1e3          	bleu	a4,a1,3ee <atoi+0x1e>
  return n;
}
 410:	6422                	ld	s0,8(sp)
 412:	0141                	addi	sp,sp,16
 414:	8082                	ret
  n = 0;
 416:	4501                	li	a0,0
 418:	bfe5                	j	410 <atoi+0x40>

000000000000041a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 41a:	1141                	addi	sp,sp,-16
 41c:	e422                	sd	s0,8(sp)
 41e:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 420:	02b57663          	bleu	a1,a0,44c <memmove+0x32>
    while(n-- > 0)
 424:	02c05163          	blez	a2,446 <memmove+0x2c>
 428:	fff6079b          	addiw	a5,a2,-1
 42c:	1782                	slli	a5,a5,0x20
 42e:	9381                	srli	a5,a5,0x20
 430:	0785                	addi	a5,a5,1
 432:	97aa                	add	a5,a5,a0
  dst = vdst;
 434:	872a                	mv	a4,a0
      *dst++ = *src++;
 436:	0585                	addi	a1,a1,1
 438:	0705                	addi	a4,a4,1
 43a:	fff5c683          	lbu	a3,-1(a1)
 43e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 442:	fee79ae3          	bne	a5,a4,436 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 446:	6422                	ld	s0,8(sp)
 448:	0141                	addi	sp,sp,16
 44a:	8082                	ret
    dst += n;
 44c:	00c50733          	add	a4,a0,a2
    src += n;
 450:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 452:	fec05ae3          	blez	a2,446 <memmove+0x2c>
 456:	fff6079b          	addiw	a5,a2,-1
 45a:	1782                	slli	a5,a5,0x20
 45c:	9381                	srli	a5,a5,0x20
 45e:	fff7c793          	not	a5,a5
 462:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 464:	15fd                	addi	a1,a1,-1
 466:	177d                	addi	a4,a4,-1
 468:	0005c683          	lbu	a3,0(a1)
 46c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 470:	fef71ae3          	bne	a4,a5,464 <memmove+0x4a>
 474:	bfc9                	j	446 <memmove+0x2c>

0000000000000476 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 476:	1141                	addi	sp,sp,-16
 478:	e422                	sd	s0,8(sp)
 47a:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 47c:	ce15                	beqz	a2,4b8 <memcmp+0x42>
 47e:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
 482:	00054783          	lbu	a5,0(a0)
 486:	0005c703          	lbu	a4,0(a1)
 48a:	02e79063          	bne	a5,a4,4aa <memcmp+0x34>
 48e:	1682                	slli	a3,a3,0x20
 490:	9281                	srli	a3,a3,0x20
 492:	0685                	addi	a3,a3,1
 494:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
 496:	0505                	addi	a0,a0,1
    p2++;
 498:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 49a:	00d50d63          	beq	a0,a3,4b4 <memcmp+0x3e>
    if (*p1 != *p2) {
 49e:	00054783          	lbu	a5,0(a0)
 4a2:	0005c703          	lbu	a4,0(a1)
 4a6:	fee788e3          	beq	a5,a4,496 <memcmp+0x20>
      return *p1 - *p2;
 4aa:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
 4ae:	6422                	ld	s0,8(sp)
 4b0:	0141                	addi	sp,sp,16
 4b2:	8082                	ret
  return 0;
 4b4:	4501                	li	a0,0
 4b6:	bfe5                	j	4ae <memcmp+0x38>
 4b8:	4501                	li	a0,0
 4ba:	bfd5                	j	4ae <memcmp+0x38>

00000000000004bc <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4bc:	1141                	addi	sp,sp,-16
 4be:	e406                	sd	ra,8(sp)
 4c0:	e022                	sd	s0,0(sp)
 4c2:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 4c4:	00000097          	auipc	ra,0x0
 4c8:	f56080e7          	jalr	-170(ra) # 41a <memmove>
}
 4cc:	60a2                	ld	ra,8(sp)
 4ce:	6402                	ld	s0,0(sp)
 4d0:	0141                	addi	sp,sp,16
 4d2:	8082                	ret

00000000000004d4 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 4d4:	4885                	li	a7,1
 ecall
 4d6:	00000073          	ecall
 ret
 4da:	8082                	ret

00000000000004dc <exit>:
.global exit
exit:
 li a7, SYS_exit
 4dc:	4889                	li	a7,2
 ecall
 4de:	00000073          	ecall
 ret
 4e2:	8082                	ret

00000000000004e4 <wait>:
.global wait
wait:
 li a7, SYS_wait
 4e4:	488d                	li	a7,3
 ecall
 4e6:	00000073          	ecall
 ret
 4ea:	8082                	ret

00000000000004ec <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 4ec:	4891                	li	a7,4
 ecall
 4ee:	00000073          	ecall
 ret
 4f2:	8082                	ret

00000000000004f4 <read>:
.global read
read:
 li a7, SYS_read
 4f4:	4895                	li	a7,5
 ecall
 4f6:	00000073          	ecall
 ret
 4fa:	8082                	ret

00000000000004fc <write>:
.global write
write:
 li a7, SYS_write
 4fc:	48c1                	li	a7,16
 ecall
 4fe:	00000073          	ecall
 ret
 502:	8082                	ret

0000000000000504 <close>:
.global close
close:
 li a7, SYS_close
 504:	48d5                	li	a7,21
 ecall
 506:	00000073          	ecall
 ret
 50a:	8082                	ret

000000000000050c <kill>:
.global kill
kill:
 li a7, SYS_kill
 50c:	4899                	li	a7,6
 ecall
 50e:	00000073          	ecall
 ret
 512:	8082                	ret

0000000000000514 <exec>:
.global exec
exec:
 li a7, SYS_exec
 514:	489d                	li	a7,7
 ecall
 516:	00000073          	ecall
 ret
 51a:	8082                	ret

000000000000051c <open>:
.global open
open:
 li a7, SYS_open
 51c:	48bd                	li	a7,15
 ecall
 51e:	00000073          	ecall
 ret
 522:	8082                	ret

0000000000000524 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 524:	48c5                	li	a7,17
 ecall
 526:	00000073          	ecall
 ret
 52a:	8082                	ret

000000000000052c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 52c:	48c9                	li	a7,18
 ecall
 52e:	00000073          	ecall
 ret
 532:	8082                	ret

0000000000000534 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 534:	48a1                	li	a7,8
 ecall
 536:	00000073          	ecall
 ret
 53a:	8082                	ret

000000000000053c <link>:
.global link
link:
 li a7, SYS_link
 53c:	48cd                	li	a7,19
 ecall
 53e:	00000073          	ecall
 ret
 542:	8082                	ret

0000000000000544 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 544:	48d1                	li	a7,20
 ecall
 546:	00000073          	ecall
 ret
 54a:	8082                	ret

000000000000054c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 54c:	48a5                	li	a7,9
 ecall
 54e:	00000073          	ecall
 ret
 552:	8082                	ret

0000000000000554 <dup>:
.global dup
dup:
 li a7, SYS_dup
 554:	48a9                	li	a7,10
 ecall
 556:	00000073          	ecall
 ret
 55a:	8082                	ret

000000000000055c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 55c:	48ad                	li	a7,11
 ecall
 55e:	00000073          	ecall
 ret
 562:	8082                	ret

0000000000000564 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 564:	48b1                	li	a7,12
 ecall
 566:	00000073          	ecall
 ret
 56a:	8082                	ret

000000000000056c <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 56c:	48b5                	li	a7,13
 ecall
 56e:	00000073          	ecall
 ret
 572:	8082                	ret

0000000000000574 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 574:	48b9                	li	a7,14
 ecall
 576:	00000073          	ecall
 ret
 57a:	8082                	ret

000000000000057c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 57c:	1101                	addi	sp,sp,-32
 57e:	ec06                	sd	ra,24(sp)
 580:	e822                	sd	s0,16(sp)
 582:	1000                	addi	s0,sp,32
 584:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 588:	4605                	li	a2,1
 58a:	fef40593          	addi	a1,s0,-17
 58e:	00000097          	auipc	ra,0x0
 592:	f6e080e7          	jalr	-146(ra) # 4fc <write>
}
 596:	60e2                	ld	ra,24(sp)
 598:	6442                	ld	s0,16(sp)
 59a:	6105                	addi	sp,sp,32
 59c:	8082                	ret

000000000000059e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 59e:	7139                	addi	sp,sp,-64
 5a0:	fc06                	sd	ra,56(sp)
 5a2:	f822                	sd	s0,48(sp)
 5a4:	f426                	sd	s1,40(sp)
 5a6:	f04a                	sd	s2,32(sp)
 5a8:	ec4e                	sd	s3,24(sp)
 5aa:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5ac:	c299                	beqz	a3,5b2 <printint+0x14>
 5ae:	0005cd63          	bltz	a1,5c8 <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 5b2:	2581                	sext.w	a1,a1
  neg = 0;
 5b4:	4301                	li	t1,0
 5b6:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 5ba:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 5bc:	2601                	sext.w	a2,a2
 5be:	00000897          	auipc	a7,0x0
 5c2:	50a88893          	addi	a7,a7,1290 # ac8 <digits>
 5c6:	a801                	j	5d6 <printint+0x38>
    x = -xx;
 5c8:	40b005bb          	negw	a1,a1
 5cc:	2581                	sext.w	a1,a1
    neg = 1;
 5ce:	4305                	li	t1,1
    x = -xx;
 5d0:	b7dd                	j	5b6 <printint+0x18>
  }while((x /= base) != 0);
 5d2:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 5d4:	8836                	mv	a6,a3
 5d6:	0018069b          	addiw	a3,a6,1
 5da:	02c5f7bb          	remuw	a5,a1,a2
 5de:	1782                	slli	a5,a5,0x20
 5e0:	9381                	srli	a5,a5,0x20
 5e2:	97c6                	add	a5,a5,a7
 5e4:	0007c783          	lbu	a5,0(a5)
 5e8:	00f70023          	sb	a5,0(a4)
  }while((x /= base) != 0);
 5ec:	0705                	addi	a4,a4,1
 5ee:	02c5d7bb          	divuw	a5,a1,a2
 5f2:	fec5f0e3          	bleu	a2,a1,5d2 <printint+0x34>
  if(neg)
 5f6:	00030b63          	beqz	t1,60c <printint+0x6e>
    buf[i++] = '-';
 5fa:	fd040793          	addi	a5,s0,-48
 5fe:	96be                	add	a3,a3,a5
 600:	02d00793          	li	a5,45
 604:	fef68823          	sb	a5,-16(a3)
 608:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 60c:	02d05963          	blez	a3,63e <printint+0xa0>
 610:	89aa                	mv	s3,a0
 612:	fc040793          	addi	a5,s0,-64
 616:	00d784b3          	add	s1,a5,a3
 61a:	fff78913          	addi	s2,a5,-1
 61e:	9936                	add	s2,s2,a3
 620:	36fd                	addiw	a3,a3,-1
 622:	1682                	slli	a3,a3,0x20
 624:	9281                	srli	a3,a3,0x20
 626:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 62a:	fff4c583          	lbu	a1,-1(s1)
 62e:	854e                	mv	a0,s3
 630:	00000097          	auipc	ra,0x0
 634:	f4c080e7          	jalr	-180(ra) # 57c <putc>
  while(--i >= 0)
 638:	14fd                	addi	s1,s1,-1
 63a:	ff2498e3          	bne	s1,s2,62a <printint+0x8c>
}
 63e:	70e2                	ld	ra,56(sp)
 640:	7442                	ld	s0,48(sp)
 642:	74a2                	ld	s1,40(sp)
 644:	7902                	ld	s2,32(sp)
 646:	69e2                	ld	s3,24(sp)
 648:	6121                	addi	sp,sp,64
 64a:	8082                	ret

000000000000064c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 64c:	7119                	addi	sp,sp,-128
 64e:	fc86                	sd	ra,120(sp)
 650:	f8a2                	sd	s0,112(sp)
 652:	f4a6                	sd	s1,104(sp)
 654:	f0ca                	sd	s2,96(sp)
 656:	ecce                	sd	s3,88(sp)
 658:	e8d2                	sd	s4,80(sp)
 65a:	e4d6                	sd	s5,72(sp)
 65c:	e0da                	sd	s6,64(sp)
 65e:	fc5e                	sd	s7,56(sp)
 660:	f862                	sd	s8,48(sp)
 662:	f466                	sd	s9,40(sp)
 664:	f06a                	sd	s10,32(sp)
 666:	ec6e                	sd	s11,24(sp)
 668:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 66a:	0005c483          	lbu	s1,0(a1)
 66e:	18048d63          	beqz	s1,808 <vprintf+0x1bc>
 672:	8aaa                	mv	s5,a0
 674:	8b32                	mv	s6,a2
 676:	00158913          	addi	s2,a1,1
  state = 0;
 67a:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 67c:	02500a13          	li	s4,37
      if(c == 'd'){
 680:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 684:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 688:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 68c:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 690:	00000b97          	auipc	s7,0x0
 694:	438b8b93          	addi	s7,s7,1080 # ac8 <digits>
 698:	a839                	j	6b6 <vprintf+0x6a>
        putc(fd, c);
 69a:	85a6                	mv	a1,s1
 69c:	8556                	mv	a0,s5
 69e:	00000097          	auipc	ra,0x0
 6a2:	ede080e7          	jalr	-290(ra) # 57c <putc>
 6a6:	a019                	j	6ac <vprintf+0x60>
    } else if(state == '%'){
 6a8:	01498f63          	beq	s3,s4,6c6 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 6ac:	0905                	addi	s2,s2,1
 6ae:	fff94483          	lbu	s1,-1(s2)
 6b2:	14048b63          	beqz	s1,808 <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 6b6:	0004879b          	sext.w	a5,s1
    if(state == 0){
 6ba:	fe0997e3          	bnez	s3,6a8 <vprintf+0x5c>
      if(c == '%'){
 6be:	fd479ee3          	bne	a5,s4,69a <vprintf+0x4e>
        state = '%';
 6c2:	89be                	mv	s3,a5
 6c4:	b7e5                	j	6ac <vprintf+0x60>
      if(c == 'd'){
 6c6:	05878063          	beq	a5,s8,706 <vprintf+0xba>
      } else if(c == 'l') {
 6ca:	05978c63          	beq	a5,s9,722 <vprintf+0xd6>
      } else if(c == 'x') {
 6ce:	07a78863          	beq	a5,s10,73e <vprintf+0xf2>
      } else if(c == 'p') {
 6d2:	09b78463          	beq	a5,s11,75a <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 6d6:	07300713          	li	a4,115
 6da:	0ce78563          	beq	a5,a4,7a4 <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6de:	06300713          	li	a4,99
 6e2:	0ee78c63          	beq	a5,a4,7da <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 6e6:	11478663          	beq	a5,s4,7f2 <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6ea:	85d2                	mv	a1,s4
 6ec:	8556                	mv	a0,s5
 6ee:	00000097          	auipc	ra,0x0
 6f2:	e8e080e7          	jalr	-370(ra) # 57c <putc>
        putc(fd, c);
 6f6:	85a6                	mv	a1,s1
 6f8:	8556                	mv	a0,s5
 6fa:	00000097          	auipc	ra,0x0
 6fe:	e82080e7          	jalr	-382(ra) # 57c <putc>
      }
      state = 0;
 702:	4981                	li	s3,0
 704:	b765                	j	6ac <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 706:	008b0493          	addi	s1,s6,8
 70a:	4685                	li	a3,1
 70c:	4629                	li	a2,10
 70e:	000b2583          	lw	a1,0(s6)
 712:	8556                	mv	a0,s5
 714:	00000097          	auipc	ra,0x0
 718:	e8a080e7          	jalr	-374(ra) # 59e <printint>
 71c:	8b26                	mv	s6,s1
      state = 0;
 71e:	4981                	li	s3,0
 720:	b771                	j	6ac <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 722:	008b0493          	addi	s1,s6,8
 726:	4681                	li	a3,0
 728:	4629                	li	a2,10
 72a:	000b2583          	lw	a1,0(s6)
 72e:	8556                	mv	a0,s5
 730:	00000097          	auipc	ra,0x0
 734:	e6e080e7          	jalr	-402(ra) # 59e <printint>
 738:	8b26                	mv	s6,s1
      state = 0;
 73a:	4981                	li	s3,0
 73c:	bf85                	j	6ac <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 73e:	008b0493          	addi	s1,s6,8
 742:	4681                	li	a3,0
 744:	4641                	li	a2,16
 746:	000b2583          	lw	a1,0(s6)
 74a:	8556                	mv	a0,s5
 74c:	00000097          	auipc	ra,0x0
 750:	e52080e7          	jalr	-430(ra) # 59e <printint>
 754:	8b26                	mv	s6,s1
      state = 0;
 756:	4981                	li	s3,0
 758:	bf91                	j	6ac <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 75a:	008b0793          	addi	a5,s6,8
 75e:	f8f43423          	sd	a5,-120(s0)
 762:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 766:	03000593          	li	a1,48
 76a:	8556                	mv	a0,s5
 76c:	00000097          	auipc	ra,0x0
 770:	e10080e7          	jalr	-496(ra) # 57c <putc>
  putc(fd, 'x');
 774:	85ea                	mv	a1,s10
 776:	8556                	mv	a0,s5
 778:	00000097          	auipc	ra,0x0
 77c:	e04080e7          	jalr	-508(ra) # 57c <putc>
 780:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 782:	03c9d793          	srli	a5,s3,0x3c
 786:	97de                	add	a5,a5,s7
 788:	0007c583          	lbu	a1,0(a5)
 78c:	8556                	mv	a0,s5
 78e:	00000097          	auipc	ra,0x0
 792:	dee080e7          	jalr	-530(ra) # 57c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 796:	0992                	slli	s3,s3,0x4
 798:	34fd                	addiw	s1,s1,-1
 79a:	f4e5                	bnez	s1,782 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 79c:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 7a0:	4981                	li	s3,0
 7a2:	b729                	j	6ac <vprintf+0x60>
        s = va_arg(ap, char*);
 7a4:	008b0993          	addi	s3,s6,8
 7a8:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 7ac:	c085                	beqz	s1,7cc <vprintf+0x180>
        while(*s != 0){
 7ae:	0004c583          	lbu	a1,0(s1)
 7b2:	c9a1                	beqz	a1,802 <vprintf+0x1b6>
          putc(fd, *s);
 7b4:	8556                	mv	a0,s5
 7b6:	00000097          	auipc	ra,0x0
 7ba:	dc6080e7          	jalr	-570(ra) # 57c <putc>
          s++;
 7be:	0485                	addi	s1,s1,1
        while(*s != 0){
 7c0:	0004c583          	lbu	a1,0(s1)
 7c4:	f9e5                	bnez	a1,7b4 <vprintf+0x168>
        s = va_arg(ap, char*);
 7c6:	8b4e                	mv	s6,s3
      state = 0;
 7c8:	4981                	li	s3,0
 7ca:	b5cd                	j	6ac <vprintf+0x60>
          s = "(null)";
 7cc:	00000497          	auipc	s1,0x0
 7d0:	31448493          	addi	s1,s1,788 # ae0 <digits+0x18>
        while(*s != 0){
 7d4:	02800593          	li	a1,40
 7d8:	bff1                	j	7b4 <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 7da:	008b0493          	addi	s1,s6,8
 7de:	000b4583          	lbu	a1,0(s6)
 7e2:	8556                	mv	a0,s5
 7e4:	00000097          	auipc	ra,0x0
 7e8:	d98080e7          	jalr	-616(ra) # 57c <putc>
 7ec:	8b26                	mv	s6,s1
      state = 0;
 7ee:	4981                	li	s3,0
 7f0:	bd75                	j	6ac <vprintf+0x60>
        putc(fd, c);
 7f2:	85d2                	mv	a1,s4
 7f4:	8556                	mv	a0,s5
 7f6:	00000097          	auipc	ra,0x0
 7fa:	d86080e7          	jalr	-634(ra) # 57c <putc>
      state = 0;
 7fe:	4981                	li	s3,0
 800:	b575                	j	6ac <vprintf+0x60>
        s = va_arg(ap, char*);
 802:	8b4e                	mv	s6,s3
      state = 0;
 804:	4981                	li	s3,0
 806:	b55d                	j	6ac <vprintf+0x60>
    }
  }
}
 808:	70e6                	ld	ra,120(sp)
 80a:	7446                	ld	s0,112(sp)
 80c:	74a6                	ld	s1,104(sp)
 80e:	7906                	ld	s2,96(sp)
 810:	69e6                	ld	s3,88(sp)
 812:	6a46                	ld	s4,80(sp)
 814:	6aa6                	ld	s5,72(sp)
 816:	6b06                	ld	s6,64(sp)
 818:	7be2                	ld	s7,56(sp)
 81a:	7c42                	ld	s8,48(sp)
 81c:	7ca2                	ld	s9,40(sp)
 81e:	7d02                	ld	s10,32(sp)
 820:	6de2                	ld	s11,24(sp)
 822:	6109                	addi	sp,sp,128
 824:	8082                	ret

0000000000000826 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 826:	715d                	addi	sp,sp,-80
 828:	ec06                	sd	ra,24(sp)
 82a:	e822                	sd	s0,16(sp)
 82c:	1000                	addi	s0,sp,32
 82e:	e010                	sd	a2,0(s0)
 830:	e414                	sd	a3,8(s0)
 832:	e818                	sd	a4,16(s0)
 834:	ec1c                	sd	a5,24(s0)
 836:	03043023          	sd	a6,32(s0)
 83a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 83e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 842:	8622                	mv	a2,s0
 844:	00000097          	auipc	ra,0x0
 848:	e08080e7          	jalr	-504(ra) # 64c <vprintf>
}
 84c:	60e2                	ld	ra,24(sp)
 84e:	6442                	ld	s0,16(sp)
 850:	6161                	addi	sp,sp,80
 852:	8082                	ret

0000000000000854 <printf>:

void
printf(const char *fmt, ...)
{
 854:	711d                	addi	sp,sp,-96
 856:	ec06                	sd	ra,24(sp)
 858:	e822                	sd	s0,16(sp)
 85a:	1000                	addi	s0,sp,32
 85c:	e40c                	sd	a1,8(s0)
 85e:	e810                	sd	a2,16(s0)
 860:	ec14                	sd	a3,24(s0)
 862:	f018                	sd	a4,32(s0)
 864:	f41c                	sd	a5,40(s0)
 866:	03043823          	sd	a6,48(s0)
 86a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 86e:	00840613          	addi	a2,s0,8
 872:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 876:	85aa                	mv	a1,a0
 878:	4505                	li	a0,1
 87a:	00000097          	auipc	ra,0x0
 87e:	dd2080e7          	jalr	-558(ra) # 64c <vprintf>
}
 882:	60e2                	ld	ra,24(sp)
 884:	6442                	ld	s0,16(sp)
 886:	6125                	addi	sp,sp,96
 888:	8082                	ret

000000000000088a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 88a:	1141                	addi	sp,sp,-16
 88c:	e422                	sd	s0,8(sp)
 88e:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 890:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 894:	00000797          	auipc	a5,0x0
 898:	25478793          	addi	a5,a5,596 # ae8 <__bss_start>
 89c:	639c                	ld	a5,0(a5)
 89e:	a805                	j	8ce <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8a0:	4618                	lw	a4,8(a2)
 8a2:	9db9                	addw	a1,a1,a4
 8a4:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8a8:	6398                	ld	a4,0(a5)
 8aa:	6318                	ld	a4,0(a4)
 8ac:	fee53823          	sd	a4,-16(a0)
 8b0:	a091                	j	8f4 <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8b2:	ff852703          	lw	a4,-8(a0)
 8b6:	9e39                	addw	a2,a2,a4
 8b8:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 8ba:	ff053703          	ld	a4,-16(a0)
 8be:	e398                	sd	a4,0(a5)
 8c0:	a099                	j	906 <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8c2:	6398                	ld	a4,0(a5)
 8c4:	00e7e463          	bltu	a5,a4,8cc <free+0x42>
 8c8:	00e6ea63          	bltu	a3,a4,8dc <free+0x52>
{
 8cc:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8ce:	fed7fae3          	bleu	a3,a5,8c2 <free+0x38>
 8d2:	6398                	ld	a4,0(a5)
 8d4:	00e6e463          	bltu	a3,a4,8dc <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8d8:	fee7eae3          	bltu	a5,a4,8cc <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 8dc:	ff852583          	lw	a1,-8(a0)
 8e0:	6390                	ld	a2,0(a5)
 8e2:	02059713          	slli	a4,a1,0x20
 8e6:	9301                	srli	a4,a4,0x20
 8e8:	0712                	slli	a4,a4,0x4
 8ea:	9736                	add	a4,a4,a3
 8ec:	fae60ae3          	beq	a2,a4,8a0 <free+0x16>
    bp->s.ptr = p->s.ptr;
 8f0:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8f4:	4790                	lw	a2,8(a5)
 8f6:	02061713          	slli	a4,a2,0x20
 8fa:	9301                	srli	a4,a4,0x20
 8fc:	0712                	slli	a4,a4,0x4
 8fe:	973e                	add	a4,a4,a5
 900:	fae689e3          	beq	a3,a4,8b2 <free+0x28>
  } else
    p->s.ptr = bp;
 904:	e394                	sd	a3,0(a5)
  freep = p;
 906:	00000717          	auipc	a4,0x0
 90a:	1ef73123          	sd	a5,482(a4) # ae8 <__bss_start>
}
 90e:	6422                	ld	s0,8(sp)
 910:	0141                	addi	sp,sp,16
 912:	8082                	ret

0000000000000914 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 914:	7139                	addi	sp,sp,-64
 916:	fc06                	sd	ra,56(sp)
 918:	f822                	sd	s0,48(sp)
 91a:	f426                	sd	s1,40(sp)
 91c:	f04a                	sd	s2,32(sp)
 91e:	ec4e                	sd	s3,24(sp)
 920:	e852                	sd	s4,16(sp)
 922:	e456                	sd	s5,8(sp)
 924:	e05a                	sd	s6,0(sp)
 926:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 928:	02051993          	slli	s3,a0,0x20
 92c:	0209d993          	srli	s3,s3,0x20
 930:	09bd                	addi	s3,s3,15
 932:	0049d993          	srli	s3,s3,0x4
 936:	2985                	addiw	s3,s3,1
 938:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 93c:	00000797          	auipc	a5,0x0
 940:	1ac78793          	addi	a5,a5,428 # ae8 <__bss_start>
 944:	6388                	ld	a0,0(a5)
 946:	c515                	beqz	a0,972 <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 948:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 94a:	4798                	lw	a4,8(a5)
 94c:	03277f63          	bleu	s2,a4,98a <malloc+0x76>
 950:	8a4e                	mv	s4,s3
 952:	0009871b          	sext.w	a4,s3
 956:	6685                	lui	a3,0x1
 958:	00d77363          	bleu	a3,a4,95e <malloc+0x4a>
 95c:	6a05                	lui	s4,0x1
 95e:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 962:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 966:	00000497          	auipc	s1,0x0
 96a:	18248493          	addi	s1,s1,386 # ae8 <__bss_start>
  if(p == (char*)-1)
 96e:	5b7d                	li	s6,-1
 970:	a885                	j	9e0 <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 972:	00000797          	auipc	a5,0x0
 976:	17e78793          	addi	a5,a5,382 # af0 <base>
 97a:	00000717          	auipc	a4,0x0
 97e:	16f73723          	sd	a5,366(a4) # ae8 <__bss_start>
 982:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 984:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 988:	b7e1                	j	950 <malloc+0x3c>
      if(p->s.size == nunits)
 98a:	02e90b63          	beq	s2,a4,9c0 <malloc+0xac>
        p->s.size -= nunits;
 98e:	4137073b          	subw	a4,a4,s3
 992:	c798                	sw	a4,8(a5)
        p += p->s.size;
 994:	1702                	slli	a4,a4,0x20
 996:	9301                	srli	a4,a4,0x20
 998:	0712                	slli	a4,a4,0x4
 99a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 99c:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9a0:	00000717          	auipc	a4,0x0
 9a4:	14a73423          	sd	a0,328(a4) # ae8 <__bss_start>
      return (void*)(p + 1);
 9a8:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 9ac:	70e2                	ld	ra,56(sp)
 9ae:	7442                	ld	s0,48(sp)
 9b0:	74a2                	ld	s1,40(sp)
 9b2:	7902                	ld	s2,32(sp)
 9b4:	69e2                	ld	s3,24(sp)
 9b6:	6a42                	ld	s4,16(sp)
 9b8:	6aa2                	ld	s5,8(sp)
 9ba:	6b02                	ld	s6,0(sp)
 9bc:	6121                	addi	sp,sp,64
 9be:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 9c0:	6398                	ld	a4,0(a5)
 9c2:	e118                	sd	a4,0(a0)
 9c4:	bff1                	j	9a0 <malloc+0x8c>
  hp->s.size = nu;
 9c6:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 9ca:	0541                	addi	a0,a0,16
 9cc:	00000097          	auipc	ra,0x0
 9d0:	ebe080e7          	jalr	-322(ra) # 88a <free>
  return freep;
 9d4:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 9d6:	d979                	beqz	a0,9ac <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9d8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9da:	4798                	lw	a4,8(a5)
 9dc:	fb2777e3          	bleu	s2,a4,98a <malloc+0x76>
    if(p == freep)
 9e0:	6098                	ld	a4,0(s1)
 9e2:	853e                	mv	a0,a5
 9e4:	fef71ae3          	bne	a4,a5,9d8 <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 9e8:	8552                	mv	a0,s4
 9ea:	00000097          	auipc	ra,0x0
 9ee:	b7a080e7          	jalr	-1158(ra) # 564 <sbrk>
  if(p == (char*)-1)
 9f2:	fd651ae3          	bne	a0,s6,9c6 <malloc+0xb2>
        return 0;
 9f6:	4501                	li	a0,0
 9f8:	bf55                	j	9ac <malloc+0x98>
