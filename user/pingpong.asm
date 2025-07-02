
user/_pingpong：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user.h"

int 
main(int argc, char* argv[])
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	1800                	addi	s0,sp,48
    if(argc >= 2) {
   8:	4785                	li	a5,1
   a:	02a7d063          	ble	a0,a5,2a <main+0x2a>
        fprintf(2, "Usage: pingpong\n");
   e:	00001597          	auipc	a1,0x1
  12:	96258593          	addi	a1,a1,-1694 # 970 <malloc+0xec>
  16:	4509                	li	a0,2
  18:	00000097          	auipc	ra,0x0
  1c:	77e080e7          	jalr	1918(ra) # 796 <fprintf>
        exit(1);
  20:	4505                	li	a0,1
  22:	00000097          	auipc	ra,0x0
  26:	42a080e7          	jalr	1066(ra) # 44c <exit>
    }
    int p1[2];
    int p2[2];

    pipe(p1);
  2a:	fe840513          	addi	a0,s0,-24
  2e:	00000097          	auipc	ra,0x0
  32:	42e080e7          	jalr	1070(ra) # 45c <pipe>
    pipe(p2);
  36:	fe040513          	addi	a0,s0,-32
  3a:	00000097          	auipc	ra,0x0
  3e:	422080e7          	jalr	1058(ra) # 45c <pipe>

    if(fork() == 0) {
  42:	00000097          	auipc	ra,0x0
  46:	402080e7          	jalr	1026(ra) # 444 <fork>
  4a:	ed4d                	bnez	a0,104 <main+0x104>
        //child
        char ch;
        int ret;
        close(p1[1]);
  4c:	fec42503          	lw	a0,-20(s0)
  50:	00000097          	auipc	ra,0x0
  54:	424080e7          	jalr	1060(ra) # 474 <close>
        close(p2[0]);
  58:	fe042503          	lw	a0,-32(s0)
  5c:	00000097          	auipc	ra,0x0
  60:	418080e7          	jalr	1048(ra) # 474 <close>
        ret = read(p1[0], &ch, (int)sizeof(char));
  64:	4605                	li	a2,1
  66:	fdf40593          	addi	a1,s0,-33
  6a:	fe842503          	lw	a0,-24(s0)
  6e:	00000097          	auipc	ra,0x0
  72:	3f6080e7          	jalr	1014(ra) # 464 <read>
        if(ret != 1) {
  76:	4785                	li	a5,1
  78:	02f50563          	beq	a0,a5,a2 <main+0xa2>
            fprintf(2, "<%d>: read char failed\n", getpid());
  7c:	00000097          	auipc	ra,0x0
  80:	450080e7          	jalr	1104(ra) # 4cc <getpid>
  84:	862a                	mv	a2,a0
  86:	00001597          	auipc	a1,0x1
  8a:	90258593          	addi	a1,a1,-1790 # 988 <malloc+0x104>
  8e:	4509                	li	a0,2
  90:	00000097          	auipc	ra,0x0
  94:	706080e7          	jalr	1798(ra) # 796 <fprintf>
            exit(1);
  98:	4505                	li	a0,1
  9a:	00000097          	auipc	ra,0x0
  9e:	3b2080e7          	jalr	946(ra) # 44c <exit>
        }
        printf("<%d>: received ping\n", getpid());
  a2:	00000097          	auipc	ra,0x0
  a6:	42a080e7          	jalr	1066(ra) # 4cc <getpid>
  aa:	85aa                	mv	a1,a0
  ac:	00001517          	auipc	a0,0x1
  b0:	8f450513          	addi	a0,a0,-1804 # 9a0 <malloc+0x11c>
  b4:	00000097          	auipc	ra,0x0
  b8:	710080e7          	jalr	1808(ra) # 7c4 <printf>
        ret = write(p2[1], &ch, (int)sizeof(char));
  bc:	4605                	li	a2,1
  be:	fdf40593          	addi	a1,s0,-33
  c2:	fe442503          	lw	a0,-28(s0)
  c6:	00000097          	auipc	ra,0x0
  ca:	3a6080e7          	jalr	934(ra) # 46c <write>
        if(ret != 1) {
  ce:	4785                	li	a5,1
  d0:	00f51763          	bne	a0,a5,de <main+0xde>
            fprintf(2, "<%d>: read char failed %s\n", getpid());
            exit(1);
        }
        printf("<%d>: received pong\n", getpid());
    }
    exit(0);
  d4:	4501                	li	a0,0
  d6:	00000097          	auipc	ra,0x0
  da:	376080e7          	jalr	886(ra) # 44c <exit>
            fprintf(2, "<%d>: write char failed\n", getpid());
  de:	00000097          	auipc	ra,0x0
  e2:	3ee080e7          	jalr	1006(ra) # 4cc <getpid>
  e6:	862a                	mv	a2,a0
  e8:	00001597          	auipc	a1,0x1
  ec:	8d058593          	addi	a1,a1,-1840 # 9b8 <malloc+0x134>
  f0:	4509                	li	a0,2
  f2:	00000097          	auipc	ra,0x0
  f6:	6a4080e7          	jalr	1700(ra) # 796 <fprintf>
            exit(1);
  fa:	4505                	li	a0,1
  fc:	00000097          	auipc	ra,0x0
 100:	350080e7          	jalr	848(ra) # 44c <exit>
        char c = 'a';
 104:	06100793          	li	a5,97
 108:	fcf40fa3          	sb	a5,-33(s0)
        close(p1[0]);
 10c:	fe842503          	lw	a0,-24(s0)
 110:	00000097          	auipc	ra,0x0
 114:	364080e7          	jalr	868(ra) # 474 <close>
        close(p2[1]);
 118:	fe442503          	lw	a0,-28(s0)
 11c:	00000097          	auipc	ra,0x0
 120:	358080e7          	jalr	856(ra) # 474 <close>
        ret = write(p1[1], &c, (int)sizeof(char));
 124:	4605                	li	a2,1
 126:	fdf40593          	addi	a1,s0,-33
 12a:	fec42503          	lw	a0,-20(s0)
 12e:	00000097          	auipc	ra,0x0
 132:	33e080e7          	jalr	830(ra) # 46c <write>
        if(ret != 1) {
 136:	4785                	li	a5,1
 138:	02f50563          	beq	a0,a5,162 <main+0x162>
            fprintf(2, "<%d>: write char failed %s\n", getpid());
 13c:	00000097          	auipc	ra,0x0
 140:	390080e7          	jalr	912(ra) # 4cc <getpid>
 144:	862a                	mv	a2,a0
 146:	00001597          	auipc	a1,0x1
 14a:	89258593          	addi	a1,a1,-1902 # 9d8 <malloc+0x154>
 14e:	4509                	li	a0,2
 150:	00000097          	auipc	ra,0x0
 154:	646080e7          	jalr	1606(ra) # 796 <fprintf>
            exit(1);
 158:	4505                	li	a0,1
 15a:	00000097          	auipc	ra,0x0
 15e:	2f2080e7          	jalr	754(ra) # 44c <exit>
        ret = read(p2[0], &c, (int)sizeof(char));
 162:	4605                	li	a2,1
 164:	fdf40593          	addi	a1,s0,-33
 168:	fe042503          	lw	a0,-32(s0)
 16c:	00000097          	auipc	ra,0x0
 170:	2f8080e7          	jalr	760(ra) # 464 <read>
        if(ret != 1) {
 174:	4785                	li	a5,1
 176:	02f50563          	beq	a0,a5,1a0 <main+0x1a0>
            fprintf(2, "<%d>: read char failed %s\n", getpid());
 17a:	00000097          	auipc	ra,0x0
 17e:	352080e7          	jalr	850(ra) # 4cc <getpid>
 182:	862a                	mv	a2,a0
 184:	00001597          	auipc	a1,0x1
 188:	87458593          	addi	a1,a1,-1932 # 9f8 <malloc+0x174>
 18c:	4509                	li	a0,2
 18e:	00000097          	auipc	ra,0x0
 192:	608080e7          	jalr	1544(ra) # 796 <fprintf>
            exit(1);
 196:	4505                	li	a0,1
 198:	00000097          	auipc	ra,0x0
 19c:	2b4080e7          	jalr	692(ra) # 44c <exit>
        printf("<%d>: received pong\n", getpid());
 1a0:	00000097          	auipc	ra,0x0
 1a4:	32c080e7          	jalr	812(ra) # 4cc <getpid>
 1a8:	85aa                	mv	a1,a0
 1aa:	00001517          	auipc	a0,0x1
 1ae:	86e50513          	addi	a0,a0,-1938 # a18 <malloc+0x194>
 1b2:	00000097          	auipc	ra,0x0
 1b6:	612080e7          	jalr	1554(ra) # 7c4 <printf>
 1ba:	bf29                	j	d4 <main+0xd4>

00000000000001bc <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 1bc:	1141                	addi	sp,sp,-16
 1be:	e422                	sd	s0,8(sp)
 1c0:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1c2:	87aa                	mv	a5,a0
 1c4:	0585                	addi	a1,a1,1
 1c6:	0785                	addi	a5,a5,1
 1c8:	fff5c703          	lbu	a4,-1(a1)
 1cc:	fee78fa3          	sb	a4,-1(a5)
 1d0:	fb75                	bnez	a4,1c4 <strcpy+0x8>
    ;
  return os;
}
 1d2:	6422                	ld	s0,8(sp)
 1d4:	0141                	addi	sp,sp,16
 1d6:	8082                	ret

00000000000001d8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1d8:	1141                	addi	sp,sp,-16
 1da:	e422                	sd	s0,8(sp)
 1dc:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 1de:	00054783          	lbu	a5,0(a0)
 1e2:	cf91                	beqz	a5,1fe <strcmp+0x26>
 1e4:	0005c703          	lbu	a4,0(a1)
 1e8:	00f71b63          	bne	a4,a5,1fe <strcmp+0x26>
    p++, q++;
 1ec:	0505                	addi	a0,a0,1
 1ee:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 1f0:	00054783          	lbu	a5,0(a0)
 1f4:	c789                	beqz	a5,1fe <strcmp+0x26>
 1f6:	0005c703          	lbu	a4,0(a1)
 1fa:	fef709e3          	beq	a4,a5,1ec <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
 1fe:	0005c503          	lbu	a0,0(a1)
}
 202:	40a7853b          	subw	a0,a5,a0
 206:	6422                	ld	s0,8(sp)
 208:	0141                	addi	sp,sp,16
 20a:	8082                	ret

