
user/_sleep：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

#include "user.h"

int 
main(int argc, char* argv[])
{
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
  int i;

  if(argc < 2){
   8:	4785                	li	a5,1
   a:	02a7d063          	ble	a0,a5,2a <main+0x2a>
    fprintf(2, "Usage: sleep time(unit:tick)\n");
    exit(1);
  }

  i = atoi(argv[1]);
   e:	6588                	ld	a0,8(a1)
  10:	00000097          	auipc	ra,0x0
  14:	1ba080e7          	jalr	442(ra) # 1ca <atoi>
  sleep(i);
  18:	00000097          	auipc	ra,0x0
  1c:	34e080e7          	jalr	846(ra) # 366 <sleep>

  exit(0);
  20:	4501                	li	a0,0
  22:	00000097          	auipc	ra,0x0
  26:	2b4080e7          	jalr	692(ra) # 2d6 <exit>
    fprintf(2, "Usage: sleep time(unit:tick)\n");
  2a:	00000597          	auipc	a1,0x0
  2e:	7ce58593          	addi	a1,a1,1998 # 7f8 <malloc+0xea>
  32:	4509                	li	a0,2
  34:	00000097          	auipc	ra,0x0
  38:	5ec080e7          	jalr	1516(ra) # 620 <fprintf>
    exit(1);
  3c:	4505                	li	a0,1
  3e:	00000097          	auipc	ra,0x0
  42:	298080e7          	jalr	664(ra) # 2d6 <exit>

0000000000000046 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  46:	1141                	addi	sp,sp,-16
  48:	e422                	sd	s0,8(sp)
  4a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  4c:	87aa                	mv	a5,a0
  4e:	0585                	addi	a1,a1,1
  50:	0785                	addi	a5,a5,1
  52:	fff5c703          	lbu	a4,-1(a1)
  56:	fee78fa3          	sb	a4,-1(a5)
  5a:	fb75                	bnez	a4,4e <strcpy+0x8>
    ;
  return os;
}
  5c:	6422                	ld	s0,8(sp)
  5e:	0141                	addi	sp,sp,16
  60:	8082                	ret

0000000000000062 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  62:	1141                	addi	sp,sp,-16
  64:	e422                	sd	s0,8(sp)
  66:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  68:	00054783          	lbu	a5,0(a0)
  6c:	cf91                	beqz	a5,88 <strcmp+0x26>
  6e:	0005c703          	lbu	a4,0(a1)
  72:	00f71b63          	bne	a4,a5,88 <strcmp+0x26>
    p++, q++;
  76:	0505                	addi	a0,a0,1
  78:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  7a:	00054783          	lbu	a5,0(a0)
  7e:	c789                	beqz	a5,88 <strcmp+0x26>
  80:	0005c703          	lbu	a4,0(a1)
  84:	fef709e3          	beq	a4,a5,76 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
  88:	0005c503          	lbu	a0,0(a1)
}
  8c:	40a7853b          	subw	a0,a5,a0
  90:	6422                	ld	s0,8(sp)
  92:	0141                	addi	sp,sp,16
  94:	8082                	ret

0000000000000096 <strlen>:

uint
strlen(const char *s)
{
  96:	1141                	addi	sp,sp,-16
  98:	e422                	sd	s0,8(sp)
  9a:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  9c:	00054783          	lbu	a5,0(a0)
  a0:	cf91                	beqz	a5,bc <strlen+0x26>
  a2:	0505                	addi	a0,a0,1
  a4:	87aa                	mv	a5,a0
  a6:	4685                	li	a3,1
  a8:	9e89                	subw	a3,a3,a0
  aa:	00f6853b          	addw	a0,a3,a5
  ae:	0785                	addi	a5,a5,1
  b0:	fff7c703          	lbu	a4,-1(a5)
  b4:	fb7d                	bnez	a4,aa <strlen+0x14>
    ;
  return n;
}
  b6:	6422                	ld	s0,8(sp)
  b8:	0141                	addi	sp,sp,16
  ba:	8082                	ret
  for(n = 0; s[n]; n++)
  bc:	4501                	li	a0,0
  be:	bfe5                	j	b6 <strlen+0x20>

00000000000000c0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  c0:	1141                	addi	sp,sp,-16
  c2:	e422                	sd	s0,8(sp)
  c4:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  c6:	ce09                	beqz	a2,e0 <memset+0x20>
  c8:	87aa                	mv	a5,a0
  ca:	fff6071b          	addiw	a4,a2,-1
  ce:	1702                	slli	a4,a4,0x20
  d0:	9301                	srli	a4,a4,0x20
  d2:	0705                	addi	a4,a4,1
  d4:	972a                	add	a4,a4,a0
    cdst[i] = c;
  d6:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  da:	0785                	addi	a5,a5,1
  dc:	fee79de3          	bne	a5,a4,d6 <memset+0x16>
  }
  return dst;
}
  e0:	6422                	ld	s0,8(sp)
  e2:	0141                	addi	sp,sp,16
  e4:	8082                	ret

00000000000000e6 <strchr>:

