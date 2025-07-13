
user/_xargs：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <readline>:
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/param.h"

int readline(char *new_argv[32], int curr_argc){
   0:	bc010113          	addi	sp,sp,-1088
   4:	42113c23          	sd	ra,1080(sp)
   8:	42813823          	sd	s0,1072(sp)
   c:	42913423          	sd	s1,1064(sp)
  10:	43213023          	sd	s2,1056(sp)
  14:	41313c23          	sd	s3,1048(sp)
  18:	41413823          	sd	s4,1040(sp)
  1c:	41513423          	sd	s5,1032(sp)
  20:	41613023          	sd	s6,1024(sp)
  24:	44010413          	addi	s0,sp,1088
  28:	8a2a                	mv	s4,a0
  2a:	89ae                	mv	s3,a1
	char buf[1024];
	int n = 0;
	while(read(0, buf+n, 1)){
  2c:	bc040913          	addi	s2,s0,-1088
	int n = 0;
  30:	4481                	li	s1,0
		if (n == 1023)
  32:	3ff00a93          	li	s5,1023
		{
			fprintf(2, "argument is too long\n");
			exit(1);
		}
		if (buf[n] == '\n')
  36:	4b29                	li	s6,10
	while(read(0, buf+n, 1)){
  38:	4605                	li	a2,1
  3a:	85ca                	mv	a1,s2
  3c:	4501                	li	a0,0
  3e:	00000097          	auipc	ra,0x0
  42:	484080e7          	jalr	1156(ra) # 4c2 <read>
  46:	c905                	beqz	a0,76 <readline+0x76>
		if (n == 1023)
  48:	01548963          	beq	s1,s5,5a <readline+0x5a>
		if (buf[n] == '\n')
  4c:	0905                	addi	s2,s2,1
  4e:	fff94783          	lbu	a5,-1(s2)
  52:	03678263          	beq	a5,s6,76 <readline+0x76>
		{
			break;
		}
		n++;
  56:	2485                	addiw	s1,s1,1
  58:	b7c5                	j	38 <readline+0x38>
			fprintf(2, "argument is too long\n");
  5a:	00001597          	auipc	a1,0x1
  5e:	96e58593          	addi	a1,a1,-1682 # 9c8 <malloc+0xe6>
  62:	4509                	li	a0,2
  64:	00000097          	auipc	ra,0x0
  68:	790080e7          	jalr	1936(ra) # 7f4 <fprintf>
			exit(1);
  6c:	4505                	li	a0,1
  6e:	00000097          	auipc	ra,0x0
  72:	43c080e7          	jalr	1084(ra) # 4aa <exit>
	}
	buf[n] = 0;
  76:	fc040793          	addi	a5,s0,-64
  7a:	97a6                	add	a5,a5,s1
  7c:	c0078023          	sb	zero,-1024(a5)
    /* you can read what? */
    /* In xargstest.sh, you can accept find res as arguments*/
    /* printf("buf = %s\n", buf); */
	if (n == 0)return 0;
  80:	c4bd                	beqz	s1,ee <readline+0xee>
	int offset = 0;
	while(offset < n){
  82:	04905463          	blez	s1,ca <readline+0xca>
  86:	00399593          	slli	a1,s3,0x3
  8a:	95d2                	add	a1,a1,s4
	int offset = 0;
  8c:	4781                	li	a5,0
		new_argv[curr_argc++] = buf + offset;
		while(buf[offset] != ' ' && offset < n){
  8e:	02000693          	li	a3,32
  92:	a021                	j	9a <readline+0x9a>
	while(offset < n){
  94:	05a1                	addi	a1,a1,8
  96:	0297d863          	ble	s1,a5,c6 <readline+0xc6>
		new_argv[curr_argc++] = buf + offset;
  9a:	2985                	addiw	s3,s3,1
  9c:	bc040713          	addi	a4,s0,-1088
  a0:	973e                	add	a4,a4,a5
  a2:	e198                	sd	a4,0(a1)
		while(buf[offset] != ' ' && offset < n){
  a4:	fc040613          	addi	a2,s0,-64
  a8:	963e                	add	a2,a2,a5
  aa:	c0064603          	lbu	a2,-1024(a2)
  ae:	02d60063          	beq	a2,a3,ce <readline+0xce>
  b2:	0097da63          	ble	s1,a5,c6 <readline+0xc6>
			offset++;
  b6:	2785                	addiw	a5,a5,1
		while(buf[offset] != ' ' && offset < n){
  b8:	00174603          	lbu	a2,1(a4)
  bc:	00d60963          	beq	a2,a3,ce <readline+0xce>
  c0:	0705                	addi	a4,a4,1
  c2:	fef49ae3          	bne	s1,a5,b6 <readline+0xb6>
		new_argv[curr_argc++] = buf + offset;
  c6:	84ce                	mv	s1,s3
  c8:	a01d                	j	ee <readline+0xee>
	while(offset < n){
  ca:	84ce                	mv	s1,s3
  cc:	a00d                	j	ee <readline+0xee>
		}
		while(buf[offset] == ' ' && offset < n){
  ce:	0097df63          	ble	s1,a5,ec <readline+0xec>
  d2:	bc040713          	addi	a4,s0,-1088
  d6:	973e                	add	a4,a4,a5
			buf[offset++] = 0;
  d8:	2785                	addiw	a5,a5,1
  da:	00070023          	sb	zero,0(a4)
		while(buf[offset] == ' ' && offset < n){
  de:	00174603          	lbu	a2,1(a4)
  e2:	fad619e3          	bne	a2,a3,94 <readline+0x94>
  e6:	0705                	addi	a4,a4,1
  e8:	fef498e3          	bne	s1,a5,d8 <readline+0xd8>
	int offset = 0;
  ec:	84ce                	mv	s1,s3
		}
	}
	return curr_argc;
}
  ee:	8526                	mv	a0,s1
  f0:	43813083          	ld	ra,1080(sp)
  f4:	43013403          	ld	s0,1072(sp)
  f8:	42813483          	ld	s1,1064(sp)
  fc:	42013903          	ld	s2,1056(sp)
 100:	41813983          	ld	s3,1048(sp)
 104:	41013a03          	ld	s4,1040(sp)
 108:	40813a83          	ld	s5,1032(sp)
 10c:	40013b03          	ld	s6,1024(sp)
 110:	44010113          	addi	sp,sp,1088
 114:	8082                	ret

0000000000000116 <main>:

int main(int argc, char const *argv[])
{
 116:	7129                	addi	sp,sp,-320
 118:	fe06                	sd	ra,312(sp)
 11a:	fa22                	sd	s0,304(sp)
 11c:	f626                	sd	s1,296(sp)
 11e:	f24a                	sd	s2,288(sp)
 120:	ee4e                	sd	s3,280(sp)
 122:	ea52                	sd	s4,272(sp)
 124:	e656                	sd	s5,264(sp)
 126:	e25a                	sd	s6,256(sp)
 128:	0280                	addi	s0,sp,320
	if (argc <= 1)
 12a:	4785                	li	a5,1
 12c:	0aa7d063          	ble	a0,a5,1cc <main+0xb6>
 130:	89aa                	mv	s3,a0
 132:	8b2e                	mv	s6,a1
	{
		fprintf(2, "Usage: xargs command (arg ...)\n");
		exit(1);
	}
	char *command = malloc(strlen(argv[1]) + 1);
 134:	6588                	ld	a0,8(a1)
 136:	00000097          	auipc	ra,0x0
 13a:	134080e7          	jalr	308(ra) # 26a <strlen>
 13e:	2505                	addiw	a0,a0,1
 140:	00000097          	auipc	ra,0x0
 144:	7a2080e7          	jalr	1954(ra) # 8e2 <malloc>
 148:	8aaa                	mv	s5,a0
	char *new_argv[MAXARG];
	strcpy(command, argv[1]);
 14a:	008b3583          	ld	a1,8(s6)
 14e:	00000097          	auipc	ra,0x0
 152:	0cc080e7          	jalr	204(ra) # 21a <strcpy>
	for (int i = 1; i < argc; ++i)
 156:	008b0493          	addi	s1,s6,8
 15a:	ec040913          	addi	s2,s0,-320
 15e:	ffe98a1b          	addiw	s4,s3,-2
 162:	1a02                	slli	s4,s4,0x20
 164:	020a5a13          	srli	s4,s4,0x20
 168:	0a0e                	slli	s4,s4,0x3
 16a:	0b41                	addi	s6,s6,16
 16c:	9a5a                	add	s4,s4,s6
	{
		new_argv[i - 1] = malloc(strlen(argv[i]) + 1);
 16e:	6088                	ld	a0,0(s1)
 170:	00000097          	auipc	ra,0x0
 174:	0fa080e7          	jalr	250(ra) # 26a <strlen>
 178:	2505                	addiw	a0,a0,1
 17a:	00000097          	auipc	ra,0x0
 17e:	768080e7          	jalr	1896(ra) # 8e2 <malloc>
 182:	00a93023          	sd	a0,0(s2)
		strcpy(new_argv[i - 1], argv[i]);
 186:	608c                	ld	a1,0(s1)
 188:	00000097          	auipc	ra,0x0
 18c:	092080e7          	jalr	146(ra) # 21a <strcpy>
	for (int i = 1; i < argc; ++i)
 190:	04a1                	addi	s1,s1,8
 192:	0921                	addi	s2,s2,8
 194:	fd449de3          	bne	s1,s4,16e <main+0x58>
        /* printf("new_argv[%d] = %s", i - 1, argv[i]); */
	}

	int curr_argc;
	while((curr_argc = readline(new_argv, argc - 1)) != 0)
 198:	39fd                	addiw	s3,s3,-1
 19a:	85ce                	mv	a1,s3
 19c:	ec040513          	addi	a0,s0,-320
 1a0:	00000097          	auipc	ra,0x0
 1a4:	e60080e7          	jalr	-416(ra) # 0 <readline>
 1a8:	c52d                	beqz	a0,212 <main+0xfc>
	{
        /* printf("curr_argc = %d\n", curr_argc); */
		new_argv[curr_argc] = 0;
 1aa:	050e                	slli	a0,a0,0x3
 1ac:	fc040793          	addi	a5,s0,-64
 1b0:	953e                	add	a0,a0,a5
 1b2:	f0053023          	sd	zero,-256(a0)
		if(fork() == 0){
 1b6:	00000097          	auipc	ra,0x0
 1ba:	2ec080e7          	jalr	748(ra) # 4a2 <fork>
 1be:	c50d                	beqz	a0,1e8 <main+0xd2>
			exec(command, new_argv);
			fprintf(2, "exec failed\n");
			exit(1);
		}
		wait(0);
 1c0:	4501                	li	a0,0
 1c2:	00000097          	auipc	ra,0x0
 1c6:	2f0080e7          	jalr	752(ra) # 4b2 <wait>
 1ca:	bfc1                	j	19a <main+0x84>
		fprintf(2, "Usage: xargs command (arg ...)\n");
 1cc:	00001597          	auipc	a1,0x1
 1d0:	81458593          	addi	a1,a1,-2028 # 9e0 <malloc+0xfe>
 1d4:	4509                	li	a0,2
 1d6:	00000097          	auipc	ra,0x0
 1da:	61e080e7          	jalr	1566(ra) # 7f4 <fprintf>
		exit(1);
 1de:	4505                	li	a0,1
 1e0:	00000097          	auipc	ra,0x0
 1e4:	2ca080e7          	jalr	714(ra) # 4aa <exit>
			exec(command, new_argv);
 1e8:	ec040593          	addi	a1,s0,-320
 1ec:	8556                	mv	a0,s5
 1ee:	00000097          	auipc	ra,0x0
 1f2:	2f4080e7          	jalr	756(ra) # 4e2 <exec>
			fprintf(2, "exec failed\n");
 1f6:	00001597          	auipc	a1,0x1
 1fa:	80a58593          	addi	a1,a1,-2038 # a00 <malloc+0x11e>
 1fe:	4509                	li	a0,2
 200:	00000097          	auipc	ra,0x0
 204:	5f4080e7          	jalr	1524(ra) # 7f4 <fprintf>
			exit(1);
 208:	4505                	li	a0,1
 20a:	00000097          	auipc	ra,0x0
 20e:	2a0080e7          	jalr	672(ra) # 4aa <exit>
	}
	exit(0);
 212:	00000097          	auipc	ra,0x0
 216:	298080e7          	jalr	664(ra) # 4aa <exit>

000000000000021a <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 21a:	1141                	addi	sp,sp,-16
 21c:	e422                	sd	s0,8(sp)
 21e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 220:	87aa                	mv	a5,a0
 222:	0585                	addi	a1,a1,1
 224:	0785                	addi	a5,a5,1
 226:	fff5c703          	lbu	a4,-1(a1)
 22a:	fee78fa3          	sb	a4,-1(a5)
 22e:	fb75                	bnez	a4,222 <strcpy+0x8>
    ;
  return os;
}
 230:	6422                	ld	s0,8(sp)
 232:	0141                	addi	sp,sp,16
 234:	8082                	ret

0000000000000236 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 236:	1141                	addi	sp,sp,-16
 238:	e422                	sd	s0,8(sp)
 23a:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 23c:	00054783          	lbu	a5,0(a0)
 240:	cf91                	beqz	a5,25c <strcmp+0x26>
 242:	0005c703          	lbu	a4,0(a1)
 246:	00f71b63          	bne	a4,a5,25c <strcmp+0x26>
    p++, q++;
 24a:	0505                	addi	a0,a0,1
 24c:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 24e:	00054783          	lbu	a5,0(a0)
 252:	c789                	beqz	a5,25c <strcmp+0x26>
 254:	0005c703          	lbu	a4,0(a1)
 258:	fef709e3          	beq	a4,a5,24a <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
 25c:	0005c503          	lbu	a0,0(a1)
}
 260:	40a7853b          	subw	a0,a5,a0
 264:	6422                	ld	s0,8(sp)
 266:	0141                	addi	sp,sp,16
 268:	8082                	ret

000000000000026a <strlen>:

uint
strlen(const char *s)
{
 26a:	1141                	addi	sp,sp,-16
 26c:	e422                	sd	s0,8(sp)
 26e:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 270:	00054783          	lbu	a5,0(a0)
 274:	cf91                	beqz	a5,290 <strlen+0x26>
 276:	0505                	addi	a0,a0,1
 278:	87aa                	mv	a5,a0
 27a:	4685                	li	a3,1
 27c:	9e89                	subw	a3,a3,a0
 27e:	00f6853b          	addw	a0,a3,a5
 282:	0785                	addi	a5,a5,1
 284:	fff7c703          	lbu	a4,-1(a5)
 288:	fb7d                	bnez	a4,27e <strlen+0x14>
    ;
  return n;
}
 28a:	6422                	ld	s0,8(sp)
 28c:	0141                	addi	sp,sp,16
 28e:	8082                	ret
  for(n = 0; s[n]; n++)
 290:	4501                	li	a0,0
 292:	bfe5                	j	28a <strlen+0x20>

0000000000000294 <memset>:

void*
memset(void *dst, int c, uint n)
{
 294:	1141                	addi	sp,sp,-16
 296:	e422                	sd	s0,8(sp)
 298:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 29a:	ce09                	beqz	a2,2b4 <memset+0x20>
 29c:	87aa                	mv	a5,a0
 29e:	fff6071b          	addiw	a4,a2,-1
 2a2:	1702                	slli	a4,a4,0x20
 2a4:	9301                	srli	a4,a4,0x20
 2a6:	0705                	addi	a4,a4,1
 2a8:	972a                	add	a4,a4,a0
    cdst[i] = c;
 2aa:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 2ae:	0785                	addi	a5,a5,1
 2b0:	fee79de3          	bne	a5,a4,2aa <memset+0x16>
  }
  return dst;
}
 2b4:	6422                	ld	s0,8(sp)
 2b6:	0141                	addi	sp,sp,16
 2b8:	8082                	ret

00000000000002ba <strchr>:

char*
strchr(const char *s, char c)
{
 2ba:	1141                	addi	sp,sp,-16
 2bc:	e422                	sd	s0,8(sp)
 2be:	0800                	addi	s0,sp,16
  for(; *s; s++)
 2c0:	00054783          	lbu	a5,0(a0)
 2c4:	cf91                	beqz	a5,2e0 <strchr+0x26>
    if(*s == c)
 2c6:	00f58a63          	beq	a1,a5,2da <strchr+0x20>
  for(; *s; s++)
 2ca:	0505                	addi	a0,a0,1
 2cc:	00054783          	lbu	a5,0(a0)
 2d0:	c781                	beqz	a5,2d8 <strchr+0x1e>
    if(*s == c)
 2d2:	feb79ce3          	bne	a5,a1,2ca <strchr+0x10>
 2d6:	a011                	j	2da <strchr+0x20>
      return (char*)s;
  return 0;
 2d8:	4501                	li	a0,0
}
 2da:	6422                	ld	s0,8(sp)
 2dc:	0141                	addi	sp,sp,16
 2de:	8082                	ret
  return 0;
 2e0:	4501                	li	a0,0
 2e2:	bfe5                	j	2da <strchr+0x20>

00000000000002e4 <gets>:

char*
gets(char *buf, int max)
{
 2e4:	711d                	addi	sp,sp,-96
 2e6:	ec86                	sd	ra,88(sp)
 2e8:	e8a2                	sd	s0,80(sp)
 2ea:	e4a6                	sd	s1,72(sp)
 2ec:	e0ca                	sd	s2,64(sp)
 2ee:	fc4e                	sd	s3,56(sp)
 2f0:	f852                	sd	s4,48(sp)
 2f2:	f456                	sd	s5,40(sp)
 2f4:	f05a                	sd	s6,32(sp)
 2f6:	ec5e                	sd	s7,24(sp)
 2f8:	1080                	addi	s0,sp,96
 2fa:	8baa                	mv	s7,a0
 2fc:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2fe:	892a                	mv	s2,a0
 300:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 302:	4aa9                	li	s5,10
 304:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 306:	0019849b          	addiw	s1,s3,1
 30a:	0344d863          	ble	s4,s1,33a <gets+0x56>
    cc = read(0, &c, 1);
 30e:	4605                	li	a2,1
 310:	faf40593          	addi	a1,s0,-81
 314:	4501                	li	a0,0
 316:	00000097          	auipc	ra,0x0
 31a:	1ac080e7          	jalr	428(ra) # 4c2 <read>
    if(cc < 1)
 31e:	00a05e63          	blez	a0,33a <gets+0x56>
    buf[i++] = c;
 322:	faf44783          	lbu	a5,-81(s0)
 326:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 32a:	01578763          	beq	a5,s5,338 <gets+0x54>
 32e:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 330:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 332:	fd679ae3          	bne	a5,s6,306 <gets+0x22>
 336:	a011                	j	33a <gets+0x56>
  for(i=0; i+1 < max; ){
 338:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 33a:	99de                	add	s3,s3,s7
 33c:	00098023          	sb	zero,0(s3)
  return buf;
}
 340:	855e                	mv	a0,s7
 342:	60e6                	ld	ra,88(sp)
 344:	6446                	ld	s0,80(sp)
 346:	64a6                	ld	s1,72(sp)
 348:	6906                	ld	s2,64(sp)
 34a:	79e2                	ld	s3,56(sp)
 34c:	7a42                	ld	s4,48(sp)
 34e:	7aa2                	ld	s5,40(sp)
 350:	7b02                	ld	s6,32(sp)
 352:	6be2                	ld	s7,24(sp)
 354:	6125                	addi	sp,sp,96
 356:	8082                	ret

0000000000000358 <stat>:

int
stat(const char *n, struct stat *st)
{
 358:	1101                	addi	sp,sp,-32
 35a:	ec06                	sd	ra,24(sp)
 35c:	e822                	sd	s0,16(sp)
 35e:	e426                	sd	s1,8(sp)
 360:	e04a                	sd	s2,0(sp)
 362:	1000                	addi	s0,sp,32
 364:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 366:	4581                	li	a1,0
 368:	00000097          	auipc	ra,0x0
 36c:	182080e7          	jalr	386(ra) # 4ea <open>
  if(fd < 0)
 370:	02054563          	bltz	a0,39a <stat+0x42>
 374:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 376:	85ca                	mv	a1,s2
 378:	00000097          	auipc	ra,0x0
 37c:	18a080e7          	jalr	394(ra) # 502 <fstat>
 380:	892a                	mv	s2,a0
  close(fd);
 382:	8526                	mv	a0,s1
 384:	00000097          	auipc	ra,0x0
 388:	14e080e7          	jalr	334(ra) # 4d2 <close>
  return r;
}
 38c:	854a                	mv	a0,s2
 38e:	60e2                	ld	ra,24(sp)
 390:	6442                	ld	s0,16(sp)
 392:	64a2                	ld	s1,8(sp)
 394:	6902                	ld	s2,0(sp)
 396:	6105                	addi	sp,sp,32
 398:	8082                	ret
    return -1;
 39a:	597d                	li	s2,-1
 39c:	bfc5                	j	38c <stat+0x34>

000000000000039e <atoi>:

int
atoi(const char *s)
{
 39e:	1141                	addi	sp,sp,-16
 3a0:	e422                	sd	s0,8(sp)
 3a2:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3a4:	00054683          	lbu	a3,0(a0)
 3a8:	fd06879b          	addiw	a5,a3,-48
 3ac:	0ff7f793          	andi	a5,a5,255
 3b0:	4725                	li	a4,9
 3b2:	02f76963          	bltu	a4,a5,3e4 <atoi+0x46>
 3b6:	862a                	mv	a2,a0
  n = 0;
 3b8:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 3ba:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 3bc:	0605                	addi	a2,a2,1
 3be:	0025179b          	slliw	a5,a0,0x2
 3c2:	9fa9                	addw	a5,a5,a0
 3c4:	0017979b          	slliw	a5,a5,0x1
 3c8:	9fb5                	addw	a5,a5,a3
 3ca:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 3ce:	00064683          	lbu	a3,0(a2)
 3d2:	fd06871b          	addiw	a4,a3,-48
 3d6:	0ff77713          	andi	a4,a4,255
 3da:	fee5f1e3          	bleu	a4,a1,3bc <atoi+0x1e>
  return n;
}
 3de:	6422                	ld	s0,8(sp)
 3e0:	0141                	addi	sp,sp,16
 3e2:	8082                	ret
  n = 0;
 3e4:	4501                	li	a0,0
 3e6:	bfe5                	j	3de <atoi+0x40>

00000000000003e8 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3e8:	1141                	addi	sp,sp,-16
 3ea:	e422                	sd	s0,8(sp)
 3ec:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 3ee:	02b57663          	bleu	a1,a0,41a <memmove+0x32>
    while(n-- > 0)
 3f2:	02c05163          	blez	a2,414 <memmove+0x2c>
 3f6:	fff6079b          	addiw	a5,a2,-1
 3fa:	1782                	slli	a5,a5,0x20
 3fc:	9381                	srli	a5,a5,0x20
 3fe:	0785                	addi	a5,a5,1
 400:	97aa                	add	a5,a5,a0
  dst = vdst;
 402:	872a                	mv	a4,a0
      *dst++ = *src++;
 404:	0585                	addi	a1,a1,1
 406:	0705                	addi	a4,a4,1
 408:	fff5c683          	lbu	a3,-1(a1)
 40c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 410:	fee79ae3          	bne	a5,a4,404 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 414:	6422                	ld	s0,8(sp)
 416:	0141                	addi	sp,sp,16
 418:	8082                	ret
    dst += n;
 41a:	00c50733          	add	a4,a0,a2
    src += n;
 41e:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 420:	fec05ae3          	blez	a2,414 <memmove+0x2c>
 424:	fff6079b          	addiw	a5,a2,-1
 428:	1782                	slli	a5,a5,0x20
 42a:	9381                	srli	a5,a5,0x20
 42c:	fff7c793          	not	a5,a5
 430:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 432:	15fd                	addi	a1,a1,-1
 434:	177d                	addi	a4,a4,-1
 436:	0005c683          	lbu	a3,0(a1)
 43a:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 43e:	fef71ae3          	bne	a4,a5,432 <memmove+0x4a>
 442:	bfc9                	j	414 <memmove+0x2c>

0000000000000444 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 444:	1141                	addi	sp,sp,-16
 446:	e422                	sd	s0,8(sp)
 448:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 44a:	ce15                	beqz	a2,486 <memcmp+0x42>
 44c:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
 450:	00054783          	lbu	a5,0(a0)
 454:	0005c703          	lbu	a4,0(a1)
 458:	02e79063          	bne	a5,a4,478 <memcmp+0x34>
 45c:	1682                	slli	a3,a3,0x20
 45e:	9281                	srli	a3,a3,0x20
 460:	0685                	addi	a3,a3,1
 462:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
 464:	0505                	addi	a0,a0,1
    p2++;
 466:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 468:	00d50d63          	beq	a0,a3,482 <memcmp+0x3e>
    if (*p1 != *p2) {
 46c:	00054783          	lbu	a5,0(a0)
 470:	0005c703          	lbu	a4,0(a1)
 474:	fee788e3          	beq	a5,a4,464 <memcmp+0x20>
      return *p1 - *p2;
 478:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
 47c:	6422                	ld	s0,8(sp)
 47e:	0141                	addi	sp,sp,16
 480:	8082                	ret
  return 0;
 482:	4501                	li	a0,0
 484:	bfe5                	j	47c <memcmp+0x38>
 486:	4501                	li	a0,0
 488:	bfd5                	j	47c <memcmp+0x38>

000000000000048a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 48a:	1141                	addi	sp,sp,-16
 48c:	e406                	sd	ra,8(sp)
 48e:	e022                	sd	s0,0(sp)
 490:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 492:	00000097          	auipc	ra,0x0
 496:	f56080e7          	jalr	-170(ra) # 3e8 <memmove>
}
 49a:	60a2                	ld	ra,8(sp)
 49c:	6402                	ld	s0,0(sp)
 49e:	0141                	addi	sp,sp,16
 4a0:	8082                	ret

00000000000004a2 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 4a2:	4885                	li	a7,1
 ecall
 4a4:	00000073          	ecall
 ret
 4a8:	8082                	ret

00000000000004aa <exit>:
.global exit
exit:
 li a7, SYS_exit
 4aa:	4889                	li	a7,2
 ecall
 4ac:	00000073          	ecall
 ret
 4b0:	8082                	ret

00000000000004b2 <wait>:
.global wait
wait:
 li a7, SYS_wait
 4b2:	488d                	li	a7,3
 ecall
 4b4:	00000073          	ecall
 ret
 4b8:	8082                	ret

00000000000004ba <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 4ba:	4891                	li	a7,4
 ecall
 4bc:	00000073          	ecall
 ret
 4c0:	8082                	ret

00000000000004c2 <read>:
.global read
read:
 li a7, SYS_read
 4c2:	4895                	li	a7,5
 ecall
 4c4:	00000073          	ecall
 ret
 4c8:	8082                	ret

00000000000004ca <write>:
.global write
write:
 li a7, SYS_write
 4ca:	48c1                	li	a7,16
 ecall
 4cc:	00000073          	ecall
 ret
 4d0:	8082                	ret

00000000000004d2 <close>:
.global close
close:
 li a7, SYS_close
 4d2:	48d5                	li	a7,21
 ecall
 4d4:	00000073          	ecall
 ret
 4d8:	8082                	ret

00000000000004da <kill>:
.global kill
kill:
 li a7, SYS_kill
 4da:	4899                	li	a7,6
 ecall
 4dc:	00000073          	ecall
 ret
 4e0:	8082                	ret

00000000000004e2 <exec>:
.global exec
exec:
 li a7, SYS_exec
 4e2:	489d                	li	a7,7
 ecall
 4e4:	00000073          	ecall
 ret
 4e8:	8082                	ret

00000000000004ea <open>:
.global open
open:
 li a7, SYS_open
 4ea:	48bd                	li	a7,15
 ecall
 4ec:	00000073          	ecall
 ret
 4f0:	8082                	ret

00000000000004f2 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 4f2:	48c5                	li	a7,17
 ecall
 4f4:	00000073          	ecall
 ret
 4f8:	8082                	ret

00000000000004fa <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 4fa:	48c9                	li	a7,18
 ecall
 4fc:	00000073          	ecall
 ret
 500:	8082                	ret

0000000000000502 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 502:	48a1                	li	a7,8
 ecall
 504:	00000073          	ecall
 ret
 508:	8082                	ret

000000000000050a <link>:
.global link
link:
 li a7, SYS_link
 50a:	48cd                	li	a7,19
 ecall
 50c:	00000073          	ecall
 ret
 510:	8082                	ret

0000000000000512 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 512:	48d1                	li	a7,20
 ecall
 514:	00000073          	ecall
 ret
 518:	8082                	ret

000000000000051a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 51a:	48a5                	li	a7,9
 ecall
 51c:	00000073          	ecall
 ret
 520:	8082                	ret

0000000000000522 <dup>:
.global dup
dup:
 li a7, SYS_dup
 522:	48a9                	li	a7,10
 ecall
 524:	00000073          	ecall
 ret
 528:	8082                	ret

000000000000052a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 52a:	48ad                	li	a7,11
 ecall
 52c:	00000073          	ecall
 ret
 530:	8082                	ret

0000000000000532 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 532:	48b1                	li	a7,12
 ecall
 534:	00000073          	ecall
 ret
 538:	8082                	ret

000000000000053a <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 53a:	48b5                	li	a7,13
 ecall
 53c:	00000073          	ecall
 ret
 540:	8082                	ret

0000000000000542 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 542:	48b9                	li	a7,14
 ecall
 544:	00000073          	ecall
 ret
 548:	8082                	ret

000000000000054a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 54a:	1101                	addi	sp,sp,-32
 54c:	ec06                	sd	ra,24(sp)
 54e:	e822                	sd	s0,16(sp)
 550:	1000                	addi	s0,sp,32
 552:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 556:	4605                	li	a2,1
 558:	fef40593          	addi	a1,s0,-17
 55c:	00000097          	auipc	ra,0x0
 560:	f6e080e7          	jalr	-146(ra) # 4ca <write>
}
 564:	60e2                	ld	ra,24(sp)
 566:	6442                	ld	s0,16(sp)
 568:	6105                	addi	sp,sp,32
 56a:	8082                	ret

000000000000056c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 56c:	7139                	addi	sp,sp,-64
 56e:	fc06                	sd	ra,56(sp)
 570:	f822                	sd	s0,48(sp)
 572:	f426                	sd	s1,40(sp)
 574:	f04a                	sd	s2,32(sp)
 576:	ec4e                	sd	s3,24(sp)
 578:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 57a:	c299                	beqz	a3,580 <printint+0x14>
 57c:	0005cd63          	bltz	a1,596 <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 580:	2581                	sext.w	a1,a1
  neg = 0;
 582:	4301                	li	t1,0
 584:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 588:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 58a:	2601                	sext.w	a2,a2
 58c:	00000897          	auipc	a7,0x0
 590:	48488893          	addi	a7,a7,1156 # a10 <digits>
 594:	a801                	j	5a4 <printint+0x38>
    x = -xx;
 596:	40b005bb          	negw	a1,a1
 59a:	2581                	sext.w	a1,a1
    neg = 1;
 59c:	4305                	li	t1,1
    x = -xx;
 59e:	b7dd                	j	584 <printint+0x18>
  }while((x /= base) != 0);
 5a0:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 5a2:	8836                	mv	a6,a3
 5a4:	0018069b          	addiw	a3,a6,1
 5a8:	02c5f7bb          	remuw	a5,a1,a2
 5ac:	1782                	slli	a5,a5,0x20
 5ae:	9381                	srli	a5,a5,0x20
 5b0:	97c6                	add	a5,a5,a7
 5b2:	0007c783          	lbu	a5,0(a5)
 5b6:	00f70023          	sb	a5,0(a4)
  }while((x /= base) != 0);
 5ba:	0705                	addi	a4,a4,1
 5bc:	02c5d7bb          	divuw	a5,a1,a2
 5c0:	fec5f0e3          	bleu	a2,a1,5a0 <printint+0x34>
  if(neg)
 5c4:	00030b63          	beqz	t1,5da <printint+0x6e>
    buf[i++] = '-';
 5c8:	fd040793          	addi	a5,s0,-48
 5cc:	96be                	add	a3,a3,a5
 5ce:	02d00793          	li	a5,45
 5d2:	fef68823          	sb	a5,-16(a3)
 5d6:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 5da:	02d05963          	blez	a3,60c <printint+0xa0>
 5de:	89aa                	mv	s3,a0
 5e0:	fc040793          	addi	a5,s0,-64
 5e4:	00d784b3          	add	s1,a5,a3
 5e8:	fff78913          	addi	s2,a5,-1
 5ec:	9936                	add	s2,s2,a3
 5ee:	36fd                	addiw	a3,a3,-1
 5f0:	1682                	slli	a3,a3,0x20
 5f2:	9281                	srli	a3,a3,0x20
 5f4:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 5f8:	fff4c583          	lbu	a1,-1(s1)
 5fc:	854e                	mv	a0,s3
 5fe:	00000097          	auipc	ra,0x0
 602:	f4c080e7          	jalr	-180(ra) # 54a <putc>
  while(--i >= 0)
 606:	14fd                	addi	s1,s1,-1
 608:	ff2498e3          	bne	s1,s2,5f8 <printint+0x8c>
}
 60c:	70e2                	ld	ra,56(sp)
 60e:	7442                	ld	s0,48(sp)
 610:	74a2                	ld	s1,40(sp)
 612:	7902                	ld	s2,32(sp)
 614:	69e2                	ld	s3,24(sp)
 616:	6121                	addi	sp,sp,64
 618:	8082                	ret

000000000000061a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 61a:	7119                	addi	sp,sp,-128
 61c:	fc86                	sd	ra,120(sp)
 61e:	f8a2                	sd	s0,112(sp)
 620:	f4a6                	sd	s1,104(sp)
 622:	f0ca                	sd	s2,96(sp)
 624:	ecce                	sd	s3,88(sp)
 626:	e8d2                	sd	s4,80(sp)
 628:	e4d6                	sd	s5,72(sp)
 62a:	e0da                	sd	s6,64(sp)
 62c:	fc5e                	sd	s7,56(sp)
 62e:	f862                	sd	s8,48(sp)
 630:	f466                	sd	s9,40(sp)
 632:	f06a                	sd	s10,32(sp)
 634:	ec6e                	sd	s11,24(sp)
 636:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 638:	0005c483          	lbu	s1,0(a1)
 63c:	18048d63          	beqz	s1,7d6 <vprintf+0x1bc>
 640:	8aaa                	mv	s5,a0
 642:	8b32                	mv	s6,a2
 644:	00158913          	addi	s2,a1,1
  state = 0;
 648:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 64a:	02500a13          	li	s4,37
      if(c == 'd'){
 64e:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 652:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 656:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 65a:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 65e:	00000b97          	auipc	s7,0x0
 662:	3b2b8b93          	addi	s7,s7,946 # a10 <digits>
 666:	a839                	j	684 <vprintf+0x6a>
        putc(fd, c);
 668:	85a6                	mv	a1,s1
 66a:	8556                	mv	a0,s5
 66c:	00000097          	auipc	ra,0x0
 670:	ede080e7          	jalr	-290(ra) # 54a <putc>
 674:	a019                	j	67a <vprintf+0x60>
    } else if(state == '%'){
 676:	01498f63          	beq	s3,s4,694 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 67a:	0905                	addi	s2,s2,1
 67c:	fff94483          	lbu	s1,-1(s2)
 680:	14048b63          	beqz	s1,7d6 <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 684:	0004879b          	sext.w	a5,s1
    if(state == 0){
 688:	fe0997e3          	bnez	s3,676 <vprintf+0x5c>
      if(c == '%'){
 68c:	fd479ee3          	bne	a5,s4,668 <vprintf+0x4e>
        state = '%';
 690:	89be                	mv	s3,a5
 692:	b7e5                	j	67a <vprintf+0x60>
      if(c == 'd'){
 694:	05878063          	beq	a5,s8,6d4 <vprintf+0xba>
      } else if(c == 'l') {
 698:	05978c63          	beq	a5,s9,6f0 <vprintf+0xd6>
      } else if(c == 'x') {
 69c:	07a78863          	beq	a5,s10,70c <vprintf+0xf2>
      } else if(c == 'p') {
 6a0:	09b78463          	beq	a5,s11,728 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 6a4:	07300713          	li	a4,115
 6a8:	0ce78563          	beq	a5,a4,772 <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6ac:	06300713          	li	a4,99
 6b0:	0ee78c63          	beq	a5,a4,7a8 <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 6b4:	11478663          	beq	a5,s4,7c0 <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6b8:	85d2                	mv	a1,s4
 6ba:	8556                	mv	a0,s5
 6bc:	00000097          	auipc	ra,0x0
 6c0:	e8e080e7          	jalr	-370(ra) # 54a <putc>
        putc(fd, c);
 6c4:	85a6                	mv	a1,s1
 6c6:	8556                	mv	a0,s5
 6c8:	00000097          	auipc	ra,0x0
 6cc:	e82080e7          	jalr	-382(ra) # 54a <putc>
      }
      state = 0;
 6d0:	4981                	li	s3,0
 6d2:	b765                	j	67a <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 6d4:	008b0493          	addi	s1,s6,8
 6d8:	4685                	li	a3,1
 6da:	4629                	li	a2,10
 6dc:	000b2583          	lw	a1,0(s6)
 6e0:	8556                	mv	a0,s5
 6e2:	00000097          	auipc	ra,0x0
 6e6:	e8a080e7          	jalr	-374(ra) # 56c <printint>
 6ea:	8b26                	mv	s6,s1
      state = 0;
 6ec:	4981                	li	s3,0
 6ee:	b771                	j	67a <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6f0:	008b0493          	addi	s1,s6,8
 6f4:	4681                	li	a3,0
 6f6:	4629                	li	a2,10
 6f8:	000b2583          	lw	a1,0(s6)
 6fc:	8556                	mv	a0,s5
 6fe:	00000097          	auipc	ra,0x0
 702:	e6e080e7          	jalr	-402(ra) # 56c <printint>
 706:	8b26                	mv	s6,s1
      state = 0;
 708:	4981                	li	s3,0
 70a:	bf85                	j	67a <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 70c:	008b0493          	addi	s1,s6,8
 710:	4681                	li	a3,0
 712:	4641                	li	a2,16
 714:	000b2583          	lw	a1,0(s6)
 718:	8556                	mv	a0,s5
 71a:	00000097          	auipc	ra,0x0
 71e:	e52080e7          	jalr	-430(ra) # 56c <printint>
 722:	8b26                	mv	s6,s1
      state = 0;
 724:	4981                	li	s3,0
 726:	bf91                	j	67a <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 728:	008b0793          	addi	a5,s6,8
 72c:	f8f43423          	sd	a5,-120(s0)
 730:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 734:	03000593          	li	a1,48
 738:	8556                	mv	a0,s5
 73a:	00000097          	auipc	ra,0x0
 73e:	e10080e7          	jalr	-496(ra) # 54a <putc>
  putc(fd, 'x');
 742:	85ea                	mv	a1,s10
 744:	8556                	mv	a0,s5
 746:	00000097          	auipc	ra,0x0
 74a:	e04080e7          	jalr	-508(ra) # 54a <putc>
 74e:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 750:	03c9d793          	srli	a5,s3,0x3c
 754:	97de                	add	a5,a5,s7
 756:	0007c583          	lbu	a1,0(a5)
 75a:	8556                	mv	a0,s5
 75c:	00000097          	auipc	ra,0x0
 760:	dee080e7          	jalr	-530(ra) # 54a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 764:	0992                	slli	s3,s3,0x4
 766:	34fd                	addiw	s1,s1,-1
 768:	f4e5                	bnez	s1,750 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 76a:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 76e:	4981                	li	s3,0
 770:	b729                	j	67a <vprintf+0x60>
        s = va_arg(ap, char*);
 772:	008b0993          	addi	s3,s6,8
 776:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 77a:	c085                	beqz	s1,79a <vprintf+0x180>
        while(*s != 0){
 77c:	0004c583          	lbu	a1,0(s1)
 780:	c9a1                	beqz	a1,7d0 <vprintf+0x1b6>
          putc(fd, *s);
 782:	8556                	mv	a0,s5
 784:	00000097          	auipc	ra,0x0
 788:	dc6080e7          	jalr	-570(ra) # 54a <putc>
          s++;
 78c:	0485                	addi	s1,s1,1
        while(*s != 0){
 78e:	0004c583          	lbu	a1,0(s1)
 792:	f9e5                	bnez	a1,782 <vprintf+0x168>
        s = va_arg(ap, char*);
 794:	8b4e                	mv	s6,s3
      state = 0;
 796:	4981                	li	s3,0
 798:	b5cd                	j	67a <vprintf+0x60>
          s = "(null)";
 79a:	00000497          	auipc	s1,0x0
 79e:	28e48493          	addi	s1,s1,654 # a28 <digits+0x18>
        while(*s != 0){
 7a2:	02800593          	li	a1,40
 7a6:	bff1                	j	782 <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 7a8:	008b0493          	addi	s1,s6,8
 7ac:	000b4583          	lbu	a1,0(s6)
 7b0:	8556                	mv	a0,s5
 7b2:	00000097          	auipc	ra,0x0
 7b6:	d98080e7          	jalr	-616(ra) # 54a <putc>
 7ba:	8b26                	mv	s6,s1
      state = 0;
 7bc:	4981                	li	s3,0
 7be:	bd75                	j	67a <vprintf+0x60>
        putc(fd, c);
 7c0:	85d2                	mv	a1,s4
 7c2:	8556                	mv	a0,s5
 7c4:	00000097          	auipc	ra,0x0
 7c8:	d86080e7          	jalr	-634(ra) # 54a <putc>
      state = 0;
 7cc:	4981                	li	s3,0
 7ce:	b575                	j	67a <vprintf+0x60>
        s = va_arg(ap, char*);
 7d0:	8b4e                	mv	s6,s3
      state = 0;
 7d2:	4981                	li	s3,0
 7d4:	b55d                	j	67a <vprintf+0x60>
    }
  }
}
 7d6:	70e6                	ld	ra,120(sp)
 7d8:	7446                	ld	s0,112(sp)
 7da:	74a6                	ld	s1,104(sp)
 7dc:	7906                	ld	s2,96(sp)
 7de:	69e6                	ld	s3,88(sp)
 7e0:	6a46                	ld	s4,80(sp)
 7e2:	6aa6                	ld	s5,72(sp)
 7e4:	6b06                	ld	s6,64(sp)
 7e6:	7be2                	ld	s7,56(sp)
 7e8:	7c42                	ld	s8,48(sp)
 7ea:	7ca2                	ld	s9,40(sp)
 7ec:	7d02                	ld	s10,32(sp)
 7ee:	6de2                	ld	s11,24(sp)
 7f0:	6109                	addi	sp,sp,128
 7f2:	8082                	ret

00000000000007f4 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7f4:	715d                	addi	sp,sp,-80
 7f6:	ec06                	sd	ra,24(sp)
 7f8:	e822                	sd	s0,16(sp)
 7fa:	1000                	addi	s0,sp,32
 7fc:	e010                	sd	a2,0(s0)
 7fe:	e414                	sd	a3,8(s0)
 800:	e818                	sd	a4,16(s0)
 802:	ec1c                	sd	a5,24(s0)
 804:	03043023          	sd	a6,32(s0)
 808:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 80c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 810:	8622                	mv	a2,s0
 812:	00000097          	auipc	ra,0x0
 816:	e08080e7          	jalr	-504(ra) # 61a <vprintf>
}
 81a:	60e2                	ld	ra,24(sp)
 81c:	6442                	ld	s0,16(sp)
 81e:	6161                	addi	sp,sp,80
 820:	8082                	ret

0000000000000822 <printf>:

void
printf(const char *fmt, ...)
{
 822:	711d                	addi	sp,sp,-96
 824:	ec06                	sd	ra,24(sp)
 826:	e822                	sd	s0,16(sp)
 828:	1000                	addi	s0,sp,32
 82a:	e40c                	sd	a1,8(s0)
 82c:	e810                	sd	a2,16(s0)
 82e:	ec14                	sd	a3,24(s0)
 830:	f018                	sd	a4,32(s0)
 832:	f41c                	sd	a5,40(s0)
 834:	03043823          	sd	a6,48(s0)
 838:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 83c:	00840613          	addi	a2,s0,8
 840:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 844:	85aa                	mv	a1,a0
 846:	4505                	li	a0,1
 848:	00000097          	auipc	ra,0x0
 84c:	dd2080e7          	jalr	-558(ra) # 61a <vprintf>
}
 850:	60e2                	ld	ra,24(sp)
 852:	6442                	ld	s0,16(sp)
 854:	6125                	addi	sp,sp,96
 856:	8082                	ret

0000000000000858 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 858:	1141                	addi	sp,sp,-16
 85a:	e422                	sd	s0,8(sp)
 85c:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 85e:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 862:	00000797          	auipc	a5,0x0
 866:	1ce78793          	addi	a5,a5,462 # a30 <__bss_start>
 86a:	639c                	ld	a5,0(a5)
 86c:	a805                	j	89c <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 86e:	4618                	lw	a4,8(a2)
 870:	9db9                	addw	a1,a1,a4
 872:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 876:	6398                	ld	a4,0(a5)
 878:	6318                	ld	a4,0(a4)
 87a:	fee53823          	sd	a4,-16(a0)
 87e:	a091                	j	8c2 <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 880:	ff852703          	lw	a4,-8(a0)
 884:	9e39                	addw	a2,a2,a4
 886:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 888:	ff053703          	ld	a4,-16(a0)
 88c:	e398                	sd	a4,0(a5)
 88e:	a099                	j	8d4 <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 890:	6398                	ld	a4,0(a5)
 892:	00e7e463          	bltu	a5,a4,89a <free+0x42>
 896:	00e6ea63          	bltu	a3,a4,8aa <free+0x52>
{
 89a:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 89c:	fed7fae3          	bleu	a3,a5,890 <free+0x38>
 8a0:	6398                	ld	a4,0(a5)
 8a2:	00e6e463          	bltu	a3,a4,8aa <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8a6:	fee7eae3          	bltu	a5,a4,89a <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 8aa:	ff852583          	lw	a1,-8(a0)
 8ae:	6390                	ld	a2,0(a5)
 8b0:	02059713          	slli	a4,a1,0x20
 8b4:	9301                	srli	a4,a4,0x20
 8b6:	0712                	slli	a4,a4,0x4
 8b8:	9736                	add	a4,a4,a3
 8ba:	fae60ae3          	beq	a2,a4,86e <free+0x16>
    bp->s.ptr = p->s.ptr;
 8be:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8c2:	4790                	lw	a2,8(a5)
 8c4:	02061713          	slli	a4,a2,0x20
 8c8:	9301                	srli	a4,a4,0x20
 8ca:	0712                	slli	a4,a4,0x4
 8cc:	973e                	add	a4,a4,a5
 8ce:	fae689e3          	beq	a3,a4,880 <free+0x28>
  } else
    p->s.ptr = bp;
 8d2:	e394                	sd	a3,0(a5)
  freep = p;
 8d4:	00000717          	auipc	a4,0x0
 8d8:	14f73e23          	sd	a5,348(a4) # a30 <__bss_start>
}
 8dc:	6422                	ld	s0,8(sp)
 8de:	0141                	addi	sp,sp,16
 8e0:	8082                	ret

00000000000008e2 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8e2:	7139                	addi	sp,sp,-64
 8e4:	fc06                	sd	ra,56(sp)
 8e6:	f822                	sd	s0,48(sp)
 8e8:	f426                	sd	s1,40(sp)
 8ea:	f04a                	sd	s2,32(sp)
 8ec:	ec4e                	sd	s3,24(sp)
 8ee:	e852                	sd	s4,16(sp)
 8f0:	e456                	sd	s5,8(sp)
 8f2:	e05a                	sd	s6,0(sp)
 8f4:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8f6:	02051993          	slli	s3,a0,0x20
 8fa:	0209d993          	srli	s3,s3,0x20
 8fe:	09bd                	addi	s3,s3,15
 900:	0049d993          	srli	s3,s3,0x4
 904:	2985                	addiw	s3,s3,1
 906:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 90a:	00000797          	auipc	a5,0x0
 90e:	12678793          	addi	a5,a5,294 # a30 <__bss_start>
 912:	6388                	ld	a0,0(a5)
 914:	c515                	beqz	a0,940 <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 916:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 918:	4798                	lw	a4,8(a5)
 91a:	03277f63          	bleu	s2,a4,958 <malloc+0x76>
 91e:	8a4e                	mv	s4,s3
 920:	0009871b          	sext.w	a4,s3
 924:	6685                	lui	a3,0x1
 926:	00d77363          	bleu	a3,a4,92c <malloc+0x4a>
 92a:	6a05                	lui	s4,0x1
 92c:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 930:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 934:	00000497          	auipc	s1,0x0
 938:	0fc48493          	addi	s1,s1,252 # a30 <__bss_start>
  if(p == (char*)-1)
 93c:	5b7d                	li	s6,-1
 93e:	a885                	j	9ae <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 940:	00000797          	auipc	a5,0x0
 944:	0f878793          	addi	a5,a5,248 # a38 <base>
 948:	00000717          	auipc	a4,0x0
 94c:	0ef73423          	sd	a5,232(a4) # a30 <__bss_start>
 950:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 952:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 956:	b7e1                	j	91e <malloc+0x3c>
      if(p->s.size == nunits)
 958:	02e90b63          	beq	s2,a4,98e <malloc+0xac>
        p->s.size -= nunits;
 95c:	4137073b          	subw	a4,a4,s3
 960:	c798                	sw	a4,8(a5)
        p += p->s.size;
 962:	1702                	slli	a4,a4,0x20
 964:	9301                	srli	a4,a4,0x20
 966:	0712                	slli	a4,a4,0x4
 968:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 96a:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 96e:	00000717          	auipc	a4,0x0
 972:	0ca73123          	sd	a0,194(a4) # a30 <__bss_start>
      return (void*)(p + 1);
 976:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 97a:	70e2                	ld	ra,56(sp)
 97c:	7442                	ld	s0,48(sp)
 97e:	74a2                	ld	s1,40(sp)
 980:	7902                	ld	s2,32(sp)
 982:	69e2                	ld	s3,24(sp)
 984:	6a42                	ld	s4,16(sp)
 986:	6aa2                	ld	s5,8(sp)
 988:	6b02                	ld	s6,0(sp)
 98a:	6121                	addi	sp,sp,64
 98c:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 98e:	6398                	ld	a4,0(a5)
 990:	e118                	sd	a4,0(a0)
 992:	bff1                	j	96e <malloc+0x8c>
  hp->s.size = nu;
 994:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 998:	0541                	addi	a0,a0,16
 99a:	00000097          	auipc	ra,0x0
 99e:	ebe080e7          	jalr	-322(ra) # 858 <free>
  return freep;
 9a2:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 9a4:	d979                	beqz	a0,97a <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9a6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9a8:	4798                	lw	a4,8(a5)
 9aa:	fb2777e3          	bleu	s2,a4,958 <malloc+0x76>
    if(p == freep)
 9ae:	6098                	ld	a4,0(s1)
 9b0:	853e                	mv	a0,a5
 9b2:	fef71ae3          	bne	a4,a5,9a6 <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 9b6:	8552                	mv	a0,s4
 9b8:	00000097          	auipc	ra,0x0
 9bc:	b7a080e7          	jalr	-1158(ra) # 532 <sbrk>
  if(p == (char*)-1)
 9c0:	fd651ae3          	bne	a0,s6,994 <malloc+0xb2>
        return 0;
 9c4:	4501                	li	a0,0
 9c6:	bf55                	j	97a <malloc+0x98>