000000000000020c <strlen>:

uint
strlen(const char *s)
{
 20c:	1141                	addi	sp,sp,-16
 20e:	e422                	sd	s0,8(sp)
 210:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 212:	00054783          	lbu	a5,0(a0)
 216:	cf91                	beqz	a5,232 <strlen+0x26>
 218:	0505                	addi	a0,a0,1
 21a:	87aa                	mv	a5,a0
 21c:	4685                	li	a3,1
 21e:	9e89                	subw	a3,a3,a0
 220:	00f6853b          	addw	a0,a3,a5
 224:	0785                	addi	a5,a5,1
 226:	fff7c703          	lbu	a4,-1(a5)
 22a:	fb7d                	bnez	a4,220 <strlen+0x14>
    ;
  return n;
}
 22c:	6422                	ld	s0,8(sp)
 22e:	0141                	addi	sp,sp,16
 230:	8082                	ret
  for(n = 0; s[n]; n++)
 232:	4501                	li	a0,0
 234:	bfe5                	j	22c <strlen+0x20>

0000000000000236 <memset>:

void*
memset(void *dst, int c, uint n)
{
 236:	1141                	addi	sp,sp,-16
 238:	e422                	sd	s0,8(sp)
 23a:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 23c:	ce09                	beqz	a2,256 <memset+0x20>
 23e:	87aa                	mv	a5,a0
 240:	fff6071b          	addiw	a4,a2,-1
 244:	1702                	slli	a4,a4,0x20
 246:	9301                	srli	a4,a4,0x20
 248:	0705                	addi	a4,a4,1
 24a:	972a                	add	a4,a4,a0
    cdst[i] = c;
 24c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 250:	0785                	addi	a5,a5,1
 252:	fee79de3          	bne	a5,a4,24c <memset+0x16>
  }
  return dst;
}
 256:	6422                	ld	s0,8(sp)
 258:	0141                	addi	sp,sp,16
 25a:	8082                	ret