char*
strchr(const char *s, char c)
{
  e6:	1141                	addi	sp,sp,-16
  e8:	e422                	sd	s0,8(sp)
  ea:	0800                	addi	s0,sp,16
  for(; *s; s++)
  ec:	00054783          	lbu	a5,0(a0)
  f0:	cf91                	beqz	a5,10c <strchr+0x26>
    if(*s == c)
  f2:	00f58a63          	beq	a1,a5,106 <strchr+0x20>
  for(; *s; s++)
  f6:	0505                	addi	a0,a0,1
  f8:	00054783          	lbu	a5,0(a0)
  fc:	c781                	beqz	a5,104 <strchr+0x1e>
    if(*s == c)
  fe:	feb79ce3          	bne	a5,a1,f6 <strchr+0x10>
 102:	a011                	j	106 <strchr+0x20>
      return (char*)s;
  return 0;
 104:	4501                	li	a0,0
}
 106:	6422                	ld	s0,8(sp)
 108:	0141                	addi	sp,sp,16
 10a:	8082                	ret
  return 0;
 10c:	4501                	li	a0,0
 10e:	bfe5                	j	106 <strchr+0x20>

0000000000000110 <gets>:

char*
gets(char *buf, int max)
{
 110:	711d                	addi	sp,sp,-96
 112:	ec86                	sd	ra,88(sp)
 114:	e8a2                	sd	s0,80(sp)
 116:	e4a6                	sd	s1,72(sp)
 118:	e0ca                	sd	s2,64(sp)
 11a:	fc4e                	sd	s3,56(sp)
 11c:	f852                	sd	s4,48(sp)
 11e:	f456                	sd	s5,40(sp)
 120:	f05a                	sd	s6,32(sp)
 122:	ec5e                	sd	s7,24(sp)
 124:	1080                	addi	s0,sp,96
 126:	8baa                	mv	s7,a0
 128:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 12a:	892a                	mv	s2,a0
 12c:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 12e:	4aa9                	li	s5,10
 130:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 132:	0019849b          	addiw	s1,s3,1
 136:	0344d863          	ble	s4,s1,166 <gets+0x56>
    cc = read(0, &c, 1);
 13a:	4605                	li	a2,1
 13c:	faf40593          	addi	a1,s0,-81
 140:	4501                	li	a0,0
 142:	00000097          	auipc	ra,0x0
 146:	1ac080e7          	jalr	428(ra) # 2ee <read>
    if(cc < 1)
 14a:	00a05e63          	blez	a0,166 <gets+0x56>
    buf[i++] = c;
 14e:	faf44783          	lbu	a5,-81(s0)
 152:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 156:	01578763          	beq	a5,s5,164 <gets+0x54>
 15a:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 15c:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 15e:	fd679ae3          	bne	a5,s6,132 <gets+0x22>
 162:	a011                	j	166 <gets+0x56>
  for(i=0; i+1 < max; ){
 164:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 166:	99de                	add	s3,s3,s7
 168:	00098023          	sb	zero,0(s3)
  return buf;
}
 16c:	855e                	mv	a0,s7
 16e:	60e6                	ld	ra,88(sp)
 170:	6446                	ld	s0,80(sp)
 172:	64a6                	ld	s1,72(sp)
 174:	6906                	ld	s2,64(sp)
 176:	79e2                	ld	s3,56(sp)
 178:	7a42                	ld	s4,48(sp)
 17a:	7aa2                	ld	s5,40(sp)
 17c:	7b02                	ld	s6,32(sp)
 17e:	6be2                	ld	s7,24(sp)
 180:	6125                	addi	sp,sp,96
 182:	8082                	ret

0000000000000184 <stat>:

int
stat(const char *n, struct stat *st)
{
 184:	1101                	addi	sp,sp,-32
 186:	ec06                	sd	ra,24(sp)
 188:	e822                	sd	s0,16(sp)
 18a:	e426                	sd	s1,8(sp)
 18c:	e04a                	sd	s2,0(sp)
 18e:	1000                	addi	s0,sp,32
 190:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 192:	4581                	li	a1,0
 194:	00000097          	auipc	ra,0x0
 198:	182080e7          	jalr	386(ra) # 316 <open>
  if(fd < 0)
 19c:	02054563          	bltz	a0,1c6 <stat+0x42>
 1a0:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1a2:	85ca                	mv	a1,s2
 1a4:	00000097          	auipc	ra,0x0
 1a8:	18a080e7          	jalr	394(ra) # 32e <fstat>
 1ac:	892a                	mv	s2,a0
  close(fd);
 1ae:	8526                	mv	a0,s1
 1b0:	00000097          	auipc	ra,0x0
 1b4:	14e080e7          	jalr	334(ra) # 2fe <close>
  return r;
}
 1b8:	854a                	mv	a0,s2
 1ba:	60e2                	ld	ra,24(sp)
 1bc:	6442                	ld	s0,16(sp)
 1be:	64a2                	ld	s1,8(sp)
 1c0:	6902                	ld	s2,0(sp)
 1c2:	6105                	addi	sp,sp,32
 1c4:	8082                	ret
    return -1;
 1c6:	597d                	li	s2,-1
 1c8:	bfc5                	j	1b8 <stat+0x34>

00000000000001ca <atoi>:

int
atoi(const char *s)
{
 1ca:	1141                	addi	sp,sp,-16
 1cc:	e422                	sd	s0,8(sp)
 1ce:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1d0:	00054683          	lbu	a3,0(a0)
 1d4:	fd06879b          	addiw	a5,a3,-48
 1d8:	0ff7f793          	andi	a5,a5,255
 1dc:	4725                	li	a4,9
 1de:	02f76963          	bltu	a4,a5,210 <atoi+0x46>
 1e2:	862a                	mv	a2,a0
  n = 0;
 1e4:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 1e6:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 1e8:	0605                	addi	a2,a2,1
 1ea:	0025179b          	slliw	a5,a0,0x2
 1ee:	9fa9                	addw	a5,a5,a0
 1f0:	0017979b          	slliw	a5,a5,0x1
 1f4:	9fb5                	addw	a5,a5,a3
 1f6:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 1fa:	00064683          	lbu	a3,0(a2)
 1fe:	fd06871b          	addiw	a4,a3,-48
 202:	0ff77713          	andi	a4,a4,255
 206:	fee5f1e3          	bleu	a4,a1,1e8 <atoi+0x1e>
  return n;
}
 20a:	6422                	ld	s0,8(sp)
 20c:	0141                	addi	sp,sp,16
 20e:	8082                	ret
  n = 0;
 210:	4501                	li	a0,0
 212:	bfe5                	j	20a <atoi+0x40>

0000000000000214 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 214:	1141                	addi	sp,sp,-16
 216:	e422                	sd	s0,8(sp)
 218:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 21a:	02b57663          	bleu	a1,a0,246 <memmove+0x32>
    while(n-- > 0)
 21e:	02c05163          	blez	a2,240 <memmove+0x2c>
 222:	fff6079b          	addiw	a5,a2,-1
 226:	1782                	slli	a5,a5,0x20
 228:	9381                	srli	a5,a5,0x20
 22a:	0785                	addi	a5,a5,1
 22c:	97aa                	add	a5,a5,a0
  dst = vdst;
 22e:	872a                	mv	a4,a0
      *dst++ = *src++;
 230:	0585                	addi	a1,a1,1
 232:	0705                	addi	a4,a4,1
 234:	fff5c683          	lbu	a3,-1(a1)
 238:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 23c:	fee79ae3          	bne	a5,a4,230 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 240:	6422                	ld	s0,8(sp)
 242:	0141                	addi	sp,sp,16
 244:	8082                	ret
    dst += n;
 246:	00c50733          	add	a4,a0,a2
    src += n;
 24a:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 24c:	fec05ae3          	blez	a2,240 <memmove+0x2c>
 250:	fff6079b          	addiw	a5,a2,-1
 254:	1782                	slli	a5,a5,0x20
 256:	9381                	srli	a5,a5,0x20
 258:	fff7c793          	not	a5,a5
 25c:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 25e:	15fd                	addi	a1,a1,-1
 260:	177d                	addi	a4,a4,-1
 262:	0005c683          	lbu	a3,0(a1)
 266:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 26a:	fef71ae3          	bne	a4,a5,25e <memmove+0x4a>
 26e:	bfc9                	j	240 <memmove+0x2c>

0000000000000270 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 270:	1141                	addi	sp,sp,-16
 272:	e422                	sd	s0,8(sp)
 274:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 276:	ce15                	beqz	a2,2b2 <memcmp+0x42>
 278:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
 27c:	00054783          	lbu	a5,0(a0)
 280:	0005c703          	lbu	a4,0(a1)
 284:	02e79063          	bne	a5,a4,2a4 <memcmp+0x34>
 288:	1682                	slli	a3,a3,0x20
 28a:	9281                	srli	a3,a3,0x20
 28c:	0685                	addi	a3,a3,1
 28e:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
 290:	0505                	addi	a0,a0,1
    p2++;
 292:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 294:	00d50d63          	beq	a0,a3,2ae <memcmp+0x3e>
    if (*p1 != *p2) {
 298:	00054783          	lbu	a5,0(a0)
 29c:	0005c703          	lbu	a4,0(a1)
 2a0:	fee788e3          	beq	a5,a4,290 <memcmp+0x20>
      return *p1 - *p2;
 2a4:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
 2a8:	6422                	ld	s0,8(sp)
 2aa:	0141                	addi	sp,sp,16
 2ac:	8082                	ret
  return 0;
 2ae:	4501                	li	a0,0
 2b0:	bfe5                	j	2a8 <memcmp+0x38>
 2b2:	4501                	li	a0,0
 2b4:	bfd5                	j	2a8 <memcmp+0x38>

00000000000002b6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2b6:	1141                	addi	sp,sp,-16
 2b8:	e406                	sd	ra,8(sp)
 2ba:	e022                	sd	s0,0(sp)
 2bc:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2be:	00000097          	auipc	ra,0x0
 2c2:	f56080e7          	jalr	-170(ra) # 214 <memmove>
}
 2c6:	60a2                	ld	ra,8(sp)
 2c8:	6402                	ld	s0,0(sp)
 2ca:	0141                	addi	sp,sp,16
 2cc:	8082                	ret

00000000000002ce <fork>:
 2ce:	4885                	li	a7,1
 2d0:	00000073          	ecall
 2d4:	8082                	ret

00000000000002d6 <exit>:
 2d6:	4889                	li	a7,2
 2d8:	00000073          	ecall
 2dc:	8082                	ret

00000000000002de <wait>:
 2de:	488d                	li	a7,3
 2e0:	00000073          	ecall
 2e4:	8082                	ret

00000000000002e6 <pipe>:
 2e6:	4891                	li	a7,4
 2e8:	00000073          	ecall
 2ec:	8082                	ret

00000000000002ee <read>:
 2ee:	4895                	li	a7,5
 2f0:	00000073          	ecall
 2f4:	8082                	ret

00000000000002f6 <write>:
 2f6:	48c1                	li	a7,16
 2f8:	00000073          	ecall
 2fc:	8082                	ret

00000000000002fe <close>:
 2fe:	48d5                	li	a7,21
 300:	00000073          	ecall
 304:	8082                	ret

0000000000000306 <kill>:
 306:	4899                	li	a7,6
 308:	00000073          	ecall
 30c:	8082                	ret

000000000000030e <exec>:
 30e:	489d                	li	a7,7
 310:	00000073          	ecall
 314:	8082                	ret

0000000000000316 <open>:
 316:	48bd                	li	a7,15
 318:	00000073          	ecall
 31c:	8082                	ret

000000000000031e <mknod>:
 31e:	48c5                	li	a7,17
 320:	00000073          	ecall
 324:	8082                	ret

0000000000000326 <unlink>:
 326:	48c9                	li	a7,18
 328:	00000073          	ecall
 32c:	8082                	ret

000000000000032e <fstat>:
 32e:	48a1                	li	a7,8
 330:	00000073          	ecall
 334:	8082                	ret

0000000000000336 <link>:
 336:	48cd                	li	a7,19
 338:	00000073          	ecall
 33c:	8082                	ret

000000000000033e <mkdir>:
 33e:	48d1                	li	a7,20
 340:	00000073          	ecall
 344:	8082                	ret

0000000000000346 <chdir>:
 346:	48a5                	li	a7,9
 348:	00000073          	ecall
 34c:	8082                	ret

000000000000034e <dup>:
 34e:	48a9                	li	a7,10
 350:	00000073          	ecall
 354:	8082                	ret

0000000000000356 <getpid>:
 356:	48ad                	li	a7,11
 358:	00000073          	ecall
 35c:	8082                	ret

000000000000035e <sbrk>:
 35e:	48b1                	li	a7,12
 360:	00000073          	ecall
 364:	8082                	ret

0000000000000366 <sleep>:
 366:	48b5                	li	a7,13
 368:	00000073          	ecall
 36c:	8082                	ret

000000000000036e <uptime>:
 36e:	48b9                	li	a7,14
 370:	00000073          	ecall
 374:	8082                	ret

0000000000000376 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 376:	1101                	addi	sp,sp,-32
 378:	ec06                	sd	ra,24(sp)
 37a:	e822                	sd	s0,16(sp)
 37c:	1000                	addi	s0,sp,32
 37e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 382:	4605                	li	a2,1
 384:	fef40593          	addi	a1,s0,-17
 388:	00000097          	auipc	ra,0x0
 38c:	f6e080e7          	jalr	-146(ra) # 2f6 <write>
}
 390:	60e2                	ld	ra,24(sp)
 392:	6442                	ld	s0,16(sp)
 394:	6105                	addi	sp,sp,32
 396:	8082                	ret

