
user/_primes：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <new_proc>:
    close(pipe_0[1]);
    wait(0);
    exit(0);
}

void new_proc(int original_pipe[]) {
   0:	7139                	addi	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	f426                	sd	s1,40(sp)
   8:	0080                	addi	s0,sp,64
   a:	84aa                	mv	s1,a0
    close(original_pipe[1]);
   c:	4148                	lw	a0,4(a0)
   e:	00000097          	auipc	ra,0x0
  12:	448080e7          	jalr	1096(ra) # 456 <close>

    int receive_prime = 0;
  16:	fc042e23          	sw	zero,-36(s0)
    int whether_continue_fork = 0;
    whether_continue_fork = read(original_pipe[0], &receive_prime, sizeof(int));
  1a:	4611                	li	a2,4
  1c:	fdc40593          	addi	a1,s0,-36
  20:	4088                	lw	a0,0(s1)
  22:	00000097          	auipc	ra,0x0
  26:	424080e7          	jalr	1060(ra) # 446 <read>
    /* printf("getpid: %d, whether_continue_fork %d\n", getpid(), whether_continue_fork); */
    /* printf("getpid: %d, original_pipe[0] %d\n", getpid(), original_pipe[0]); */
    if(whether_continue_fork == 0) {
  2a:	c531                	beqz	a0,76 <new_proc+0x76>
        /*no need fork, declare not receive prime this time*/
        exit(0);
    }

    printf("prime %d\n", receive_prime);
  2c:	fdc42583          	lw	a1,-36(s0)
  30:	00001517          	auipc	a0,0x1
  34:	92050513          	addi	a0,a0,-1760 # 950 <malloc+0xea>
  38:	00000097          	auipc	ra,0x0
  3c:	76e080e7          	jalr	1902(ra) # 7a6 <printf>
    int new_pipe[2];
    pipe(new_pipe);
  40:	fd040513          	addi	a0,s0,-48
  44:	00000097          	auipc	ra,0x0
  48:	3fa080e7          	jalr	1018(ra) # 43e <pipe>

    if(fork() == 0) {
  4c:	00000097          	auipc	ra,0x0
  50:	3da080e7          	jalr	986(ra) # 426 <fork>
  54:	e50d                	bnez	a0,7e <new_proc+0x7e>
        //child
        close(original_pipe[0]);
  56:	4088                	lw	a0,0(s1)
  58:	00000097          	auipc	ra,0x0
  5c:	3fe080e7          	jalr	1022(ra) # 456 <close>
        new_proc(new_pipe);
  60:	fd040513          	addi	a0,s0,-48
  64:	00000097          	auipc	ra,0x0
  68:	f9c080e7          	jalr	-100(ra) # 0 <new_proc>

        close(new_pipe[1]);
        wait(0);
        exit(0);
    }
}
  6c:	70e2                	ld	ra,56(sp)
  6e:	7442                	ld	s0,48(sp)
  70:	74a2                	ld	s1,40(sp)
  72:	6121                	addi	sp,sp,64
  74:	8082                	ret
        exit(0);
  76:	00000097          	auipc	ra,0x0
  7a:	3b8080e7          	jalr	952(ra) # 42e <exit>
        close(new_pipe[0]);
  7e:	fd042503          	lw	a0,-48(s0)
  82:	00000097          	auipc	ra,0x0
  86:	3d4080e7          	jalr	980(ra) # 456 <close>
        int check_prime_num = 0;
  8a:	fc042623          	sw	zero,-52(s0)
            ret = read(original_pipe[0], &check_prime_num, sizeof(int));
  8e:	4611                	li	a2,4
  90:	fcc40593          	addi	a1,s0,-52
  94:	4088                	lw	a0,0(s1)
  96:	00000097          	auipc	ra,0x0
  9a:	3b0080e7          	jalr	944(ra) # 446 <read>
            if(ret == 0) {
  9e:	c115                	beqz	a0,c2 <new_proc+0xc2>
            if(check_prime_num % receive_prime != 0) {
  a0:	fcc42783          	lw	a5,-52(s0)
  a4:	fdc42703          	lw	a4,-36(s0)
  a8:	02e7e7bb          	remw	a5,a5,a4
  ac:	d3ed                	beqz	a5,8e <new_proc+0x8e>
                write(new_pipe[1], &check_prime_num, sizeof(int));
  ae:	4611                	li	a2,4
  b0:	fcc40593          	addi	a1,s0,-52
  b4:	fd442503          	lw	a0,-44(s0)
  b8:	00000097          	auipc	ra,0x0
  bc:	396080e7          	jalr	918(ra) # 44e <write>
        while(ret != 0) {
  c0:	b7f9                	j	8e <new_proc+0x8e>
        close(new_pipe[1]);
  c2:	fd442503          	lw	a0,-44(s0)
  c6:	00000097          	auipc	ra,0x0
  ca:	390080e7          	jalr	912(ra) # 456 <close>
        wait(0);
  ce:	4501                	li	a0,0
  d0:	00000097          	auipc	ra,0x0
  d4:	366080e7          	jalr	870(ra) # 436 <wait>
        exit(0);
  d8:	4501                	li	a0,0
  da:	00000097          	auipc	ra,0x0
  de:	354080e7          	jalr	852(ra) # 42e <exit>

00000000000000e2 <main>:
{
  e2:	7139                	addi	sp,sp,-64
  e4:	fc06                	sd	ra,56(sp)
  e6:	f822                	sd	s0,48(sp)
  e8:	f426                	sd	s1,40(sp)
  ea:	f04a                	sd	s2,32(sp)
  ec:	ec4e                	sd	s3,24(sp)
  ee:	0080                	addi	s0,sp,64
    int n = p;
  f0:	4789                	li	a5,2
  f2:	fcf42223          	sw	a5,-60(s0)
    pipe(pipe_0);
  f6:	fc840513          	addi	a0,s0,-56
  fa:	00000097          	auipc	ra,0x0
  fe:	344080e7          	jalr	836(ra) # 43e <pipe>
    if(fork() == 0) {
 102:	00000097          	auipc	ra,0x0
 106:	324080e7          	jalr	804(ra) # 426 <fork>
 10a:	e51d                	bnez	a0,138 <main+0x56>
        new_proc(pipe_0);
 10c:	fc840513          	addi	a0,s0,-56
 110:	00000097          	auipc	ra,0x0
 114:	ef0080e7          	jalr	-272(ra) # 0 <new_proc>
    close(pipe_0[1]);
 118:	fcc42503          	lw	a0,-52(s0)
 11c:	00000097          	auipc	ra,0x0
 120:	33a080e7          	jalr	826(ra) # 456 <close>
    wait(0);
 124:	4501                	li	a0,0
 126:	00000097          	auipc	ra,0x0
 12a:	310080e7          	jalr	784(ra) # 436 <wait>
    exit(0);
 12e:	4501                	li	a0,0
 130:	00000097          	auipc	ra,0x0
 134:	2fe080e7          	jalr	766(ra) # 42e <exit>
        printf("prime %d\n", p);
 138:	4589                	li	a1,2
 13a:	00001517          	auipc	a0,0x1
 13e:	81650513          	addi	a0,a0,-2026 # 950 <malloc+0xea>
 142:	00000097          	auipc	ra,0x0
 146:	664080e7          	jalr	1636(ra) # 7a6 <printf>
        close(pipe_0[0]);
 14a:	fc842503          	lw	a0,-56(s0)
 14e:	00000097          	auipc	ra,0x0
 152:	308080e7          	jalr	776(ra) # 456 <close>
{
 156:	4981                	li	s3,0
        while(n <= 35) {
 158:	02300493          	li	s1,35
 15c:	4905                	li	s2,1
 15e:	fc442703          	lw	a4,-60(s0)
{
 162:	86ce                	mv	a3,s3
        while(n <= 35) {
 164:	02e4c963          	blt	s1,a4,196 <main+0xb4>
            n++;
 168:	0017079b          	addiw	a5,a4,1
 16c:	0007871b          	sext.w	a4,a5
            if(n % p != 0) {
 170:	01f7d69b          	srliw	a3,a5,0x1f
 174:	9fb5                	addw	a5,a5,a3
 176:	8b85                	andi	a5,a5,1
 178:	9f95                	subw	a5,a5,a3
 17a:	86ca                	mv	a3,s2
 17c:	d7e5                	beqz	a5,164 <main+0x82>
 17e:	fce42223          	sw	a4,-60(s0)
                write(pipe_0[1], &n, sizeof(int));
 182:	4611                	li	a2,4
 184:	fc440593          	addi	a1,s0,-60
 188:	fcc42503          	lw	a0,-52(s0)
 18c:	00000097          	auipc	ra,0x0
 190:	2c2080e7          	jalr	706(ra) # 44e <write>
 194:	b7e9                	j	15e <main+0x7c>
 196:	d2c9                	beqz	a3,118 <main+0x36>
 198:	fce42223          	sw	a4,-60(s0)
 19c:	bfb5                	j	118 <main+0x36>

000000000000019e <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 19e:	1141                	addi	sp,sp,-16
 1a0:	e422                	sd	s0,8(sp)
 1a2:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1a4:	87aa                	mv	a5,a0
 1a6:	0585                	addi	a1,a1,1
 1a8:	0785                	addi	a5,a5,1
 1aa:	fff5c703          	lbu	a4,-1(a1)
 1ae:	fee78fa3          	sb	a4,-1(a5)
 1b2:	fb75                	bnez	a4,1a6 <strcpy+0x8>
    ;
  return os;
}
 1b4:	6422                	ld	s0,8(sp)
 1b6:	0141                	addi	sp,sp,16
 1b8:	8082                	ret

00000000000001ba <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1ba:	1141                	addi	sp,sp,-16
 1bc:	e422                	sd	s0,8(sp)
 1be:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 1c0:	00054783          	lbu	a5,0(a0)
 1c4:	cf91                	beqz	a5,1e0 <strcmp+0x26>
 1c6:	0005c703          	lbu	a4,0(a1)
 1ca:	00f71b63          	bne	a4,a5,1e0 <strcmp+0x26>
    p++, q++;
 1ce:	0505                	addi	a0,a0,1
 1d0:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 1d2:	00054783          	lbu	a5,0(a0)
 1d6:	c789                	beqz	a5,1e0 <strcmp+0x26>
 1d8:	0005c703          	lbu	a4,0(a1)
 1dc:	fef709e3          	beq	a4,a5,1ce <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
 1e0:	0005c503          	lbu	a0,0(a1)
}
 1e4:	40a7853b          	subw	a0,a5,a0
 1e8:	6422                	ld	s0,8(sp)
 1ea:	0141                	addi	sp,sp,16
 1ec:	8082                	ret

00000000000001ee <strlen>:

uint
strlen(const char *s)
{
 1ee:	1141                	addi	sp,sp,-16
 1f0:	e422                	sd	s0,8(sp)
 1f2:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 1f4:	00054783          	lbu	a5,0(a0)
 1f8:	cf91                	beqz	a5,214 <strlen+0x26>
 1fa:	0505                	addi	a0,a0,1
 1fc:	87aa                	mv	a5,a0
 1fe:	4685                	li	a3,1
 200:	9e89                	subw	a3,a3,a0
 202:	00f6853b          	addw	a0,a3,a5
 206:	0785                	addi	a5,a5,1
 208:	fff7c703          	lbu	a4,-1(a5)
 20c:	fb7d                	bnez	a4,202 <strlen+0x14>
    ;
  return n;
}
 20e:	6422                	ld	s0,8(sp)
 210:	0141                	addi	sp,sp,16
 212:	8082                	ret
  for(n = 0; s[n]; n++)
 214:	4501                	li	a0,0
 216:	bfe5                	j	20e <strlen+0x20>

0000000000000218 <memset>:

void*
memset(void *dst, int c, uint n)
{
 218:	1141                	addi	sp,sp,-16
 21a:	e422                	sd	s0,8(sp)
 21c:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 21e:	ce09                	beqz	a2,238 <memset+0x20>
 220:	87aa                	mv	a5,a0
 222:	fff6071b          	addiw	a4,a2,-1
 226:	1702                	slli	a4,a4,0x20
 228:	9301                	srli	a4,a4,0x20
 22a:	0705                	addi	a4,a4,1
 22c:	972a                	add	a4,a4,a0
    cdst[i] = c;
 22e:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 232:	0785                	addi	a5,a5,1
 234:	fee79de3          	bne	a5,a4,22e <memset+0x16>
  }
  return dst;
}
 238:	6422                	ld	s0,8(sp)
 23a:	0141                	addi	sp,sp,16
 23c:	8082                	ret

000000000000023e <strchr>:

char*
strchr(const char *s, char c)
{
 23e:	1141                	addi	sp,sp,-16
 240:	e422                	sd	s0,8(sp)
 242:	0800                	addi	s0,sp,16
  for(; *s; s++)
 244:	00054783          	lbu	a5,0(a0)
 248:	cf91                	beqz	a5,264 <strchr+0x26>
    if(*s == c)
 24a:	00f58a63          	beq	a1,a5,25e <strchr+0x20>
  for(; *s; s++)
 24e:	0505                	addi	a0,a0,1
 250:	00054783          	lbu	a5,0(a0)
 254:	c781                	beqz	a5,25c <strchr+0x1e>
    if(*s == c)
 256:	feb79ce3          	bne	a5,a1,24e <strchr+0x10>
 25a:	a011                	j	25e <strchr+0x20>
      return (char*)s;
  return 0;
 25c:	4501                	li	a0,0
}
 25e:	6422                	ld	s0,8(sp)
 260:	0141                	addi	sp,sp,16
 262:	8082                	ret
  return 0;
 264:	4501                	li	a0,0
 266:	bfe5                	j	25e <strchr+0x20>

0000000000000268 <gets>:

char*
gets(char *buf, int max)
{
 268:	711d                	addi	sp,sp,-96
 26a:	ec86                	sd	ra,88(sp)
 26c:	e8a2                	sd	s0,80(sp)
 26e:	e4a6                	sd	s1,72(sp)
 270:	e0ca                	sd	s2,64(sp)
 272:	fc4e                	sd	s3,56(sp)
 274:	f852                	sd	s4,48(sp)
 276:	f456                	sd	s5,40(sp)
 278:	f05a                	sd	s6,32(sp)
 27a:	ec5e                	sd	s7,24(sp)
 27c:	1080                	addi	s0,sp,96
 27e:	8baa                	mv	s7,a0
 280:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 282:	892a                	mv	s2,a0
 284:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 286:	4aa9                	li	s5,10
 288:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 28a:	0019849b          	addiw	s1,s3,1
 28e:	0344d863          	ble	s4,s1,2be <gets+0x56>
    cc = read(0, &c, 1);
 292:	4605                	li	a2,1
 294:	faf40593          	addi	a1,s0,-81
 298:	4501                	li	a0,0
 29a:	00000097          	auipc	ra,0x0
 29e:	1ac080e7          	jalr	428(ra) # 446 <read>
    if(cc < 1)
 2a2:	00a05e63          	blez	a0,2be <gets+0x56>
    buf[i++] = c;
 2a6:	faf44783          	lbu	a5,-81(s0)
 2aa:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 2ae:	01578763          	beq	a5,s5,2bc <gets+0x54>
 2b2:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 2b4:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 2b6:	fd679ae3          	bne	a5,s6,28a <gets+0x22>
 2ba:	a011                	j	2be <gets+0x56>
  for(i=0; i+1 < max; ){
 2bc:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 2be:	99de                	add	s3,s3,s7
 2c0:	00098023          	sb	zero,0(s3)
  return buf;
}
 2c4:	855e                	mv	a0,s7
 2c6:	60e6                	ld	ra,88(sp)
 2c8:	6446                	ld	s0,80(sp)
 2ca:	64a6                	ld	s1,72(sp)
 2cc:	6906                	ld	s2,64(sp)
 2ce:	79e2                	ld	s3,56(sp)
 2d0:	7a42                	ld	s4,48(sp)
 2d2:	7aa2                	ld	s5,40(sp)
 2d4:	7b02                	ld	s6,32(sp)
 2d6:	6be2                	ld	s7,24(sp)
 2d8:	6125                	addi	sp,sp,96
 2da:	8082                	ret

00000000000002dc <stat>:

int
stat(const char *n, struct stat *st)
{
 2dc:	1101                	addi	sp,sp,-32
 2de:	ec06                	sd	ra,24(sp)
 2e0:	e822                	sd	s0,16(sp)
 2e2:	e426                	sd	s1,8(sp)
 2e4:	e04a                	sd	s2,0(sp)
 2e6:	1000                	addi	s0,sp,32
 2e8:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2ea:	4581                	li	a1,0
 2ec:	00000097          	auipc	ra,0x0
 2f0:	182080e7          	jalr	386(ra) # 46e <open>
  if(fd < 0)
 2f4:	02054563          	bltz	a0,31e <stat+0x42>
 2f8:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 2fa:	85ca                	mv	a1,s2
 2fc:	00000097          	auipc	ra,0x0
 300:	18a080e7          	jalr	394(ra) # 486 <fstat>
 304:	892a                	mv	s2,a0
  close(fd);
 306:	8526                	mv	a0,s1
 308:	00000097          	auipc	ra,0x0
 30c:	14e080e7          	jalr	334(ra) # 456 <close>
  return r;
}
 310:	854a                	mv	a0,s2
 312:	60e2                	ld	ra,24(sp)
 314:	6442                	ld	s0,16(sp)
 316:	64a2                	ld	s1,8(sp)
 318:	6902                	ld	s2,0(sp)
 31a:	6105                	addi	sp,sp,32
 31c:	8082                	ret
    return -1;
 31e:	597d                	li	s2,-1
 320:	bfc5                	j	310 <stat+0x34>

0000000000000322 <atoi>:

int
atoi(const char *s)
{
 322:	1141                	addi	sp,sp,-16
 324:	e422                	sd	s0,8(sp)
 326:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 328:	00054683          	lbu	a3,0(a0)
 32c:	fd06879b          	addiw	a5,a3,-48
 330:	0ff7f793          	andi	a5,a5,255
 334:	4725                	li	a4,9
 336:	02f76963          	bltu	a4,a5,368 <atoi+0x46>
 33a:	862a                	mv	a2,a0
  n = 0;
 33c:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 33e:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 340:	0605                	addi	a2,a2,1
 342:	0025179b          	slliw	a5,a0,0x2
 346:	9fa9                	addw	a5,a5,a0
 348:	0017979b          	slliw	a5,a5,0x1
 34c:	9fb5                	addw	a5,a5,a3
 34e:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 352:	00064683          	lbu	a3,0(a2)
 356:	fd06871b          	addiw	a4,a3,-48
 35a:	0ff77713          	andi	a4,a4,255
 35e:	fee5f1e3          	bleu	a4,a1,340 <atoi+0x1e>
  return n;
}
 362:	6422                	ld	s0,8(sp)
 364:	0141                	addi	sp,sp,16
 366:	8082                	ret
  n = 0;
 368:	4501                	li	a0,0
 36a:	bfe5                	j	362 <atoi+0x40>

000000000000036c <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 36c:	1141                	addi	sp,sp,-16
 36e:	e422                	sd	s0,8(sp)
 370:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 372:	02b57663          	bleu	a1,a0,39e <memmove+0x32>
    while(n-- > 0)
 376:	02c05163          	blez	a2,398 <memmove+0x2c>
 37a:	fff6079b          	addiw	a5,a2,-1
 37e:	1782                	slli	a5,a5,0x20
 380:	9381                	srli	a5,a5,0x20
 382:	0785                	addi	a5,a5,1
 384:	97aa                	add	a5,a5,a0
  dst = vdst;
 386:	872a                	mv	a4,a0
      *dst++ = *src++;
 388:	0585                	addi	a1,a1,1
 38a:	0705                	addi	a4,a4,1
 38c:	fff5c683          	lbu	a3,-1(a1)
 390:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 394:	fee79ae3          	bne	a5,a4,388 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 398:	6422                	ld	s0,8(sp)
 39a:	0141                	addi	sp,sp,16
 39c:	8082                	ret
    dst += n;
 39e:	00c50733          	add	a4,a0,a2
    src += n;
 3a2:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 3a4:	fec05ae3          	blez	a2,398 <memmove+0x2c>
 3a8:	fff6079b          	addiw	a5,a2,-1
 3ac:	1782                	slli	a5,a5,0x20
 3ae:	9381                	srli	a5,a5,0x20
 3b0:	fff7c793          	not	a5,a5
 3b4:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 3b6:	15fd                	addi	a1,a1,-1
 3b8:	177d                	addi	a4,a4,-1
 3ba:	0005c683          	lbu	a3,0(a1)
 3be:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 3c2:	fef71ae3          	bne	a4,a5,3b6 <memmove+0x4a>
 3c6:	bfc9                	j	398 <memmove+0x2c>

00000000000003c8 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 3c8:	1141                	addi	sp,sp,-16
 3ca:	e422                	sd	s0,8(sp)
 3cc:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 3ce:	ce15                	beqz	a2,40a <memcmp+0x42>
 3d0:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
 3d4:	00054783          	lbu	a5,0(a0)
 3d8:	0005c703          	lbu	a4,0(a1)
 3dc:	02e79063          	bne	a5,a4,3fc <memcmp+0x34>
 3e0:	1682                	slli	a3,a3,0x20
 3e2:	9281                	srli	a3,a3,0x20
 3e4:	0685                	addi	a3,a3,1
 3e6:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
 3e8:	0505                	addi	a0,a0,1
    p2++;
 3ea:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 3ec:	00d50d63          	beq	a0,a3,406 <memcmp+0x3e>
    if (*p1 != *p2) {
 3f0:	00054783          	lbu	a5,0(a0)
 3f4:	0005c703          	lbu	a4,0(a1)
 3f8:	fee788e3          	beq	a5,a4,3e8 <memcmp+0x20>
      return *p1 - *p2;
 3fc:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
 400:	6422                	ld	s0,8(sp)
 402:	0141                	addi	sp,sp,16
 404:	8082                	ret
  return 0;
 406:	4501                	li	a0,0
 408:	bfe5                	j	400 <memcmp+0x38>
 40a:	4501                	li	a0,0
 40c:	bfd5                	j	400 <memcmp+0x38>

000000000000040e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 40e:	1141                	addi	sp,sp,-16
 410:	e406                	sd	ra,8(sp)
 412:	e022                	sd	s0,0(sp)
 414:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 416:	00000097          	auipc	ra,0x0
 41a:	f56080e7          	jalr	-170(ra) # 36c <memmove>
}
 41e:	60a2                	ld	ra,8(sp)
 420:	6402                	ld	s0,0(sp)
 422:	0141                	addi	sp,sp,16
 424:	8082                	ret

0000000000000426 <fork>:
 426:	4885                	li	a7,1
 428:	00000073          	ecall
 42c:	8082                	ret

000000000000042e <exit>:
 42e:	4889                	li	a7,2
 430:	00000073          	ecall
 434:	8082                	ret

0000000000000436 <wait>:
 436:	488d                	li	a7,3
 438:	00000073          	ecall
 43c:	8082                	ret

000000000000043e <pipe>:
 43e:	4891                	li	a7,4
 440:	00000073          	ecall
 444:	8082                	ret

0000000000000446 <read>:
 446:	4895                	li	a7,5
 448:	00000073          	ecall
 44c:	8082                	ret

000000000000044e <write>:
 44e:	48c1                	li	a7,16
 450:	00000073          	ecall
 454:	8082                	ret

0000000000000456 <close>:
 456:	48d5                	li	a7,21
 458:	00000073          	ecall
 45c:	8082                	ret

000000000000045e <kill>:
 45e:	4899                	li	a7,6
 460:	00000073          	ecall
 464:	8082                	ret

0000000000000466 <exec>:
 466:	489d                	li	a7,7
 468:	00000073          	ecall
 46c:	8082                	ret

000000000000046e <open>:
 46e:	48bd                	li	a7,15
 470:	00000073          	ecall
 474:	8082                	ret

0000000000000476 <mknod>:
 476:	48c5                	li	a7,17
 478:	00000073          	ecall
 47c:	8082                	ret

000000000000047e <unlink>:
 47e:	48c9                	li	a7,18
 480:	00000073          	ecall
 484:	8082                	ret

0000000000000486 <fstat>:
 486:	48a1                	li	a7,8
 488:	00000073          	ecall
 48c:	8082                	ret

000000000000048e <link>:
 48e:	48cd                	li	a7,19
 490:	00000073          	ecall
 494:	8082                	ret

0000000000000496 <mkdir>:
 496:	48d1                	li	a7,20
 498:	00000073          	ecall
 49c:	8082                	ret

000000000000049e <chdir>:
 49e:	48a5                	li	a7,9
 4a0:	00000073          	ecall
 4a4:	8082                	ret

00000000000004a6 <dup>:
 4a6:	48a9                	li	a7,10
 4a8:	00000073          	ecall
 4ac:	8082                	ret

00000000000004ae <getpid>:
 4ae:	48ad                	li	a7,11
 4b0:	00000073          	ecall
 4b4:	8082                	ret

00000000000004b6 <sbrk>:
 4b6:	48b1                	li	a7,12
 4b8:	00000073          	ecall
 4bc:	8082                	ret

00000000000004be <sleep>:
 4be:	48b5                	li	a7,13
 4c0:	00000073          	ecall
 4c4:	8082                	ret

00000000000004c6 <uptime>:
 4c6:	48b9                	li	a7,14
 4c8:	00000073          	ecall
 4cc:	8082                	ret

00000000000004ce <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4ce:	1101                	addi	sp,sp,-32
 4d0:	ec06                	sd	ra,24(sp)
 4d2:	e822                	sd	s0,16(sp)
 4d4:	1000                	addi	s0,sp,32
 4d6:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4da:	4605                	li	a2,1
 4dc:	fef40593          	addi	a1,s0,-17
 4e0:	00000097          	auipc	ra,0x0
 4e4:	f6e080e7          	jalr	-146(ra) # 44e <write>
}
 4e8:	60e2                	ld	ra,24(sp)
 4ea:	6442                	ld	s0,16(sp)
 4ec:	6105                	addi	sp,sp,32
 4ee:	8082                	ret

00000000000004f0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4f0:	7139                	addi	sp,sp,-64
 4f2:	fc06                	sd	ra,56(sp)
 4f4:	f822                	sd	s0,48(sp)
 4f6:	f426                	sd	s1,40(sp)
 4f8:	f04a                	sd	s2,32(sp)
 4fa:	ec4e                	sd	s3,24(sp)
 4fc:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4fe:	c299                	beqz	a3,504 <printint+0x14>
 500:	0005cd63          	bltz	a1,51a <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 504:	2581                	sext.w	a1,a1
  neg = 0;
 506:	4301                	li	t1,0
 508:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 50c:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 50e:	2601                	sext.w	a2,a2
 510:	00000897          	auipc	a7,0x0
 514:	45088893          	addi	a7,a7,1104 # 960 <digits>
 518:	a801                	j	528 <printint+0x38>
    x = -xx;
 51a:	40b005bb          	negw	a1,a1
 51e:	2581                	sext.w	a1,a1
    neg = 1;
 520:	4305                	li	t1,1
    x = -xx;
 522:	b7dd                	j	508 <printint+0x18>
  }while((x /= base) != 0);
 524:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 526:	8836                	mv	a6,a3
 528:	0018069b          	addiw	a3,a6,1
 52c:	02c5f7bb          	remuw	a5,a1,a2
 530:	1782                	slli	a5,a5,0x20
 532:	9381                	srli	a5,a5,0x20
 534:	97c6                	add	a5,a5,a7
 536:	0007c783          	lbu	a5,0(a5)
 53a:	00f70023          	sb	a5,0(a4)
  }while((x /= base) != 0);
 53e:	0705                	addi	a4,a4,1
 540:	02c5d7bb          	divuw	a5,a1,a2
 544:	fec5f0e3          	bleu	a2,a1,524 <printint+0x34>
  if(neg)
 548:	00030b63          	beqz	t1,55e <printint+0x6e>
    buf[i++] = '-';
 54c:	fd040793          	addi	a5,s0,-48
 550:	96be                	add	a3,a3,a5
 552:	02d00793          	li	a5,45
 556:	fef68823          	sb	a5,-16(a3)
 55a:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 55e:	02d05963          	blez	a3,590 <printint+0xa0>
 562:	89aa                	mv	s3,a0
 564:	fc040793          	addi	a5,s0,-64
 568:	00d784b3          	add	s1,a5,a3
 56c:	fff78913          	addi	s2,a5,-1
 570:	9936                	add	s2,s2,a3
 572:	36fd                	addiw	a3,a3,-1
 574:	1682                	slli	a3,a3,0x20
 576:	9281                	srli	a3,a3,0x20
 578:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 57c:	fff4c583          	lbu	a1,-1(s1)
 580:	854e                	mv	a0,s3
 582:	00000097          	auipc	ra,0x0
 586:	f4c080e7          	jalr	-180(ra) # 4ce <putc>
  while(--i >= 0)
 58a:	14fd                	addi	s1,s1,-1
 58c:	ff2498e3          	bne	s1,s2,57c <printint+0x8c>
}
 590:	70e2                	ld	ra,56(sp)
 592:	7442                	ld	s0,48(sp)
 594:	74a2                	ld	s1,40(sp)
 596:	7902                	ld	s2,32(sp)
 598:	69e2                	ld	s3,24(sp)
 59a:	6121                	addi	sp,sp,64
 59c:	8082                	ret

000000000000059e <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 59e:	7119                	addi	sp,sp,-128
 5a0:	fc86                	sd	ra,120(sp)
 5a2:	f8a2                	sd	s0,112(sp)
 5a4:	f4a6                	sd	s1,104(sp)
 5a6:	f0ca                	sd	s2,96(sp)
 5a8:	ecce                	sd	s3,88(sp)
 5aa:	e8d2                	sd	s4,80(sp)
 5ac:	e4d6                	sd	s5,72(sp)
 5ae:	e0da                	sd	s6,64(sp)
 5b0:	fc5e                	sd	s7,56(sp)
 5b2:	f862                	sd	s8,48(sp)
 5b4:	f466                	sd	s9,40(sp)
 5b6:	f06a                	sd	s10,32(sp)
 5b8:	ec6e                	sd	s11,24(sp)
 5ba:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5bc:	0005c483          	lbu	s1,0(a1)
 5c0:	18048d63          	beqz	s1,75a <vprintf+0x1bc>
 5c4:	8aaa                	mv	s5,a0
 5c6:	8b32                	mv	s6,a2
 5c8:	00158913          	addi	s2,a1,1
  state = 0;
 5cc:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5ce:	02500a13          	li	s4,37
      if(c == 'd'){
 5d2:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 5d6:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 5da:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 5de:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5e2:	00000b97          	auipc	s7,0x0
 5e6:	37eb8b93          	addi	s7,s7,894 # 960 <digits>
 5ea:	a839                	j	608 <vprintf+0x6a>
        putc(fd, c);
 5ec:	85a6                	mv	a1,s1
 5ee:	8556                	mv	a0,s5
 5f0:	00000097          	auipc	ra,0x0
 5f4:	ede080e7          	jalr	-290(ra) # 4ce <putc>
 5f8:	a019                	j	5fe <vprintf+0x60>
    } else if(state == '%'){
 5fa:	01498f63          	beq	s3,s4,618 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 5fe:	0905                	addi	s2,s2,1
 600:	fff94483          	lbu	s1,-1(s2)
 604:	14048b63          	beqz	s1,75a <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 608:	0004879b          	sext.w	a5,s1
    if(state == 0){
 60c:	fe0997e3          	bnez	s3,5fa <vprintf+0x5c>
      if(c == '%'){
 610:	fd479ee3          	bne	a5,s4,5ec <vprintf+0x4e>
        state = '%';
 614:	89be                	mv	s3,a5
 616:	b7e5                	j	5fe <vprintf+0x60>
      if(c == 'd'){
 618:	05878063          	beq	a5,s8,658 <vprintf+0xba>
      } else if(c == 'l') {
 61c:	05978c63          	beq	a5,s9,674 <vprintf+0xd6>
      } else if(c == 'x') {
 620:	07a78863          	beq	a5,s10,690 <vprintf+0xf2>
      } else if(c == 'p') {
 624:	09b78463          	beq	a5,s11,6ac <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 628:	07300713          	li	a4,115
 62c:	0ce78563          	beq	a5,a4,6f6 <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 630:	06300713          	li	a4,99
 634:	0ee78c63          	beq	a5,a4,72c <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 638:	11478663          	beq	a5,s4,744 <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 63c:	85d2                	mv	a1,s4
 63e:	8556                	mv	a0,s5
 640:	00000097          	auipc	ra,0x0
 644:	e8e080e7          	jalr	-370(ra) # 4ce <putc>
        putc(fd, c);
 648:	85a6                	mv	a1,s1
 64a:	8556                	mv	a0,s5
 64c:	00000097          	auipc	ra,0x0
 650:	e82080e7          	jalr	-382(ra) # 4ce <putc>
      }
      state = 0;
 654:	4981                	li	s3,0
 656:	b765                	j	5fe <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 658:	008b0493          	addi	s1,s6,8
 65c:	4685                	li	a3,1
 65e:	4629                	li	a2,10
 660:	000b2583          	lw	a1,0(s6)
 664:	8556                	mv	a0,s5
 666:	00000097          	auipc	ra,0x0
 66a:	e8a080e7          	jalr	-374(ra) # 4f0 <printint>
 66e:	8b26                	mv	s6,s1
      state = 0;
 670:	4981                	li	s3,0
 672:	b771                	j	5fe <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 674:	008b0493          	addi	s1,s6,8
 678:	4681                	li	a3,0
 67a:	4629                	li	a2,10
 67c:	000b2583          	lw	a1,0(s6)
 680:	8556                	mv	a0,s5
 682:	00000097          	auipc	ra,0x0
 686:	e6e080e7          	jalr	-402(ra) # 4f0 <printint>
 68a:	8b26                	mv	s6,s1
      state = 0;
 68c:	4981                	li	s3,0
 68e:	bf85                	j	5fe <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 690:	008b0493          	addi	s1,s6,8
 694:	4681                	li	a3,0
 696:	4641                	li	a2,16
 698:	000b2583          	lw	a1,0(s6)
 69c:	8556                	mv	a0,s5
 69e:	00000097          	auipc	ra,0x0
 6a2:	e52080e7          	jalr	-430(ra) # 4f0 <printint>
 6a6:	8b26                	mv	s6,s1
      state = 0;
 6a8:	4981                	li	s3,0
 6aa:	bf91                	j	5fe <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 6ac:	008b0793          	addi	a5,s6,8
 6b0:	f8f43423          	sd	a5,-120(s0)
 6b4:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 6b8:	03000593          	li	a1,48
 6bc:	8556                	mv	a0,s5
 6be:	00000097          	auipc	ra,0x0
 6c2:	e10080e7          	jalr	-496(ra) # 4ce <putc>
  putc(fd, 'x');
 6c6:	85ea                	mv	a1,s10
 6c8:	8556                	mv	a0,s5
 6ca:	00000097          	auipc	ra,0x0
 6ce:	e04080e7          	jalr	-508(ra) # 4ce <putc>
 6d2:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6d4:	03c9d793          	srli	a5,s3,0x3c
 6d8:	97de                	add	a5,a5,s7
 6da:	0007c583          	lbu	a1,0(a5)
 6de:	8556                	mv	a0,s5
 6e0:	00000097          	auipc	ra,0x0
 6e4:	dee080e7          	jalr	-530(ra) # 4ce <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6e8:	0992                	slli	s3,s3,0x4
 6ea:	34fd                	addiw	s1,s1,-1
 6ec:	f4e5                	bnez	s1,6d4 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 6ee:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 6f2:	4981                	li	s3,0
 6f4:	b729                	j	5fe <vprintf+0x60>
        s = va_arg(ap, char*);
 6f6:	008b0993          	addi	s3,s6,8
 6fa:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 6fe:	c085                	beqz	s1,71e <vprintf+0x180>
        while(*s != 0){
 700:	0004c583          	lbu	a1,0(s1)
 704:	c9a1                	beqz	a1,754 <vprintf+0x1b6>
          putc(fd, *s);
 706:	8556                	mv	a0,s5
 708:	00000097          	auipc	ra,0x0
 70c:	dc6080e7          	jalr	-570(ra) # 4ce <putc>
          s++;
 710:	0485                	addi	s1,s1,1
        while(*s != 0){
 712:	0004c583          	lbu	a1,0(s1)
 716:	f9e5                	bnez	a1,706 <vprintf+0x168>
        s = va_arg(ap, char*);
 718:	8b4e                	mv	s6,s3
      state = 0;
 71a:	4981                	li	s3,0
 71c:	b5cd                	j	5fe <vprintf+0x60>
          s = "(null)";
 71e:	00000497          	auipc	s1,0x0
 722:	25a48493          	addi	s1,s1,602 # 978 <digits+0x18>
        while(*s != 0){
 726:	02800593          	li	a1,40
 72a:	bff1                	j	706 <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 72c:	008b0493          	addi	s1,s6,8
 730:	000b4583          	lbu	a1,0(s6)
 734:	8556                	mv	a0,s5
 736:	00000097          	auipc	ra,0x0
 73a:	d98080e7          	jalr	-616(ra) # 4ce <putc>
 73e:	8b26                	mv	s6,s1
      state = 0;
 740:	4981                	li	s3,0
 742:	bd75                	j	5fe <vprintf+0x60>
        putc(fd, c);
 744:	85d2                	mv	a1,s4
 746:	8556                	mv	a0,s5
 748:	00000097          	auipc	ra,0x0
 74c:	d86080e7          	jalr	-634(ra) # 4ce <putc>
      state = 0;
 750:	4981                	li	s3,0
 752:	b575                	j	5fe <vprintf+0x60>
        s = va_arg(ap, char*);
 754:	8b4e                	mv	s6,s3
      state = 0;
 756:	4981                	li	s3,0
 758:	b55d                	j	5fe <vprintf+0x60>
    }
  }
}
 75a:	70e6                	ld	ra,120(sp)
 75c:	7446                	ld	s0,112(sp)
 75e:	74a6                	ld	s1,104(sp)
 760:	7906                	ld	s2,96(sp)
 762:	69e6                	ld	s3,88(sp)
 764:	6a46                	ld	s4,80(sp)
 766:	6aa6                	ld	s5,72(sp)
 768:	6b06                	ld	s6,64(sp)
 76a:	7be2                	ld	s7,56(sp)
 76c:	7c42                	ld	s8,48(sp)
 76e:	7ca2                	ld	s9,40(sp)
 770:	7d02                	ld	s10,32(sp)
 772:	6de2                	ld	s11,24(sp)
 774:	6109                	addi	sp,sp,128
 776:	8082                	ret

0000000000000778 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 778:	715d                	addi	sp,sp,-80
 77a:	ec06                	sd	ra,24(sp)
 77c:	e822                	sd	s0,16(sp)
 77e:	1000                	addi	s0,sp,32
 780:	e010                	sd	a2,0(s0)
 782:	e414                	sd	a3,8(s0)
 784:	e818                	sd	a4,16(s0)
 786:	ec1c                	sd	a5,24(s0)
 788:	03043023          	sd	a6,32(s0)
 78c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 790:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 794:	8622                	mv	a2,s0
 796:	00000097          	auipc	ra,0x0
 79a:	e08080e7          	jalr	-504(ra) # 59e <vprintf>
}
 79e:	60e2                	ld	ra,24(sp)
 7a0:	6442                	ld	s0,16(sp)
 7a2:	6161                	addi	sp,sp,80
 7a4:	8082                	ret

00000000000007a6 <printf>:

void
printf(const char *fmt, ...)
{
 7a6:	711d                	addi	sp,sp,-96
 7a8:	ec06                	sd	ra,24(sp)
 7aa:	e822                	sd	s0,16(sp)
 7ac:	1000                	addi	s0,sp,32
 7ae:	e40c                	sd	a1,8(s0)
 7b0:	e810                	sd	a2,16(s0)
 7b2:	ec14                	sd	a3,24(s0)
 7b4:	f018                	sd	a4,32(s0)
 7b6:	f41c                	sd	a5,40(s0)
 7b8:	03043823          	sd	a6,48(s0)
 7bc:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7c0:	00840613          	addi	a2,s0,8
 7c4:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7c8:	85aa                	mv	a1,a0
 7ca:	4505                	li	a0,1
 7cc:	00000097          	auipc	ra,0x0
 7d0:	dd2080e7          	jalr	-558(ra) # 59e <vprintf>
}
 7d4:	60e2                	ld	ra,24(sp)
 7d6:	6442                	ld	s0,16(sp)
 7d8:	6125                	addi	sp,sp,96
 7da:	8082                	ret

00000000000007dc <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7dc:	1141                	addi	sp,sp,-16
 7de:	e422                	sd	s0,8(sp)
 7e0:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7e2:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7e6:	00000797          	auipc	a5,0x0
 7ea:	19a78793          	addi	a5,a5,410 # 980 <__bss_start>
 7ee:	639c                	ld	a5,0(a5)
 7f0:	a805                	j	820 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7f2:	4618                	lw	a4,8(a2)
 7f4:	9db9                	addw	a1,a1,a4
 7f6:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7fa:	6398                	ld	a4,0(a5)
 7fc:	6318                	ld	a4,0(a4)
 7fe:	fee53823          	sd	a4,-16(a0)
 802:	a091                	j	846 <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 804:	ff852703          	lw	a4,-8(a0)
 808:	9e39                	addw	a2,a2,a4
 80a:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 80c:	ff053703          	ld	a4,-16(a0)
 810:	e398                	sd	a4,0(a5)
 812:	a099                	j	858 <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 814:	6398                	ld	a4,0(a5)
 816:	00e7e463          	bltu	a5,a4,81e <free+0x42>
 81a:	00e6ea63          	bltu	a3,a4,82e <free+0x52>
{
 81e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 820:	fed7fae3          	bleu	a3,a5,814 <free+0x38>
 824:	6398                	ld	a4,0(a5)
 826:	00e6e463          	bltu	a3,a4,82e <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 82a:	fee7eae3          	bltu	a5,a4,81e <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 82e:	ff852583          	lw	a1,-8(a0)
 832:	6390                	ld	a2,0(a5)
 834:	02059713          	slli	a4,a1,0x20
 838:	9301                	srli	a4,a4,0x20
 83a:	0712                	slli	a4,a4,0x4
 83c:	9736                	add	a4,a4,a3
 83e:	fae60ae3          	beq	a2,a4,7f2 <free+0x16>
    bp->s.ptr = p->s.ptr;
 842:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 846:	4790                	lw	a2,8(a5)
 848:	02061713          	slli	a4,a2,0x20
 84c:	9301                	srli	a4,a4,0x20
 84e:	0712                	slli	a4,a4,0x4
 850:	973e                	add	a4,a4,a5
 852:	fae689e3          	beq	a3,a4,804 <free+0x28>
  } else
    p->s.ptr = bp;
 856:	e394                	sd	a3,0(a5)
  freep = p;
 858:	00000717          	auipc	a4,0x0
 85c:	12f73423          	sd	a5,296(a4) # 980 <__bss_start>
}
 860:	6422                	ld	s0,8(sp)
 862:	0141                	addi	sp,sp,16
 864:	8082                	ret

0000000000000866 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 866:	7139                	addi	sp,sp,-64
 868:	fc06                	sd	ra,56(sp)
 86a:	f822                	sd	s0,48(sp)
 86c:	f426                	sd	s1,40(sp)
 86e:	f04a                	sd	s2,32(sp)
 870:	ec4e                	sd	s3,24(sp)
 872:	e852                	sd	s4,16(sp)
 874:	e456                	sd	s5,8(sp)
 876:	e05a                	sd	s6,0(sp)
 878:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 87a:	02051993          	slli	s3,a0,0x20
 87e:	0209d993          	srli	s3,s3,0x20
 882:	09bd                	addi	s3,s3,15
 884:	0049d993          	srli	s3,s3,0x4
 888:	2985                	addiw	s3,s3,1
 88a:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 88e:	00000797          	auipc	a5,0x0
 892:	0f278793          	addi	a5,a5,242 # 980 <__bss_start>
 896:	6388                	ld	a0,0(a5)
 898:	c515                	beqz	a0,8c4 <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 89a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 89c:	4798                	lw	a4,8(a5)
 89e:	03277f63          	bleu	s2,a4,8dc <malloc+0x76>
 8a2:	8a4e                	mv	s4,s3
 8a4:	0009871b          	sext.w	a4,s3
 8a8:	6685                	lui	a3,0x1
 8aa:	00d77363          	bleu	a3,a4,8b0 <malloc+0x4a>
 8ae:	6a05                	lui	s4,0x1
 8b0:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 8b4:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8b8:	00000497          	auipc	s1,0x0
 8bc:	0c848493          	addi	s1,s1,200 # 980 <__bss_start>
  if(p == (char*)-1)
 8c0:	5b7d                	li	s6,-1
 8c2:	a885                	j	932 <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 8c4:	00000797          	auipc	a5,0x0
 8c8:	0c478793          	addi	a5,a5,196 # 988 <base>
 8cc:	00000717          	auipc	a4,0x0
 8d0:	0af73a23          	sd	a5,180(a4) # 980 <__bss_start>
 8d4:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8d6:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8da:	b7e1                	j	8a2 <malloc+0x3c>
      if(p->s.size == nunits)
 8dc:	02e90b63          	beq	s2,a4,912 <malloc+0xac>
        p->s.size -= nunits;
 8e0:	4137073b          	subw	a4,a4,s3
 8e4:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8e6:	1702                	slli	a4,a4,0x20
 8e8:	9301                	srli	a4,a4,0x20
 8ea:	0712                	slli	a4,a4,0x4
 8ec:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8ee:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8f2:	00000717          	auipc	a4,0x0
 8f6:	08a73723          	sd	a0,142(a4) # 980 <__bss_start>
      return (void*)(p + 1);
 8fa:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 8fe:	70e2                	ld	ra,56(sp)
 900:	7442                	ld	s0,48(sp)
 902:	74a2                	ld	s1,40(sp)
 904:	7902                	ld	s2,32(sp)
 906:	69e2                	ld	s3,24(sp)
 908:	6a42                	ld	s4,16(sp)
 90a:	6aa2                	ld	s5,8(sp)
 90c:	6b02                	ld	s6,0(sp)
 90e:	6121                	addi	sp,sp,64
 910:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 912:	6398                	ld	a4,0(a5)
 914:	e118                	sd	a4,0(a0)
 916:	bff1                	j	8f2 <malloc+0x8c>
  hp->s.size = nu;
 918:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 91c:	0541                	addi	a0,a0,16
 91e:	00000097          	auipc	ra,0x0
 922:	ebe080e7          	jalr	-322(ra) # 7dc <free>
  return freep;
 926:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 928:	d979                	beqz	a0,8fe <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 92a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 92c:	4798                	lw	a4,8(a5)
 92e:	fb2777e3          	bleu	s2,a4,8dc <malloc+0x76>
    if(p == freep)
 932:	6098                	ld	a4,0(s1)
 934:	853e                	mv	a0,a5
 936:	fef71ae3          	bne	a4,a5,92a <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 93a:	8552                	mv	a0,s4
 93c:	00000097          	auipc	ra,0x0
 940:	b7a080e7          	jalr	-1158(ra) # 4b6 <sbrk>
  if(p == (char*)-1)
 944:	fd651ae3          	bne	a0,s6,918 <malloc+0xb2>
        return 0;
 948:	4501                	li	a0,0
 94a:	bf55                	j	8fe <malloc+0x98>