000000000000025c <strchr>:

char*
strchr(const char *s, char c)
{
 25c:	1141                	addi	sp,sp,-16
 25e:	e422                	sd	s0,8(sp)
 260:	0800                	addi	s0,sp,16
  for(; *s; s++)
 262:	00054783          	lbu	a5,0(a0)
 266:	cf91                	beqz	a5,282 <strchr+0x26>
    if(*s == c)
 268:	00f58a63          	beq	a1,a5,27c <strchr+0x20>
  for(; *s; s++)
 26c:	0505                	addi	a0,a0,1
 26e:	00054783          	lbu	a5,0(a0)
 272:	c781                	beqz	a5,27a <strchr+0x1e>
    if(*s == c)
 274:	feb79ce3          	bne	a5,a1,26c <strchr+0x10>
 278:	a011                	j	27c <strchr+0x20>
      return (char*)s;
  return 0;
 27a:	4501                	li	a0,0
}
 27c:	6422                	ld	s0,8(sp)
 27e:	0141                	addi	sp,sp,16
 280:	8082                	ret
  return 0;
 282:	4501                	li	a0,0
 284:	bfe5                	j	27c <strchr+0x20>

0000000000000286 <gets>:

char*
gets(char *buf, int max)
{
 286:	711d                	addi	sp,sp,-96
 288:	ec86                	sd	ra,88(sp)
 28a:	e8a2                	sd	s0,80(sp)
 28c:	e4a6                	sd	s1,72(sp)
 28e:	e0ca                	sd	s2,64(sp)
 290:	fc4e                	sd	s3,56(sp)
 292:	f852                	sd	s4,48(sp)
 294:	f456                	sd	s5,40(sp)
 296:	f05a                	sd	s6,32(sp)
 298:	ec5e                	sd	s7,24(sp)
 29a:	1080                	addi	s0,sp,96
 29c:	8baa                	mv	s7,a0
 29e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2a0:	892a                	mv	s2,a0
 2a2:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 2a4:	4aa9                	li	s5,10
 2a6:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 2a8:	0019849b          	addiw	s1,s3,1
 2ac:	0344d863          	ble	s4,s1,2dc <gets+0x56>
    cc = read(0, &c, 1);
 2b0:	4605                	li	a2,1
 2b2:	faf40593          	addi	a1,s0,-81
 2b6:	4501                	li	a0,0
 2b8:	00000097          	auipc	ra,0x0
 2bc:	1ac080e7          	jalr	428(ra) # 464 <read>
    if(cc < 1)
 2c0:	00a05e63          	blez	a0,2dc <gets+0x56>
    buf[i++] = c;
 2c4:	faf44783          	lbu	a5,-81(s0)
 2c8:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 2cc:	01578763          	beq	a5,s5,2da <gets+0x54>
 2d0:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 2d2:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 2d4:	fd679ae3          	bne	a5,s6,2a8 <gets+0x22>
 2d8:	a011                	j	2dc <gets+0x56>
  for(i=0; i+1 < max; ){
 2da:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 2dc:	99de                	add	s3,s3,s7
 2de:	00098023          	sb	zero,0(s3)
  return buf;
}
 2e2:	855e                	mv	a0,s7
 2e4:	60e6                	ld	ra,88(sp)
 2e6:	6446                	ld	s0,80(sp)
 2e8:	64a6                	ld	s1,72(sp)
 2ea:	6906                	ld	s2,64(sp)
 2ec:	79e2                	ld	s3,56(sp)
 2ee:	7a42                	ld	s4,48(sp)
 2f0:	7aa2                	ld	s5,40(sp)
 2f2:	7b02                	ld	s6,32(sp)
 2f4:	6be2                	ld	s7,24(sp)
 2f6:	6125                	addi	sp,sp,96
 2f8:	8082                	ret

00000000000002fa <stat>:

int
stat(const char *n, struct stat *st)
{
 2fa:	1101                	addi	sp,sp,-32
 2fc:	ec06                	sd	ra,24(sp)
 2fe:	e822                	sd	s0,16(sp)
 300:	e426                	sd	s1,8(sp)
 302:	e04a                	sd	s2,0(sp)
 304:	1000                	addi	s0,sp,32
 306:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 308:	4581                	li	a1,0
 30a:	00000097          	auipc	ra,0x0
 30e:	182080e7          	jalr	386(ra) # 48c <open>
  if(fd < 0)
 312:	02054563          	bltz	a0,33c <stat+0x42>
 316:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 318:	85ca                	mv	a1,s2
 31a:	00000097          	auipc	ra,0x0
 31e:	18a080e7          	jalr	394(ra) # 4a4 <fstat>
 322:	892a                	mv	s2,a0
  close(fd);
 324:	8526                	mv	a0,s1
 326:	00000097          	auipc	ra,0x0
 32a:	14e080e7          	jalr	334(ra) # 474 <close>
  return r;
}
 32e:	854a                	mv	a0,s2
 330:	60e2                	ld	ra,24(sp)
 332:	6442                	ld	s0,16(sp)
 334:	64a2                	ld	s1,8(sp)
 336:	6902                	ld	s2,0(sp)
 338:	6105                	addi	sp,sp,32
 33a:	8082                	ret
    return -1;
 33c:	597d                	li	s2,-1
 33e:	bfc5                	j	32e <stat+0x34>

0000000000000340 <atoi>:

int
atoi(const char *s)
{
 340:	1141                	addi	sp,sp,-16
 342:	e422                	sd	s0,8(sp)
 344:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 346:	00054683          	lbu	a3,0(a0)
 34a:	fd06879b          	addiw	a5,a3,-48
 34e:	0ff7f793          	andi	a5,a5,255
 352:	4725                	li	a4,9
 354:	02f76963          	bltu	a4,a5,386 <atoi+0x46>
 358:	862a                	mv	a2,a0
  n = 0;
 35a:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 35c:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 35e:	0605                	addi	a2,a2,1
 360:	0025179b          	slliw	a5,a0,0x2
 364:	9fa9                	addw	a5,a5,a0
 366:	0017979b          	slliw	a5,a5,0x1
 36a:	9fb5                	addw	a5,a5,a3
 36c:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 370:	00064683          	lbu	a3,0(a2)
 374:	fd06871b          	addiw	a4,a3,-48
 378:	0ff77713          	andi	a4,a4,255
 37c:	fee5f1e3          	bleu	a4,a1,35e <atoi+0x1e>
  return n;
}
 380:	6422                	ld	s0,8(sp)
 382:	0141                	addi	sp,sp,16
 384:	8082                	ret
  n = 0;
 386:	4501                	li	a0,0
 388:	bfe5                	j	380 <atoi+0x40>

000000000000038a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 38a:	1141                	addi	sp,sp,-16
 38c:	e422                	sd	s0,8(sp)
 38e:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 390:	02b57663          	bleu	a1,a0,3bc <memmove+0x32>
    while(n-- > 0)
 394:	02c05163          	blez	a2,3b6 <memmove+0x2c>
 398:	fff6079b          	addiw	a5,a2,-1
 39c:	1782                	slli	a5,a5,0x20
 39e:	9381                	srli	a5,a5,0x20
 3a0:	0785                	addi	a5,a5,1
 3a2:	97aa                	add	a5,a5,a0
  dst = vdst;
 3a4:	872a                	mv	a4,a0
      *dst++ = *src++;
 3a6:	0585                	addi	a1,a1,1
 3a8:	0705                	addi	a4,a4,1
 3aa:	fff5c683          	lbu	a3,-1(a1)
 3ae:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 3b2:	fee79ae3          	bne	a5,a4,3a6 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 3b6:	6422                	ld	s0,8(sp)
 3b8:	0141                	addi	sp,sp,16
 3ba:	8082                	ret
    dst += n;
 3bc:	00c50733          	add	a4,a0,a2
    src += n;
 3c0:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 3c2:	fec05ae3          	blez	a2,3b6 <memmove+0x2c>
 3c6:	fff6079b          	addiw	a5,a2,-1
 3ca:	1782                	slli	a5,a5,0x20
 3cc:	9381                	srli	a5,a5,0x20
 3ce:	fff7c793          	not	a5,a5
 3d2:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 3d4:	15fd                	addi	a1,a1,-1
 3d6:	177d                	addi	a4,a4,-1
 3d8:	0005c683          	lbu	a3,0(a1)
 3dc:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 3e0:	fef71ae3          	bne	a4,a5,3d4 <memmove+0x4a>
 3e4:	bfc9                	j	3b6 <memmove+0x2c>

00000000000003e6 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 3e6:	1141                	addi	sp,sp,-16
 3e8:	e422                	sd	s0,8(sp)
 3ea:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 3ec:	ce15                	beqz	a2,428 <memcmp+0x42>
 3ee:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
 3f2:	00054783          	lbu	a5,0(a0)
 3f6:	0005c703          	lbu	a4,0(a1)
 3fa:	02e79063          	bne	a5,a4,41a <memcmp+0x34>
 3fe:	1682                	slli	a3,a3,0x20
 400:	9281                	srli	a3,a3,0x20
 402:	0685                	addi	a3,a3,1
 404:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
 406:	0505                	addi	a0,a0,1
    p2++;
 408:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 40a:	00d50d63          	beq	a0,a3,424 <memcmp+0x3e>
    if (*p1 != *p2) {
 40e:	00054783          	lbu	a5,0(a0)
 412:	0005c703          	lbu	a4,0(a1)
 416:	fee788e3          	beq	a5,a4,406 <memcmp+0x20>
      return *p1 - *p2;
 41a:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
 41e:	6422                	ld	s0,8(sp)
 420:	0141                	addi	sp,sp,16
 422:	8082                	ret
  return 0;
 424:	4501                	li	a0,0
 426:	bfe5                	j	41e <memcmp+0x38>
 428:	4501                	li	a0,0
 42a:	bfd5                	j	41e <memcmp+0x38>

000000000000042c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 42c:	1141                	addi	sp,sp,-16
 42e:	e406                	sd	ra,8(sp)
 430:	e022                	sd	s0,0(sp)
 432:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 434:	00000097          	auipc	ra,0x0
 438:	f56080e7          	jalr	-170(ra) # 38a <memmove>
}
 43c:	60a2                	ld	ra,8(sp)
 43e:	6402                	ld	s0,0(sp)
 440:	0141                	addi	sp,sp,16
 442:	8082                	ret

0000000000000444 <fork>:
 444:	4885                	li	a7,1
 446:	00000073          	ecall
 44a:	8082                	ret

000000000000044c <exit>:
 44c:	4889                	li	a7,2
 44e:	00000073          	ecall
 452:	8082                	ret

0000000000000454 <wait>:
 454:	488d                	li	a7,3
 456:	00000073          	ecall
 45a:	8082                	ret

000000000000045c <pipe>:
 45c:	4891                	li	a7,4
 45e:	00000073          	ecall
 462:	8082                	ret

0000000000000464 <read>:
 464:	4895                	li	a7,5
 466:	00000073          	ecall
 46a:	8082                	ret

000000000000046c <write>:
 46c:	48c1                	li	a7,16
 46e:	00000073          	ecall
 472:	8082                	ret

0000000000000474 <close>:
 474:	48d5                	li	a7,21
 476:	00000073          	ecall
 47a:	8082                	ret

000000000000047c <kill>:
 47c:	4899                	li	a7,6
 47e:	00000073          	ecall
 482:	8082                	ret

0000000000000484 <exec>:
 484:	489d                	li	a7,7
 486:	00000073          	ecall
 48a:	8082                	ret

000000000000048c <open>:
 48c:	48bd                	li	a7,15
 48e:	00000073          	ecall
 492:	8082                	ret

0000000000000494 <mknod>:
 494:	48c5                	li	a7,17
 496:	00000073          	ecall
 49a:	8082                	ret

000000000000049c <unlink>:
 49c:	48c9                	li	a7,18
 49e:	00000073          	ecall
 4a2:	8082                	ret

00000000000004a4 <fstat>:
 4a4:	48a1                	li	a7,8
 4a6:	00000073          	ecall
 4aa:	8082                	ret

00000000000004ac <link>:
 4ac:	48cd                	li	a7,19
 4ae:	00000073          	ecall
 4b2:	8082                	ret

00000000000004b4 <mkdir>:
 4b4:	48d1                	li	a7,20
 4b6:	00000073          	ecall
 4ba:	8082                	ret

00000000000004bc <chdir>:
 4bc:	48a5                	li	a7,9
 4be:	00000073          	ecall
 4c2:	8082                	ret

00000000000004c4 <dup>:
 4c4:	48a9                	li	a7,10
 4c6:	00000073          	ecall
 4ca:	8082                	ret

00000000000004cc <getpid>:
 4cc:	48ad                	li	a7,11
 4ce:	00000073          	ecall
 4d2:	8082                	ret

00000000000004d4 <sbrk>:
 4d4:	48b1                	li	a7,12
 4d6:	00000073          	ecall
 4da:	8082                	ret

00000000000004dc <sleep>:
 4dc:	48b5                	li	a7,13
 4de:	00000073          	ecall
 4e2:	8082                	ret

00000000000004e4 <uptime>:
 4e4:	48b9                	li	a7,14
 4e6:	00000073          	ecall
 4ea:	8082                	ret

00000000000004ec <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4ec:	1101                	addi	sp,sp,-32
 4ee:	ec06                	sd	ra,24(sp)
 4f0:	e822                	sd	s0,16(sp)
 4f2:	1000                	addi	s0,sp,32
 4f4:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4f8:	4605                	li	a2,1
 4fa:	fef40593          	addi	a1,s0,-17
 4fe:	00000097          	auipc	ra,0x0
 502:	f6e080e7          	jalr	-146(ra) # 46c <write>
}
 506:	60e2                	ld	ra,24(sp)
 508:	6442                	ld	s0,16(sp)
 50a:	6105                	addi	sp,sp,32
 50c:	8082                	ret