0000000000000398 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 398:	7139                	addi	sp,sp,-64
 39a:	fc06                	sd	ra,56(sp)
 39c:	f822                	sd	s0,48(sp)
 39e:	f426                	sd	s1,40(sp)
 3a0:	f04a                	sd	s2,32(sp)
 3a2:	ec4e                	sd	s3,24(sp)
 3a4:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3a6:	c299                	beqz	a3,3ac <printint+0x14>
 3a8:	0005cd63          	bltz	a1,3c2 <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 3ac:	2581                	sext.w	a1,a1
  neg = 0;
 3ae:	4301                	li	t1,0
 3b0:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 3b4:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 3b6:	2601                	sext.w	a2,a2
 3b8:	00000897          	auipc	a7,0x0
 3bc:	46088893          	addi	a7,a7,1120 # 818 <digits>
 3c0:	a801                	j	3d0 <printint+0x38>
    x = -xx;
 3c2:	40b005bb          	negw	a1,a1
 3c6:	2581                	sext.w	a1,a1
    neg = 1;
 3c8:	4305                	li	t1,1
    x = -xx;
 3ca:	b7dd                	j	3b0 <printint+0x18>
  }while((x /= base) != 0);
 3cc:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 3ce:	8836                	mv	a6,a3
 3d0:	0018069b          	addiw	a3,a6,1
 3d4:	02c5f7bb          	remuw	a5,a1,a2
 3d8:	1782                	slli	a5,a5,0x20
 3da:	9381                	srli	a5,a5,0x20
 3dc:	97c6                	add	a5,a5,a7
 3de:	0007c783          	lbu	a5,0(a5)
 3e2:	00f70023          	sb	a5,0(a4)
  }while((x /= base) != 0);
 3e6:	0705                	addi	a4,a4,1
 3e8:	02c5d7bb          	divuw	a5,a1,a2
 3ec:	fec5f0e3          	bleu	a2,a1,3cc <printint+0x34>
  if(neg)
 3f0:	00030b63          	beqz	t1,406 <printint+0x6e>
    buf[i++] = '-';
 3f4:	fd040793          	addi	a5,s0,-48
 3f8:	96be                	add	a3,a3,a5
 3fa:	02d00793          	li	a5,45
 3fe:	fef68823          	sb	a5,-16(a3)
 402:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 406:	02d05963          	blez	a3,438 <printint+0xa0>
 40a:	89aa                	mv	s3,a0
 40c:	fc040793          	addi	a5,s0,-64
 410:	00d784b3          	add	s1,a5,a3
 414:	fff78913          	addi	s2,a5,-1
 418:	9936                	add	s2,s2,a3
 41a:	36fd                	addiw	a3,a3,-1
 41c:	1682                	slli	a3,a3,0x20
 41e:	9281                	srli	a3,a3,0x20
 420:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 424:	fff4c583          	lbu	a1,-1(s1)
 428:	854e                	mv	a0,s3
 42a:	00000097          	auipc	ra,0x0
 42e:	f4c080e7          	jalr	-180(ra) # 376 <putc>
  while(--i >= 0)
 432:	14fd                	addi	s1,s1,-1
 434:	ff2498e3          	bne	s1,s2,424 <printint+0x8c>
}
 438:	70e2                	ld	ra,56(sp)
 43a:	7442                	ld	s0,48(sp)
 43c:	74a2                	ld	s1,40(sp)
 43e:	7902                	ld	s2,32(sp)
 440:	69e2                	ld	s3,24(sp)
 442:	6121                	addi	sp,sp,64
 444:	8082                	ret