000000000000050e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 50e:	7139                	addi	sp,sp,-64
 510:	fc06                	sd	ra,56(sp)
 512:	f822                	sd	s0,48(sp)
 514:	f426                	sd	s1,40(sp)
 516:	f04a                	sd	s2,32(sp)
 518:	ec4e                	sd	s3,24(sp)
 51a:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 51c:	c299                	beqz	a3,522 <printint+0x14>
 51e:	0005cd63          	bltz	a1,538 <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 522:	2581                	sext.w	a1,a1
  neg = 0;
 524:	4301                	li	t1,0
 526:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 52a:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 52c:	2601                	sext.w	a2,a2
 52e:	00000897          	auipc	a7,0x0
 532:	50288893          	addi	a7,a7,1282 # a30 <digits>
 536:	a801                	j	546 <printint+0x38>
    x = -xx;
 538:	40b005bb          	negw	a1,a1
 53c:	2581                	sext.w	a1,a1
    neg = 1;
 53e:	4305                	li	t1,1
    x = -xx;
 540:	b7dd                	j	526 <printint+0x18>
  }while((x /= base) != 0);
 542:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 544:	8836                	mv	a6,a3
 546:	0018069b          	addiw	a3,a6,1
 54a:	02c5f7bb          	remuw	a5,a1,a2
 54e:	1782                	slli	a5,a5,0x20
 550:	9381                	srli	a5,a5,0x20
 552:	97c6                	add	a5,a5,a7
 554:	0007c783          	lbu	a5,0(a5)
 558:	00f70023          	sb	a5,0(a4)
  }while((x /= base) != 0);
 55c:	0705                	addi	a4,a4,1
 55e:	02c5d7bb          	divuw	a5,a1,a2
 562:	fec5f0e3          	bleu	a2,a1,542 <printint+0x34>
  if(neg)
 566:	00030b63          	beqz	t1,57c <printint+0x6e>
    buf[i++] = '-';
 56a:	fd040793          	addi	a5,s0,-48
 56e:	96be                	add	a3,a3,a5
 570:	02d00793          	li	a5,45
 574:	fef68823          	sb	a5,-16(a3)
 578:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 57c:	02d05963          	blez	a3,5ae <printint+0xa0>
 580:	89aa                	mv	s3,a0
 582:	fc040793          	addi	a5,s0,-64
 586:	00d784b3          	add	s1,a5,a3
 58a:	fff78913          	addi	s2,a5,-1
 58e:	9936                	add	s2,s2,a3
 590:	36fd                	addiw	a3,a3,-1
 592:	1682                	slli	a3,a3,0x20
 594:	9281                	srli	a3,a3,0x20
 596:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 59a:	fff4c583          	lbu	a1,-1(s1)
 59e:	854e                	mv	a0,s3
 5a0:	00000097          	auipc	ra,0x0
 5a4:	f4c080e7          	jalr	-180(ra) # 4ec <putc>
  while(--i >= 0)
 5a8:	14fd                	addi	s1,s1,-1
 5aa:	ff2498e3          	bne	s1,s2,59a <printint+0x8c>
}
 5ae:	70e2                	ld	ra,56(sp)
 5b0:	7442                	ld	s0,48(sp)
 5b2:	74a2                	ld	s1,40(sp)
 5b4:	7902                	ld	s2,32(sp)
 5b6:	69e2                	ld	s3,24(sp)
 5b8:	6121                	addi	sp,sp,64
 5ba:	8082                	ret