0000000000000446 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 446:	7119                	addi	sp,sp,-128
 448:	fc86                	sd	ra,120(sp)
 44a:	f8a2                	sd	s0,112(sp)
 44c:	f4a6                	sd	s1,104(sp)
 44e:	f0ca                	sd	s2,96(sp)
 450:	ecce                	sd	s3,88(sp)
 452:	e8d2                	sd	s4,80(sp)
 454:	e4d6                	sd	s5,72(sp)
 456:	e0da                	sd	s6,64(sp)
 458:	fc5e                	sd	s7,56(sp)
 45a:	f862                	sd	s8,48(sp)
 45c:	f466                	sd	s9,40(sp)
 45e:	f06a                	sd	s10,32(sp)
 460:	ec6e                	sd	s11,24(sp)
 462:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 464:	0005c483          	lbu	s1,0(a1)
 468:	18048d63          	beqz	s1,602 <vprintf+0x1bc>
 46c:	8aaa                	mv	s5,a0
 46e:	8b32                	mv	s6,a2
 470:	00158913          	addi	s2,a1,1
  state = 0;
 474:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 476:	02500a13          	li	s4,37
      if(c == 'd'){
 47a:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 47e:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 482:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 486:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 48a:	00000b97          	auipc	s7,0x0
 48e:	38eb8b93          	addi	s7,s7,910 # 818 <digits>
 492:	a839                	j	4b0 <vprintf+0x6a>
        putc(fd, c);
 494:	85a6                	mv	a1,s1
 496:	8556                	mv	a0,s5
 498:	00000097          	auipc	ra,0x0
 49c:	ede080e7          	jalr	-290(ra) # 376 <putc>
 4a0:	a019                	j	4a6 <vprintf+0x60>
    } else if(state == '%'){
 4a2:	01498f63          	beq	s3,s4,4c0 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 4a6:	0905                	addi	s2,s2,1
 4a8:	fff94483          	lbu	s1,-1(s2)
 4ac:	14048b63          	beqz	s1,602 <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 4b0:	0004879b          	sext.w	a5,s1
    if(state == 0){
 4b4:	fe0997e3          	bnez	s3,4a2 <vprintf+0x5c>
      if(c == '%'){
 4b8:	fd479ee3          	bne	a5,s4,494 <vprintf+0x4e>
        state = '%';
 4bc:	89be                	mv	s3,a5
 4be:	b7e5                	j	4a6 <vprintf+0x60>
      if(c == 'd'){
 4c0:	05878063          	beq	a5,s8,500 <vprintf+0xba>
      } else if(c == 'l') {
 4c4:	05978c63          	beq	a5,s9,51c <vprintf+0xd6>
      } else if(c == 'x') {
 4c8:	07a78863          	beq	a5,s10,538 <vprintf+0xf2>
      } else if(c == 'p') {
 4cc:	09b78463          	beq	a5,s11,554 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 4d0:	07300713          	li	a4,115
 4d4:	0ce78563          	beq	a5,a4,59e <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 4d8:	06300713          	li	a4,99
 4dc:	0ee78c63          	beq	a5,a4,5d4 <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 4e0:	11478663          	beq	a5,s4,5ec <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 4e4:	85d2                	mv	a1,s4
 4e6:	8556                	mv	a0,s5
 4e8:	00000097          	auipc	ra,0x0
 4ec:	e8e080e7          	jalr	-370(ra) # 376 <putc>
        putc(fd, c);
 4f0:	85a6                	mv	a1,s1
 4f2:	8556                	mv	a0,s5
 4f4:	00000097          	auipc	ra,0x0
 4f8:	e82080e7          	jalr	-382(ra) # 376 <putc>
      }
      state = 0;
 4fc:	4981                	li	s3,0
 4fe:	b765                	j	4a6 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 500:	008b0493          	addi	s1,s6,8
 504:	4685                	li	a3,1
 506:	4629                	li	a2,10
 508:	000b2583          	lw	a1,0(s6)
 50c:	8556                	mv	a0,s5
 50e:	00000097          	auipc	ra,0x0
 512:	e8a080e7          	jalr	-374(ra) # 398 <printint>
 516:	8b26                	mv	s6,s1
      state = 0;
 518:	4981                	li	s3,0
 51a:	b771                	j	4a6 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 51c:	008b0493          	addi	s1,s6,8
 520:	4681                	li	a3,0
 522:	4629                	li	a2,10
 524:	000b2583          	lw	a1,0(s6)
 528:	8556                	mv	a0,s5
 52a:	00000097          	auipc	ra,0x0
 52e:	e6e080e7          	jalr	-402(ra) # 398 <printint>
 532:	8b26                	mv	s6,s1
      state = 0;
 534:	4981                	li	s3,0
 536:	bf85                	j	4a6 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 538:	008b0493          	addi	s1,s6,8
 53c:	4681                	li	a3,0
 53e:	4641                	li	a2,16
 540:	000b2583          	lw	a1,0(s6)
 544:	8556                	mv	a0,s5
 546:	00000097          	auipc	ra,0x0
 54a:	e52080e7          	jalr	-430(ra) # 398 <printint>
 54e:	8b26                	mv	s6,s1
      state = 0;
 550:	4981                	li	s3,0
 552:	bf91                	j	4a6 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 554:	008b0793          	addi	a5,s6,8
 558:	f8f43423          	sd	a5,-120(s0)
 55c:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 560:	03000593          	li	a1,48
 564:	8556                	mv	a0,s5
 566:	00000097          	auipc	ra,0x0
 56a:	e10080e7          	jalr	-496(ra) # 376 <putc>
  putc(fd, 'x');
 56e:	85ea                	mv	a1,s10
 570:	8556                	mv	a0,s5
 572:	00000097          	auipc	ra,0x0
 576:	e04080e7          	jalr	-508(ra) # 376 <putc>
 57a:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 57c:	03c9d793          	srli	a5,s3,0x3c
 580:	97de                	add	a5,a5,s7
 582:	0007c583          	lbu	a1,0(a5)
 586:	8556                	mv	a0,s5
 588:	00000097          	auipc	ra,0x0
 58c:	dee080e7          	jalr	-530(ra) # 376 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 590:	0992                	slli	s3,s3,0x4
 592:	34fd                	addiw	s1,s1,-1
 594:	f4e5                	bnez	s1,57c <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 596:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 59a:	4981                	li	s3,0
 59c:	b729                	j	4a6 <vprintf+0x60>
        s = va_arg(ap, char*);
 59e:	008b0993          	addi	s3,s6,8
 5a2:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 5a6:	c085                	beqz	s1,5c6 <vprintf+0x180>
        while(*s != 0){
 5a8:	0004c583          	lbu	a1,0(s1)
 5ac:	c9a1                	beqz	a1,5fc <vprintf+0x1b6>
          putc(fd, *s);
 5ae:	8556                	mv	a0,s5
 5b0:	00000097          	auipc	ra,0x0
 5b4:	dc6080e7          	jalr	-570(ra) # 376 <putc>
          s++;
 5b8:	0485                	addi	s1,s1,1
        while(*s != 0){
 5ba:	0004c583          	lbu	a1,0(s1)
 5be:	f9e5                	bnez	a1,5ae <vprintf+0x168>
        s = va_arg(ap, char*);
 5c0:	8b4e                	mv	s6,s3
      state = 0;
 5c2:	4981                	li	s3,0
 5c4:	b5cd                	j	4a6 <vprintf+0x60>
          s = "(null)";
 5c6:	00000497          	auipc	s1,0x0
 5ca:	26a48493          	addi	s1,s1,618 # 830 <digits+0x18>
        while(*s != 0){
 5ce:	02800593          	li	a1,40
 5d2:	bff1                	j	5ae <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 5d4:	008b0493          	addi	s1,s6,8
 5d8:	000b4583          	lbu	a1,0(s6)
 5dc:	8556                	mv	a0,s5
 5de:	00000097          	auipc	ra,0x0
 5e2:	d98080e7          	jalr	-616(ra) # 376 <putc>
 5e6:	8b26                	mv	s6,s1
      state = 0;
 5e8:	4981                	li	s3,0
 5ea:	bd75                	j	4a6 <vprintf+0x60>
        putc(fd, c);
 5ec:	85d2                	mv	a1,s4
 5ee:	8556                	mv	a0,s5
 5f0:	00000097          	auipc	ra,0x0
 5f4:	d86080e7          	jalr	-634(ra) # 376 <putc>
      state = 0;
 5f8:	4981                	li	s3,0
 5fa:	b575                	j	4a6 <vprintf+0x60>
        s = va_arg(ap, char*);
 5fc:	8b4e                	mv	s6,s3
      state = 0;
 5fe:	4981                	li	s3,0
 600:	b55d                	j	4a6 <vprintf+0x60>
    }
  }
}
 602:	70e6                	ld	ra,120(sp)
 604:	7446                	ld	s0,112(sp)
 606:	74a6                	ld	s1,104(sp)
 608:	7906                	ld	s2,96(sp)
 60a:	69e6                	ld	s3,88(sp)
 60c:	6a46                	ld	s4,80(sp)
 60e:	6aa6                	ld	s5,72(sp)
 610:	6b06                	ld	s6,64(sp)
 612:	7be2                	ld	s7,56(sp)
 614:	7c42                	ld	s8,48(sp)
 616:	7ca2                	ld	s9,40(sp)
 618:	7d02                	ld	s10,32(sp)
 61a:	6de2                	ld	s11,24(sp)
 61c:	6109                	addi	sp,sp,128
 61e:	8082                	ret

0000000000000620 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 620:	715d                	addi	sp,sp,-80
 622:	ec06                	sd	ra,24(sp)
 624:	e822                	sd	s0,16(sp)
 626:	1000                	addi	s0,sp,32
 628:	e010                	sd	a2,0(s0)
 62a:	e414                	sd	a3,8(s0)
 62c:	e818                	sd	a4,16(s0)
 62e:	ec1c                	sd	a5,24(s0)
 630:	03043023          	sd	a6,32(s0)
 634:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 638:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 63c:	8622                	mv	a2,s0
 63e:	00000097          	auipc	ra,0x0
 642:	e08080e7          	jalr	-504(ra) # 446 <vprintf>
}
 646:	60e2                	ld	ra,24(sp)
 648:	6442                	ld	s0,16(sp)
 64a:	6161                	addi	sp,sp,80
 64c:	8082                	ret

000000000000064e <printf>:

void
printf(const char *fmt, ...)
{
 64e:	711d                	addi	sp,sp,-96
 650:	ec06                	sd	ra,24(sp)
 652:	e822                	sd	s0,16(sp)
 654:	1000                	addi	s0,sp,32
 656:	e40c                	sd	a1,8(s0)
 658:	e810                	sd	a2,16(s0)
 65a:	ec14                	sd	a3,24(s0)
 65c:	f018                	sd	a4,32(s0)
 65e:	f41c                	sd	a5,40(s0)
 660:	03043823          	sd	a6,48(s0)
 664:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 668:	00840613          	addi	a2,s0,8
 66c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 670:	85aa                	mv	a1,a0
 672:	4505                	li	a0,1
 674:	00000097          	auipc	ra,0x0
 678:	dd2080e7          	jalr	-558(ra) # 446 <vprintf>
}
 67c:	60e2                	ld	ra,24(sp)
 67e:	6442                	ld	s0,16(sp)
 680:	6125                	addi	sp,sp,96
 682:	8082                	ret

0000000000000684 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 684:	1141                	addi	sp,sp,-16
 686:	e422                	sd	s0,8(sp)
 688:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 68a:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 68e:	00000797          	auipc	a5,0x0
 692:	1aa78793          	addi	a5,a5,426 # 838 <__bss_start>
 696:	639c                	ld	a5,0(a5)
 698:	a805                	j	6c8 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 69a:	4618                	lw	a4,8(a2)
 69c:	9db9                	addw	a1,a1,a4
 69e:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 6a2:	6398                	ld	a4,0(a5)
 6a4:	6318                	ld	a4,0(a4)
 6a6:	fee53823          	sd	a4,-16(a0)
 6aa:	a091                	j	6ee <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 6ac:	ff852703          	lw	a4,-8(a0)
 6b0:	9e39                	addw	a2,a2,a4
 6b2:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 6b4:	ff053703          	ld	a4,-16(a0)
 6b8:	e398                	sd	a4,0(a5)
 6ba:	a099                	j	700 <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6bc:	6398                	ld	a4,0(a5)
 6be:	00e7e463          	bltu	a5,a4,6c6 <free+0x42>
 6c2:	00e6ea63          	bltu	a3,a4,6d6 <free+0x52>
{
 6c6:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6c8:	fed7fae3          	bleu	a3,a5,6bc <free+0x38>
 6cc:	6398                	ld	a4,0(a5)
 6ce:	00e6e463          	bltu	a3,a4,6d6 <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6d2:	fee7eae3          	bltu	a5,a4,6c6 <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 6d6:	ff852583          	lw	a1,-8(a0)
 6da:	6390                	ld	a2,0(a5)
 6dc:	02059713          	slli	a4,a1,0x20
 6e0:	9301                	srli	a4,a4,0x20
 6e2:	0712                	slli	a4,a4,0x4
 6e4:	9736                	add	a4,a4,a3
 6e6:	fae60ae3          	beq	a2,a4,69a <free+0x16>
    bp->s.ptr = p->s.ptr;
 6ea:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 6ee:	4790                	lw	a2,8(a5)
 6f0:	02061713          	slli	a4,a2,0x20
 6f4:	9301                	srli	a4,a4,0x20
 6f6:	0712                	slli	a4,a4,0x4
 6f8:	973e                	add	a4,a4,a5
 6fa:	fae689e3          	beq	a3,a4,6ac <free+0x28>
  } else
    p->s.ptr = bp;
 6fe:	e394                	sd	a3,0(a5)
  freep = p;
 700:	00000717          	auipc	a4,0x0
 704:	12f73c23          	sd	a5,312(a4) # 838 <__bss_start>
}
 708:	6422                	ld	s0,8(sp)
 70a:	0141                	addi	sp,sp,16
 70c:	8082                	ret

000000000000070e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 70e:	7139                	addi	sp,sp,-64
 710:	fc06                	sd	ra,56(sp)
 712:	f822                	sd	s0,48(sp)
 714:	f426                	sd	s1,40(sp)
 716:	f04a                	sd	s2,32(sp)
 718:	ec4e                	sd	s3,24(sp)
 71a:	e852                	sd	s4,16(sp)
 71c:	e456                	sd	s5,8(sp)
 71e:	e05a                	sd	s6,0(sp)
 720:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 722:	02051993          	slli	s3,a0,0x20
 726:	0209d993          	srli	s3,s3,0x20
 72a:	09bd                	addi	s3,s3,15
 72c:	0049d993          	srli	s3,s3,0x4
 730:	2985                	addiw	s3,s3,1
 732:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 736:	00000797          	auipc	a5,0x0
 73a:	10278793          	addi	a5,a5,258 # 838 <__bss_start>
 73e:	6388                	ld	a0,0(a5)
 740:	c515                	beqz	a0,76c <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 742:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 744:	4798                	lw	a4,8(a5)
 746:	03277f63          	bleu	s2,a4,784 <malloc+0x76>
 74a:	8a4e                	mv	s4,s3
 74c:	0009871b          	sext.w	a4,s3
 750:	6685                	lui	a3,0x1
 752:	00d77363          	bleu	a3,a4,758 <malloc+0x4a>
 756:	6a05                	lui	s4,0x1
 758:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 75c:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 760:	00000497          	auipc	s1,0x0
 764:	0d848493          	addi	s1,s1,216 # 838 <__bss_start>
  if(p == (char*)-1)
 768:	5b7d                	li	s6,-1
 76a:	a885                	j	7da <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 76c:	00000797          	auipc	a5,0x0
 770:	0d478793          	addi	a5,a5,212 # 840 <base>
 774:	00000717          	auipc	a4,0x0
 778:	0cf73223          	sd	a5,196(a4) # 838 <__bss_start>
 77c:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 77e:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 782:	b7e1                	j	74a <malloc+0x3c>
      if(p->s.size == nunits)
 784:	02e90b63          	beq	s2,a4,7ba <malloc+0xac>
        p->s.size -= nunits;
 788:	4137073b          	subw	a4,a4,s3
 78c:	c798                	sw	a4,8(a5)
        p += p->s.size;
 78e:	1702                	slli	a4,a4,0x20
 790:	9301                	srli	a4,a4,0x20
 792:	0712                	slli	a4,a4,0x4
 794:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 796:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 79a:	00000717          	auipc	a4,0x0
 79e:	08a73f23          	sd	a0,158(a4) # 838 <__bss_start>
      return (void*)(p + 1);
 7a2:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 7a6:	70e2                	ld	ra,56(sp)
 7a8:	7442                	ld	s0,48(sp)
 7aa:	74a2                	ld	s1,40(sp)
 7ac:	7902                	ld	s2,32(sp)
 7ae:	69e2                	ld	s3,24(sp)
 7b0:	6a42                	ld	s4,16(sp)
 7b2:	6aa2                	ld	s5,8(sp)
 7b4:	6b02                	ld	s6,0(sp)
 7b6:	6121                	addi	sp,sp,64
 7b8:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 7ba:	6398                	ld	a4,0(a5)
 7bc:	e118                	sd	a4,0(a0)
 7be:	bff1                	j	79a <malloc+0x8c>
  hp->s.size = nu;
 7c0:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 7c4:	0541                	addi	a0,a0,16
 7c6:	00000097          	auipc	ra,0x0
 7ca:	ebe080e7          	jalr	-322(ra) # 684 <free>
  return freep;
 7ce:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 7d0:	d979                	beqz	a0,7a6 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7d2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7d4:	4798                	lw	a4,8(a5)
 7d6:	fb2777e3          	bleu	s2,a4,784 <malloc+0x76>
    if(p == freep)
 7da:	6098                	ld	a4,0(s1)
 7dc:	853e                	mv	a0,a5
 7de:	fef71ae3          	bne	a4,a5,7d2 <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 7e2:	8552                	mv	a0,s4
 7e4:	00000097          	auipc	ra,0x0
 7e8:	b7a080e7          	jalr	-1158(ra) # 35e <sbrk>
  if(p == (char*)-1)
 7ec:	fd651ae3          	bne	a0,s6,7c0 <malloc+0xb2>
        return 0;
 7f0:	4501                	li	a0,0
 7f2:	bf55                	j	7a6 <malloc+0x98>