00000000000005bc <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5bc:	7119                	addi	sp,sp,-128
 5be:	fc86                	sd	ra,120(sp)
 5c0:	f8a2                	sd	s0,112(sp)
 5c2:	f4a6                	sd	s1,104(sp)
 5c4:	f0ca                	sd	s2,96(sp)
 5c6:	ecce                	sd	s3,88(sp)
 5c8:	e8d2                	sd	s4,80(sp)
 5ca:	e4d6                	sd	s5,72(sp)
 5cc:	e0da                	sd	s6,64(sp)
 5ce:	fc5e                	sd	s7,56(sp)
 5d0:	f862                	sd	s8,48(sp)
 5d2:	f466                	sd	s9,40(sp)
 5d4:	f06a                	sd	s10,32(sp)
 5d6:	ec6e                	sd	s11,24(sp)
 5d8:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5da:	0005c483          	lbu	s1,0(a1)
 5de:	18048d63          	beqz	s1,778 <vprintf+0x1bc>
 5e2:	8aaa                	mv	s5,a0
 5e4:	8b32                	mv	s6,a2
 5e6:	00158913          	addi	s2,a1,1
  state = 0;
 5ea:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5ec:	02500a13          	li	s4,37
      if(c == 'd'){
 5f0:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 5f4:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 5f8:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 5fc:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 600:	00000b97          	auipc	s7,0x0
 604:	430b8b93          	addi	s7,s7,1072 # a30 <digits>
 608:	a839                	j	626 <vprintf+0x6a>
        putc(fd, c);
 60a:	85a6                	mv	a1,s1
 60c:	8556                	mv	a0,s5
 60e:	00000097          	auipc	ra,0x0
 612:	ede080e7          	jalr	-290(ra) # 4ec <putc>
 616:	a019                	j	61c <vprintf+0x60>
    } else if(state == '%'){
 618:	01498f63          	beq	s3,s4,636 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 61c:	0905                	addi	s2,s2,1
 61e:	fff94483          	lbu	s1,-1(s2)
 622:	14048b63          	beqz	s1,778 <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 626:	0004879b          	sext.w	a5,s1
    if(state == 0){
 62a:	fe0997e3          	bnez	s3,618 <vprintf+0x5c>
      if(c == '%'){
 62e:	fd479ee3          	bne	a5,s4,60a <vprintf+0x4e>
        state = '%';
 632:	89be                	mv	s3,a5
 634:	b7e5                	j	61c <vprintf+0x60>
      if(c == 'd'){
 636:	05878063          	beq	a5,s8,676 <vprintf+0xba>
      } else if(c == 'l') {
 63a:	05978c63          	beq	a5,s9,692 <vprintf+0xd6>
      } else if(c == 'x') {
 63e:	07a78863          	beq	a5,s10,6ae <vprintf+0xf2>
      } else if(c == 'p') {
 642:	09b78463          	beq	a5,s11,6ca <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 646:	07300713          	li	a4,115
 64a:	0ce78563          	beq	a5,a4,714 <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 64e:	06300713          	li	a4,99
 652:	0ee78c63          	beq	a5,a4,74a <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 656:	11478663          	beq	a5,s4,762 <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 65a:	85d2                	mv	a1,s4
 65c:	8556                	mv	a0,s5
 65e:	00000097          	auipc	ra,0x0
 662:	e8e080e7          	jalr	-370(ra) # 4ec <putc>
        putc(fd, c);
 666:	85a6                	mv	a1,s1
 668:	8556                	mv	a0,s5
 66a:	00000097          	auipc	ra,0x0
 66e:	e82080e7          	jalr	-382(ra) # 4ec <putc>
      }
      state = 0;
 672:	4981                	li	s3,0
 674:	b765                	j	61c <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 676:	008b0493          	addi	s1,s6,8
 67a:	4685                	li	a3,1
 67c:	4629                	li	a2,10
 67e:	000b2583          	lw	a1,0(s6)
 682:	8556                	mv	a0,s5
 684:	00000097          	auipc	ra,0x0
 688:	e8a080e7          	jalr	-374(ra) # 50e <printint>
 68c:	8b26                	mv	s6,s1
      state = 0;
 68e:	4981                	li	s3,0
 690:	b771                	j	61c <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 692:	008b0493          	addi	s1,s6,8
 696:	4681                	li	a3,0
 698:	4629                	li	a2,10
 69a:	000b2583          	lw	a1,0(s6)
 69e:	8556                	mv	a0,s5
 6a0:	00000097          	auipc	ra,0x0
 6a4:	e6e080e7          	jalr	-402(ra) # 50e <printint>
 6a8:	8b26                	mv	s6,s1
      state = 0;
 6aa:	4981                	li	s3,0
 6ac:	bf85                	j	61c <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 6ae:	008b0493          	addi	s1,s6,8
 6b2:	4681                	li	a3,0
 6b4:	4641                	li	a2,16
 6b6:	000b2583          	lw	a1,0(s6)
 6ba:	8556                	mv	a0,s5
 6bc:	00000097          	auipc	ra,0x0
 6c0:	e52080e7          	jalr	-430(ra) # 50e <printint>
 6c4:	8b26                	mv	s6,s1
      state = 0;
 6c6:	4981                	li	s3,0
 6c8:	bf91                	j	61c <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 6ca:	008b0793          	addi	a5,s6,8
 6ce:	f8f43423          	sd	a5,-120(s0)
 6d2:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 6d6:	03000593          	li	a1,48
 6da:	8556                	mv	a0,s5
 6dc:	00000097          	auipc	ra,0x0
 6e0:	e10080e7          	jalr	-496(ra) # 4ec <putc>
  putc(fd, 'x');
 6e4:	85ea                	mv	a1,s10
 6e6:	8556                	mv	a0,s5
 6e8:	00000097          	auipc	ra,0x0
 6ec:	e04080e7          	jalr	-508(ra) # 4ec <putc>
 6f0:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6f2:	03c9d793          	srli	a5,s3,0x3c
 6f6:	97de                	add	a5,a5,s7
 6f8:	0007c583          	lbu	a1,0(a5)
 6fc:	8556                	mv	a0,s5
 6fe:	00000097          	auipc	ra,0x0
 702:	dee080e7          	jalr	-530(ra) # 4ec <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 706:	0992                	slli	s3,s3,0x4
 708:	34fd                	addiw	s1,s1,-1
 70a:	f4e5                	bnez	s1,6f2 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 70c:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 710:	4981                	li	s3,0
 712:	b729                	j	61c <vprintf+0x60>
        s = va_arg(ap, char*);
 714:	008b0993          	addi	s3,s6,8
 718:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 71c:	c085                	beqz	s1,73c <vprintf+0x180>
        while(*s != 0){
 71e:	0004c583          	lbu	a1,0(s1)
 722:	c9a1                	beqz	a1,772 <vprintf+0x1b6>
          putc(fd, *s);
 724:	8556                	mv	a0,s5
 726:	00000097          	auipc	ra,0x0
 72a:	dc6080e7          	jalr	-570(ra) # 4ec <putc>
          s++;
 72e:	0485                	addi	s1,s1,1
        while(*s != 0){
 730:	0004c583          	lbu	a1,0(s1)
 734:	f9e5                	bnez	a1,724 <vprintf+0x168>
        s = va_arg(ap, char*);
 736:	8b4e                	mv	s6,s3
      state = 0;
 738:	4981                	li	s3,0
 73a:	b5cd                	j	61c <vprintf+0x60>
          s = "(null)";
 73c:	00000497          	auipc	s1,0x0
 740:	30c48493          	addi	s1,s1,780 # a48 <digits+0x18>
        while(*s != 0){
 744:	02800593          	li	a1,40
 748:	bff1                	j	724 <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 74a:	008b0493          	addi	s1,s6,8
 74e:	000b4583          	lbu	a1,0(s6)
 752:	8556                	mv	a0,s5
 754:	00000097          	auipc	ra,0x0
 758:	d98080e7          	jalr	-616(ra) # 4ec <putc>
 75c:	8b26                	mv	s6,s1
      state = 0;
 75e:	4981                	li	s3,0
 760:	bd75                	j	61c <vprintf+0x60>
        putc(fd, c);
 762:	85d2                	mv	a1,s4
 764:	8556                	mv	a0,s5
 766:	00000097          	auipc	ra,0x0
 76a:	d86080e7          	jalr	-634(ra) # 4ec <putc>
      state = 0;
 76e:	4981                	li	s3,0
 770:	b575                	j	61c <vprintf+0x60>
        s = va_arg(ap, char*);
 772:	8b4e                	mv	s6,s3
      state = 0;
 774:	4981                	li	s3,0
 776:	b55d                	j	61c <vprintf+0x60>
    }
  }
}
 778:	70e6                	ld	ra,120(sp)
 77a:	7446                	ld	s0,112(sp)
 77c:	74a6                	ld	s1,104(sp)
 77e:	7906                	ld	s2,96(sp)
 780:	69e6                	ld	s3,88(sp)
 782:	6a46                	ld	s4,80(sp)
 784:	6aa6                	ld	s5,72(sp)
 786:	6b06                	ld	s6,64(sp)
 788:	7be2                	ld	s7,56(sp)
 78a:	7c42                	ld	s8,48(sp)
 78c:	7ca2                	ld	s9,40(sp)
 78e:	7d02                	ld	s10,32(sp)
 790:	6de2                	ld	s11,24(sp)
 792:	6109                	addi	sp,sp,128
 794:	8082                	ret

0000000000000796 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 796:	715d                	addi	sp,sp,-80
 798:	ec06                	sd	ra,24(sp)
 79a:	e822                	sd	s0,16(sp)
 79c:	1000                	addi	s0,sp,32
 79e:	e010                	sd	a2,0(s0)
 7a0:	e414                	sd	a3,8(s0)
 7a2:	e818                	sd	a4,16(s0)
 7a4:	ec1c                	sd	a5,24(s0)
 7a6:	03043023          	sd	a6,32(s0)
 7aa:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7ae:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7b2:	8622                	mv	a2,s0
 7b4:	00000097          	auipc	ra,0x0
 7b8:	e08080e7          	jalr	-504(ra) # 5bc <vprintf>
}
 7bc:	60e2                	ld	ra,24(sp)
 7be:	6442                	ld	s0,16(sp)
 7c0:	6161                	addi	sp,sp,80
 7c2:	8082                	ret

00000000000007c4 <printf>:

void
printf(const char *fmt, ...)
{
 7c4:	711d                	addi	sp,sp,-96
 7c6:	ec06                	sd	ra,24(sp)
 7c8:	e822                	sd	s0,16(sp)
 7ca:	1000                	addi	s0,sp,32
 7cc:	e40c                	sd	a1,8(s0)
 7ce:	e810                	sd	a2,16(s0)
 7d0:	ec14                	sd	a3,24(s0)
 7d2:	f018                	sd	a4,32(s0)
 7d4:	f41c                	sd	a5,40(s0)
 7d6:	03043823          	sd	a6,48(s0)
 7da:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7de:	00840613          	addi	a2,s0,8
 7e2:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7e6:	85aa                	mv	a1,a0
 7e8:	4505                	li	a0,1
 7ea:	00000097          	auipc	ra,0x0
 7ee:	dd2080e7          	jalr	-558(ra) # 5bc <vprintf>
}
 7f2:	60e2                	ld	ra,24(sp)
 7f4:	6442                	ld	s0,16(sp)
 7f6:	6125                	addi	sp,sp,96
 7f8:	8082                	ret

00000000000007fa <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7fa:	1141                	addi	sp,sp,-16
 7fc:	e422                	sd	s0,8(sp)
 7fe:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 800:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 804:	00000797          	auipc	a5,0x0
 808:	24c78793          	addi	a5,a5,588 # a50 <__bss_start>
 80c:	639c                	ld	a5,0(a5)
 80e:	a805                	j	83e <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 810:	4618                	lw	a4,8(a2)
 812:	9db9                	addw	a1,a1,a4
 814:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 818:	6398                	ld	a4,0(a5)
 81a:	6318                	ld	a4,0(a4)
 81c:	fee53823          	sd	a4,-16(a0)
 820:	a091                	j	864 <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 822:	ff852703          	lw	a4,-8(a0)
 826:	9e39                	addw	a2,a2,a4
 828:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 82a:	ff053703          	ld	a4,-16(a0)
 82e:	e398                	sd	a4,0(a5)
 830:	a099                	j	876 <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 832:	6398                	ld	a4,0(a5)
 834:	00e7e463          	bltu	a5,a4,83c <free+0x42>
 838:	00e6ea63          	bltu	a3,a4,84c <free+0x52>
{
 83c:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 83e:	fed7fae3          	bleu	a3,a5,832 <free+0x38>
 842:	6398                	ld	a4,0(a5)
 844:	00e6e463          	bltu	a3,a4,84c <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 848:	fee7eae3          	bltu	a5,a4,83c <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 84c:	ff852583          	lw	a1,-8(a0)
 850:	6390                	ld	a2,0(a5)
 852:	02059713          	slli	a4,a1,0x20
 856:	9301                	srli	a4,a4,0x20
 858:	0712                	slli	a4,a4,0x4
 85a:	9736                	add	a4,a4,a3
 85c:	fae60ae3          	beq	a2,a4,810 <free+0x16>
    bp->s.ptr = p->s.ptr;
 860:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 864:	4790                	lw	a2,8(a5)
 866:	02061713          	slli	a4,a2,0x20
 86a:	9301                	srli	a4,a4,0x20
 86c:	0712                	slli	a4,a4,0x4
 86e:	973e                	add	a4,a4,a5
 870:	fae689e3          	beq	a3,a4,822 <free+0x28>
  } else
    p->s.ptr = bp;
 874:	e394                	sd	a3,0(a5)
  freep = p;
 876:	00000717          	auipc	a4,0x0
 87a:	1cf73d23          	sd	a5,474(a4) # a50 <__bss_start>
}
 87e:	6422                	ld	s0,8(sp)
 880:	0141                	addi	sp,sp,16
 882:	8082                	ret

0000000000000884 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 884:	7139                	addi	sp,sp,-64
 886:	fc06                	sd	ra,56(sp)
 888:	f822                	sd	s0,48(sp)
 88a:	f426                	sd	s1,40(sp)
 88c:	f04a                	sd	s2,32(sp)
 88e:	ec4e                	sd	s3,24(sp)
 890:	e852                	sd	s4,16(sp)
 892:	e456                	sd	s5,8(sp)
 894:	e05a                	sd	s6,0(sp)
 896:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 898:	02051993          	slli	s3,a0,0x20
 89c:	0209d993          	srli	s3,s3,0x20
 8a0:	09bd                	addi	s3,s3,15
 8a2:	0049d993          	srli	s3,s3,0x4
 8a6:	2985                	addiw	s3,s3,1
 8a8:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 8ac:	00000797          	auipc	a5,0x0
 8b0:	1a478793          	addi	a5,a5,420 # a50 <__bss_start>
 8b4:	6388                	ld	a0,0(a5)
 8b6:	c515                	beqz	a0,8e2 <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8b8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8ba:	4798                	lw	a4,8(a5)
 8bc:	03277f63          	bleu	s2,a4,8fa <malloc+0x76>
 8c0:	8a4e                	mv	s4,s3
 8c2:	0009871b          	sext.w	a4,s3
 8c6:	6685                	lui	a3,0x1
 8c8:	00d77363          	bleu	a3,a4,8ce <malloc+0x4a>
 8cc:	6a05                	lui	s4,0x1
 8ce:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 8d2:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8d6:	00000497          	auipc	s1,0x0
 8da:	17a48493          	addi	s1,s1,378 # a50 <__bss_start>
  if(p == (char*)-1)
 8de:	5b7d                	li	s6,-1
 8e0:	a885                	j	950 <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 8e2:	00000797          	auipc	a5,0x0
 8e6:	17678793          	addi	a5,a5,374 # a58 <base>
 8ea:	00000717          	auipc	a4,0x0
 8ee:	16f73323          	sd	a5,358(a4) # a50 <__bss_start>
 8f2:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8f4:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8f8:	b7e1                	j	8c0 <malloc+0x3c>
      if(p->s.size == nunits)
 8fa:	02e90b63          	beq	s2,a4,930 <malloc+0xac>
        p->s.size -= nunits;
 8fe:	4137073b          	subw	a4,a4,s3
 902:	c798                	sw	a4,8(a5)
        p += p->s.size;
 904:	1702                	slli	a4,a4,0x20
 906:	9301                	srli	a4,a4,0x20
 908:	0712                	slli	a4,a4,0x4
 90a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 90c:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 910:	00000717          	auipc	a4,0x0
 914:	14a73023          	sd	a0,320(a4) # a50 <__bss_start>
      return (void*)(p + 1);
 918:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 91c:	70e2                	ld	ra,56(sp)
 91e:	7442                	ld	s0,48(sp)
 920:	74a2                	ld	s1,40(sp)
 922:	7902                	ld	s2,32(sp)
 924:	69e2                	ld	s3,24(sp)
 926:	6a42                	ld	s4,16(sp)
 928:	6aa2                	ld	s5,8(sp)
 92a:	6b02                	ld	s6,0(sp)
 92c:	6121                	addi	sp,sp,64
 92e:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 930:	6398                	ld	a4,0(a5)
 932:	e118                	sd	a4,0(a0)
 934:	bff1                	j	910 <malloc+0x8c>
  hp->s.size = nu;
 936:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 93a:	0541                	addi	a0,a0,16
 93c:	00000097          	auipc	ra,0x0
 940:	ebe080e7          	jalr	-322(ra) # 7fa <free>
  return freep;
 944:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 946:	d979                	beqz	a0,91c <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 948:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 94a:	4798                	lw	a4,8(a5)
 94c:	fb2777e3          	bleu	s2,a4,8fa <malloc+0x76>
    if(p == freep)
 950:	6098                	ld	a4,0(s1)
 952:	853e                	mv	a0,a5
 954:	fef71ae3          	bne	a4,a5,948 <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 958:	8552                	mv	a0,s4
 95a:	00000097          	auipc	ra,0x0
 95e:	b7a080e7          	jalr	-1158(ra) # 4d4 <sbrk>
  if(p == (char*)-1)
 962:	fd651ae3          	bne	a0,s6,936 <malloc+0xb2>
        return 0;
 966:	4501                	li	a0,0
 968:	bf55                	j	91c <malloc+0x98>
