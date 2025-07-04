
user/_ls：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <fmtname>:
#include "user/user.h"
#include "kernel/fs.h"

char*
fmtname(char *path)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	addi	s0,sp,48
   e:	84aa                	mv	s1,a0
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
  10:	00000097          	auipc	ra,0x0
  14:	332080e7          	jalr	818(ra) # 342 <strlen>
  18:	1502                	slli	a0,a0,0x20
  1a:	9101                	srli	a0,a0,0x20
  1c:	9526                	add	a0,a0,s1
  1e:	02956163          	bltu	a0,s1,40 <fmtname+0x40>
  22:	00054703          	lbu	a4,0(a0)
  26:	02f00793          	li	a5,47
  2a:	00f70b63          	beq	a4,a5,40 <fmtname+0x40>
  2e:	02f00713          	li	a4,47
  32:	157d                	addi	a0,a0,-1
  34:	00956663          	bltu	a0,s1,40 <fmtname+0x40>
  38:	00054783          	lbu	a5,0(a0)
  3c:	fee79be3          	bne	a5,a4,32 <fmtname+0x32>
    ;
  p++;
  40:	00150493          	addi	s1,a0,1

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  44:	8526                	mv	a0,s1
  46:	00000097          	auipc	ra,0x0
  4a:	2fc080e7          	jalr	764(ra) # 342 <strlen>
  4e:	2501                	sext.w	a0,a0
  50:	47b5                	li	a5,13
  52:	00a7fa63          	bleu	a0,a5,66 <fmtname+0x66>
    return p;
  memmove(buf, p, strlen(p));
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  return buf;
}
  56:	8526                	mv	a0,s1
  58:	70a2                	ld	ra,40(sp)
  5a:	7402                	ld	s0,32(sp)
  5c:	64e2                	ld	s1,24(sp)
  5e:	6942                	ld	s2,16(sp)
  60:	69a2                	ld	s3,8(sp)
  62:	6145                	addi	sp,sp,48
  64:	8082                	ret
  memmove(buf, p, strlen(p));
  66:	8526                	mv	a0,s1
  68:	00000097          	auipc	ra,0x0
  6c:	2da080e7          	jalr	730(ra) # 342 <strlen>
  70:	00001917          	auipc	s2,0x1
  74:	ae890913          	addi	s2,s2,-1304 # b58 <buf.1127>
  78:	0005061b          	sext.w	a2,a0
  7c:	85a6                	mv	a1,s1
  7e:	854a                	mv	a0,s2
  80:	00000097          	auipc	ra,0x0
  84:	440080e7          	jalr	1088(ra) # 4c0 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  88:	8526                	mv	a0,s1
  8a:	00000097          	auipc	ra,0x0
  8e:	2b8080e7          	jalr	696(ra) # 342 <strlen>
  92:	0005099b          	sext.w	s3,a0
  96:	8526                	mv	a0,s1
  98:	00000097          	auipc	ra,0x0
  9c:	2aa080e7          	jalr	682(ra) # 342 <strlen>
  a0:	1982                	slli	s3,s3,0x20
  a2:	0209d993          	srli	s3,s3,0x20
  a6:	4639                	li	a2,14
  a8:	9e09                	subw	a2,a2,a0
  aa:	02000593          	li	a1,32
  ae:	01390533          	add	a0,s2,s3
  b2:	00000097          	auipc	ra,0x0
  b6:	2ba080e7          	jalr	698(ra) # 36c <memset>
  return buf;
  ba:	84ca                	mv	s1,s2
  bc:	bf69                	j	56 <fmtname+0x56>

00000000000000be <ls>:

void
ls(char *path)
{
  be:	d9010113          	addi	sp,sp,-624
  c2:	26113423          	sd	ra,616(sp)
  c6:	26813023          	sd	s0,608(sp)
  ca:	24913c23          	sd	s1,600(sp)
  ce:	25213823          	sd	s2,592(sp)
  d2:	25313423          	sd	s3,584(sp)
  d6:	25413023          	sd	s4,576(sp)
  da:	23513c23          	sd	s5,568(sp)
  de:	1c80                	addi	s0,sp,624
  e0:	892a                	mv	s2,a0
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
  e2:	4581                	li	a1,0
  e4:	00000097          	auipc	ra,0x0
  e8:	4de080e7          	jalr	1246(ra) # 5c2 <open>
  ec:	08054a63          	bltz	a0,180 <ls+0xc2>
  f0:	84aa                	mv	s1,a0
    fprintf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
  f2:	d9840593          	addi	a1,s0,-616
  f6:	00000097          	auipc	ra,0x0
  fa:	4e4080e7          	jalr	1252(ra) # 5da <fstat>
  fe:	08054c63          	bltz	a0,196 <ls+0xd8>
    fprintf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }

  printf("ls, path = %s, st.type = %d\n", path, st.type);
 102:	da041603          	lh	a2,-608(s0)
 106:	85ca                	mv	a1,s2
 108:	00001517          	auipc	a0,0x1
 10c:	9c850513          	addi	a0,a0,-1592 # ad0 <malloc+0x116>
 110:	00000097          	auipc	ra,0x0
 114:	7ea080e7          	jalr	2026(ra) # 8fa <printf>
  switch(st.type){
 118:	da041783          	lh	a5,-608(s0)
 11c:	0007869b          	sext.w	a3,a5
 120:	4705                	li	a4,1
 122:	08e68a63          	beq	a3,a4,1b6 <ls+0xf8>
 126:	4709                	li	a4,2
 128:	02e69663          	bne	a3,a4,154 <ls+0x96>
  case T_FILE:
    printf("%s %d %d %l\n", fmtname(path), st.type, st.ino, st.size);
 12c:	854a                	mv	a0,s2
 12e:	00000097          	auipc	ra,0x0
 132:	ed2080e7          	jalr	-302(ra) # 0 <fmtname>
 136:	da843703          	ld	a4,-600(s0)
 13a:	d9c42683          	lw	a3,-612(s0)
 13e:	da041603          	lh	a2,-608(s0)
 142:	85aa                	mv	a1,a0
 144:	00001517          	auipc	a0,0x1
 148:	9ac50513          	addi	a0,a0,-1620 # af0 <malloc+0x136>
 14c:	00000097          	auipc	ra,0x0
 150:	7ae080e7          	jalr	1966(ra) # 8fa <printf>
      }
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
 154:	8526                	mv	a0,s1
 156:	00000097          	auipc	ra,0x0
 15a:	454080e7          	jalr	1108(ra) # 5aa <close>
}
 15e:	26813083          	ld	ra,616(sp)
 162:	26013403          	ld	s0,608(sp)
 166:	25813483          	ld	s1,600(sp)
 16a:	25013903          	ld	s2,592(sp)
 16e:	24813983          	ld	s3,584(sp)
 172:	24013a03          	ld	s4,576(sp)
 176:	23813a83          	ld	s5,568(sp)
 17a:	27010113          	addi	sp,sp,624
 17e:	8082                	ret
    fprintf(2, "ls: cannot open %s\n", path);
 180:	864a                	mv	a2,s2
 182:	00001597          	auipc	a1,0x1
 186:	91e58593          	addi	a1,a1,-1762 # aa0 <malloc+0xe6>
 18a:	4509                	li	a0,2
 18c:	00000097          	auipc	ra,0x0
 190:	740080e7          	jalr	1856(ra) # 8cc <fprintf>
    return;
 194:	b7e9                	j	15e <ls+0xa0>
    fprintf(2, "ls: cannot stat %s\n", path);
 196:	864a                	mv	a2,s2
 198:	00001597          	auipc	a1,0x1
 19c:	92058593          	addi	a1,a1,-1760 # ab8 <malloc+0xfe>
 1a0:	4509                	li	a0,2
 1a2:	00000097          	auipc	ra,0x0
 1a6:	72a080e7          	jalr	1834(ra) # 8cc <fprintf>
    close(fd);
 1aa:	8526                	mv	a0,s1
 1ac:	00000097          	auipc	ra,0x0
 1b0:	3fe080e7          	jalr	1022(ra) # 5aa <close>
    return;
 1b4:	b76d                	j	15e <ls+0xa0>
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 1b6:	854a                	mv	a0,s2
 1b8:	00000097          	auipc	ra,0x0
 1bc:	18a080e7          	jalr	394(ra) # 342 <strlen>
 1c0:	2541                	addiw	a0,a0,16
 1c2:	20000793          	li	a5,512
 1c6:	00a7fb63          	bleu	a0,a5,1dc <ls+0x11e>
      printf("ls: path too long\n");
 1ca:	00001517          	auipc	a0,0x1
 1ce:	93650513          	addi	a0,a0,-1738 # b00 <malloc+0x146>
 1d2:	00000097          	auipc	ra,0x0
 1d6:	728080e7          	jalr	1832(ra) # 8fa <printf>
      break;
 1da:	bfad                	j	154 <ls+0x96>
    strcpy(buf, path);
 1dc:	85ca                	mv	a1,s2
 1de:	dc040513          	addi	a0,s0,-576
 1e2:	00000097          	auipc	ra,0x0
 1e6:	110080e7          	jalr	272(ra) # 2f2 <strcpy>
    p = buf+strlen(buf);
 1ea:	dc040513          	addi	a0,s0,-576
 1ee:	00000097          	auipc	ra,0x0
 1f2:	154080e7          	jalr	340(ra) # 342 <strlen>
 1f6:	1502                	slli	a0,a0,0x20
 1f8:	9101                	srli	a0,a0,0x20
 1fa:	dc040793          	addi	a5,s0,-576
 1fe:	00a78933          	add	s2,a5,a0
    *p++ = '/';
 202:	00190993          	addi	s3,s2,1
 206:	02f00793          	li	a5,47
 20a:	00f90023          	sb	a5,0(s2)
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 20e:	00001a17          	auipc	s4,0x1
 212:	90aa0a13          	addi	s4,s4,-1782 # b18 <malloc+0x15e>
        printf("ls: cannot stat %s\n", buf);
 216:	00001a97          	auipc	s5,0x1
 21a:	8a2a8a93          	addi	s5,s5,-1886 # ab8 <malloc+0xfe>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 21e:	a801                	j	22e <ls+0x170>
        printf("ls: cannot stat %s\n", buf);
 220:	dc040593          	addi	a1,s0,-576
 224:	8556                	mv	a0,s5
 226:	00000097          	auipc	ra,0x0
 22a:	6d4080e7          	jalr	1748(ra) # 8fa <printf>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 22e:	4641                	li	a2,16
 230:	db040593          	addi	a1,s0,-592
 234:	8526                	mv	a0,s1
 236:	00000097          	auipc	ra,0x0
 23a:	364080e7          	jalr	868(ra) # 59a <read>
 23e:	47c1                	li	a5,16
 240:	f0f51ae3          	bne	a0,a5,154 <ls+0x96>
      if(de.inum == 0)
 244:	db045783          	lhu	a5,-592(s0)
 248:	d3fd                	beqz	a5,22e <ls+0x170>
      memmove(p, de.name, DIRSIZ);
 24a:	4639                	li	a2,14
 24c:	db240593          	addi	a1,s0,-590
 250:	854e                	mv	a0,s3
 252:	00000097          	auipc	ra,0x0
 256:	26e080e7          	jalr	622(ra) # 4c0 <memmove>
      p[DIRSIZ] = 0;
 25a:	000907a3          	sb	zero,15(s2)
      if(stat(buf, &st) < 0){
 25e:	d9840593          	addi	a1,s0,-616
 262:	dc040513          	addi	a0,s0,-576
 266:	00000097          	auipc	ra,0x0
 26a:	1ca080e7          	jalr	458(ra) # 430 <stat>
 26e:	fa0549e3          	bltz	a0,220 <ls+0x162>
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 272:	dc040513          	addi	a0,s0,-576
 276:	00000097          	auipc	ra,0x0
 27a:	d8a080e7          	jalr	-630(ra) # 0 <fmtname>
 27e:	da843703          	ld	a4,-600(s0)
 282:	d9c42683          	lw	a3,-612(s0)
 286:	da041603          	lh	a2,-608(s0)
 28a:	85aa                	mv	a1,a0
 28c:	8552                	mv	a0,s4
 28e:	00000097          	auipc	ra,0x0
 292:	66c080e7          	jalr	1644(ra) # 8fa <printf>
 296:	bf61                	j	22e <ls+0x170>

0000000000000298 <main>:

int
main(int argc, char *argv[])
{
 298:	1101                	addi	sp,sp,-32
 29a:	ec06                	sd	ra,24(sp)
 29c:	e822                	sd	s0,16(sp)
 29e:	e426                	sd	s1,8(sp)
 2a0:	e04a                	sd	s2,0(sp)
 2a2:	1000                	addi	s0,sp,32
  int i;

  if(argc < 2){
 2a4:	4785                	li	a5,1
 2a6:	02a7d963          	ble	a0,a5,2d8 <main+0x40>
 2aa:	00858493          	addi	s1,a1,8
 2ae:	ffe5091b          	addiw	s2,a0,-2
 2b2:	1902                	slli	s2,s2,0x20
 2b4:	02095913          	srli	s2,s2,0x20
 2b8:	090e                	slli	s2,s2,0x3
 2ba:	05c1                	addi	a1,a1,16
 2bc:	992e                	add	s2,s2,a1
    ls(".");
    exit(0);
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
 2be:	6088                	ld	a0,0(s1)
 2c0:	00000097          	auipc	ra,0x0
 2c4:	dfe080e7          	jalr	-514(ra) # be <ls>
  for(i=1; i<argc; i++)
 2c8:	04a1                	addi	s1,s1,8
 2ca:	ff249ae3          	bne	s1,s2,2be <main+0x26>
  exit(0);
 2ce:	4501                	li	a0,0
 2d0:	00000097          	auipc	ra,0x0
 2d4:	2b2080e7          	jalr	690(ra) # 582 <exit>
    ls(".");
 2d8:	00001517          	auipc	a0,0x1
 2dc:	85050513          	addi	a0,a0,-1968 # b28 <malloc+0x16e>
 2e0:	00000097          	auipc	ra,0x0
 2e4:	dde080e7          	jalr	-546(ra) # be <ls>
    exit(0);
 2e8:	4501                	li	a0,0
 2ea:	00000097          	auipc	ra,0x0
 2ee:	298080e7          	jalr	664(ra) # 582 <exit>

00000000000002f2 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 2f2:	1141                	addi	sp,sp,-16
 2f4:	e422                	sd	s0,8(sp)
 2f6:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2f8:	87aa                	mv	a5,a0
 2fa:	0585                	addi	a1,a1,1
 2fc:	0785                	addi	a5,a5,1
 2fe:	fff5c703          	lbu	a4,-1(a1)
 302:	fee78fa3          	sb	a4,-1(a5)
 306:	fb75                	bnez	a4,2fa <strcpy+0x8>
    ;
  return os;
}
 308:	6422                	ld	s0,8(sp)
 30a:	0141                	addi	sp,sp,16
 30c:	8082                	ret

000000000000030e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 30e:	1141                	addi	sp,sp,-16
 310:	e422                	sd	s0,8(sp)
 312:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 314:	00054783          	lbu	a5,0(a0)
 318:	cf91                	beqz	a5,334 <strcmp+0x26>
 31a:	0005c703          	lbu	a4,0(a1)
 31e:	00f71b63          	bne	a4,a5,334 <strcmp+0x26>
    p++, q++;
 322:	0505                	addi	a0,a0,1
 324:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 326:	00054783          	lbu	a5,0(a0)
 32a:	c789                	beqz	a5,334 <strcmp+0x26>
 32c:	0005c703          	lbu	a4,0(a1)
 330:	fef709e3          	beq	a4,a5,322 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
 334:	0005c503          	lbu	a0,0(a1)
}
 338:	40a7853b          	subw	a0,a5,a0
 33c:	6422                	ld	s0,8(sp)
 33e:	0141                	addi	sp,sp,16
 340:	8082                	ret

0000000000000342 <strlen>:

uint
strlen(const char *s)
{
 342:	1141                	addi	sp,sp,-16
 344:	e422                	sd	s0,8(sp)
 346:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 348:	00054783          	lbu	a5,0(a0)
 34c:	cf91                	beqz	a5,368 <strlen+0x26>
 34e:	0505                	addi	a0,a0,1
 350:	87aa                	mv	a5,a0
 352:	4685                	li	a3,1
 354:	9e89                	subw	a3,a3,a0
 356:	00f6853b          	addw	a0,a3,a5
 35a:	0785                	addi	a5,a5,1
 35c:	fff7c703          	lbu	a4,-1(a5)
 360:	fb7d                	bnez	a4,356 <strlen+0x14>
    ;
  return n;
}
 362:	6422                	ld	s0,8(sp)
 364:	0141                	addi	sp,sp,16
 366:	8082                	ret
  for(n = 0; s[n]; n++)
 368:	4501                	li	a0,0
 36a:	bfe5                	j	362 <strlen+0x20>

000000000000036c <memset>:

void*
memset(void *dst, int c, uint n)
{
 36c:	1141                	addi	sp,sp,-16
 36e:	e422                	sd	s0,8(sp)
 370:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 372:	ce09                	beqz	a2,38c <memset+0x20>
 374:	87aa                	mv	a5,a0
 376:	fff6071b          	addiw	a4,a2,-1
 37a:	1702                	slli	a4,a4,0x20
 37c:	9301                	srli	a4,a4,0x20
 37e:	0705                	addi	a4,a4,1
 380:	972a                	add	a4,a4,a0
    cdst[i] = c;
 382:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 386:	0785                	addi	a5,a5,1
 388:	fee79de3          	bne	a5,a4,382 <memset+0x16>
  }
  return dst;
}
 38c:	6422                	ld	s0,8(sp)
 38e:	0141                	addi	sp,sp,16
 390:	8082                	ret

0000000000000392 <strchr>:

char*
strchr(const char *s, char c)
{
 392:	1141                	addi	sp,sp,-16
 394:	e422                	sd	s0,8(sp)
 396:	0800                	addi	s0,sp,16
  for(; *s; s++)
 398:	00054783          	lbu	a5,0(a0)
 39c:	cf91                	beqz	a5,3b8 <strchr+0x26>
    if(*s == c)
 39e:	00f58a63          	beq	a1,a5,3b2 <strchr+0x20>
  for(; *s; s++)
 3a2:	0505                	addi	a0,a0,1
 3a4:	00054783          	lbu	a5,0(a0)
 3a8:	c781                	beqz	a5,3b0 <strchr+0x1e>
    if(*s == c)
 3aa:	feb79ce3          	bne	a5,a1,3a2 <strchr+0x10>
 3ae:	a011                	j	3b2 <strchr+0x20>
      return (char*)s;
  return 0;
 3b0:	4501                	li	a0,0
}
 3b2:	6422                	ld	s0,8(sp)
 3b4:	0141                	addi	sp,sp,16
 3b6:	8082                	ret
  return 0;
 3b8:	4501                	li	a0,0
 3ba:	bfe5                	j	3b2 <strchr+0x20>

00000000000003bc <gets>:

char*
gets(char *buf, int max)
{
 3bc:	711d                	addi	sp,sp,-96
 3be:	ec86                	sd	ra,88(sp)
 3c0:	e8a2                	sd	s0,80(sp)
 3c2:	e4a6                	sd	s1,72(sp)
 3c4:	e0ca                	sd	s2,64(sp)
 3c6:	fc4e                	sd	s3,56(sp)
 3c8:	f852                	sd	s4,48(sp)
 3ca:	f456                	sd	s5,40(sp)
 3cc:	f05a                	sd	s6,32(sp)
 3ce:	ec5e                	sd	s7,24(sp)
 3d0:	1080                	addi	s0,sp,96
 3d2:	8baa                	mv	s7,a0
 3d4:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3d6:	892a                	mv	s2,a0
 3d8:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 3da:	4aa9                	li	s5,10
 3dc:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 3de:	0019849b          	addiw	s1,s3,1
 3e2:	0344d863          	ble	s4,s1,412 <gets+0x56>
    cc = read(0, &c, 1);
 3e6:	4605                	li	a2,1
 3e8:	faf40593          	addi	a1,s0,-81
 3ec:	4501                	li	a0,0
 3ee:	00000097          	auipc	ra,0x0
 3f2:	1ac080e7          	jalr	428(ra) # 59a <read>
    if(cc < 1)
 3f6:	00a05e63          	blez	a0,412 <gets+0x56>
    buf[i++] = c;
 3fa:	faf44783          	lbu	a5,-81(s0)
 3fe:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 402:	01578763          	beq	a5,s5,410 <gets+0x54>
 406:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 408:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 40a:	fd679ae3          	bne	a5,s6,3de <gets+0x22>
 40e:	a011                	j	412 <gets+0x56>
  for(i=0; i+1 < max; ){
 410:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 412:	99de                	add	s3,s3,s7
 414:	00098023          	sb	zero,0(s3)
  return buf;
}
 418:	855e                	mv	a0,s7
 41a:	60e6                	ld	ra,88(sp)
 41c:	6446                	ld	s0,80(sp)
 41e:	64a6                	ld	s1,72(sp)
 420:	6906                	ld	s2,64(sp)
 422:	79e2                	ld	s3,56(sp)
 424:	7a42                	ld	s4,48(sp)
 426:	7aa2                	ld	s5,40(sp)
 428:	7b02                	ld	s6,32(sp)
 42a:	6be2                	ld	s7,24(sp)
 42c:	6125                	addi	sp,sp,96
 42e:	8082                	ret

0000000000000430 <stat>:

int
stat(const char *n, struct stat *st)
{
 430:	1101                	addi	sp,sp,-32
 432:	ec06                	sd	ra,24(sp)
 434:	e822                	sd	s0,16(sp)
 436:	e426                	sd	s1,8(sp)
 438:	e04a                	sd	s2,0(sp)
 43a:	1000                	addi	s0,sp,32
 43c:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 43e:	4581                	li	a1,0
 440:	00000097          	auipc	ra,0x0
 444:	182080e7          	jalr	386(ra) # 5c2 <open>
  if(fd < 0)
 448:	02054563          	bltz	a0,472 <stat+0x42>
 44c:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 44e:	85ca                	mv	a1,s2
 450:	00000097          	auipc	ra,0x0
 454:	18a080e7          	jalr	394(ra) # 5da <fstat>
 458:	892a                	mv	s2,a0
  close(fd);
 45a:	8526                	mv	a0,s1
 45c:	00000097          	auipc	ra,0x0
 460:	14e080e7          	jalr	334(ra) # 5aa <close>
  return r;
}
 464:	854a                	mv	a0,s2
 466:	60e2                	ld	ra,24(sp)
 468:	6442                	ld	s0,16(sp)
 46a:	64a2                	ld	s1,8(sp)
 46c:	6902                	ld	s2,0(sp)
 46e:	6105                	addi	sp,sp,32
 470:	8082                	ret
    return -1;
 472:	597d                	li	s2,-1
 474:	bfc5                	j	464 <stat+0x34>

0000000000000476 <atoi>:

int
atoi(const char *s)
{
 476:	1141                	addi	sp,sp,-16
 478:	e422                	sd	s0,8(sp)
 47a:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 47c:	00054683          	lbu	a3,0(a0)
 480:	fd06879b          	addiw	a5,a3,-48
 484:	0ff7f793          	andi	a5,a5,255
 488:	4725                	li	a4,9
 48a:	02f76963          	bltu	a4,a5,4bc <atoi+0x46>
 48e:	862a                	mv	a2,a0
  n = 0;
 490:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 492:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 494:	0605                	addi	a2,a2,1
 496:	0025179b          	slliw	a5,a0,0x2
 49a:	9fa9                	addw	a5,a5,a0
 49c:	0017979b          	slliw	a5,a5,0x1
 4a0:	9fb5                	addw	a5,a5,a3
 4a2:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 4a6:	00064683          	lbu	a3,0(a2)
 4aa:	fd06871b          	addiw	a4,a3,-48
 4ae:	0ff77713          	andi	a4,a4,255
 4b2:	fee5f1e3          	bleu	a4,a1,494 <atoi+0x1e>
  return n;
}
 4b6:	6422                	ld	s0,8(sp)
 4b8:	0141                	addi	sp,sp,16
 4ba:	8082                	ret
  n = 0;
 4bc:	4501                	li	a0,0
 4be:	bfe5                	j	4b6 <atoi+0x40>

00000000000004c0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 4c0:	1141                	addi	sp,sp,-16
 4c2:	e422                	sd	s0,8(sp)
 4c4:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 4c6:	02b57663          	bleu	a1,a0,4f2 <memmove+0x32>
    while(n-- > 0)
 4ca:	02c05163          	blez	a2,4ec <memmove+0x2c>
 4ce:	fff6079b          	addiw	a5,a2,-1
 4d2:	1782                	slli	a5,a5,0x20
 4d4:	9381                	srli	a5,a5,0x20
 4d6:	0785                	addi	a5,a5,1
 4d8:	97aa                	add	a5,a5,a0
  dst = vdst;
 4da:	872a                	mv	a4,a0
      *dst++ = *src++;
 4dc:	0585                	addi	a1,a1,1
 4de:	0705                	addi	a4,a4,1
 4e0:	fff5c683          	lbu	a3,-1(a1)
 4e4:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 4e8:	fee79ae3          	bne	a5,a4,4dc <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 4ec:	6422                	ld	s0,8(sp)
 4ee:	0141                	addi	sp,sp,16
 4f0:	8082                	ret
    dst += n;
 4f2:	00c50733          	add	a4,a0,a2
    src += n;
 4f6:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 4f8:	fec05ae3          	blez	a2,4ec <memmove+0x2c>
 4fc:	fff6079b          	addiw	a5,a2,-1
 500:	1782                	slli	a5,a5,0x20
 502:	9381                	srli	a5,a5,0x20
 504:	fff7c793          	not	a5,a5
 508:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 50a:	15fd                	addi	a1,a1,-1
 50c:	177d                	addi	a4,a4,-1
 50e:	0005c683          	lbu	a3,0(a1)
 512:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 516:	fef71ae3          	bne	a4,a5,50a <memmove+0x4a>
 51a:	bfc9                	j	4ec <memmove+0x2c>

000000000000051c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 51c:	1141                	addi	sp,sp,-16
 51e:	e422                	sd	s0,8(sp)
 520:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 522:	ce15                	beqz	a2,55e <memcmp+0x42>
 524:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
 528:	00054783          	lbu	a5,0(a0)
 52c:	0005c703          	lbu	a4,0(a1)
 530:	02e79063          	bne	a5,a4,550 <memcmp+0x34>
 534:	1682                	slli	a3,a3,0x20
 536:	9281                	srli	a3,a3,0x20
 538:	0685                	addi	a3,a3,1
 53a:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
 53c:	0505                	addi	a0,a0,1
    p2++;
 53e:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 540:	00d50d63          	beq	a0,a3,55a <memcmp+0x3e>
    if (*p1 != *p2) {
 544:	00054783          	lbu	a5,0(a0)
 548:	0005c703          	lbu	a4,0(a1)
 54c:	fee788e3          	beq	a5,a4,53c <memcmp+0x20>
      return *p1 - *p2;
 550:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
 554:	6422                	ld	s0,8(sp)
 556:	0141                	addi	sp,sp,16
 558:	8082                	ret
  return 0;
 55a:	4501                	li	a0,0
 55c:	bfe5                	j	554 <memcmp+0x38>
 55e:	4501                	li	a0,0
 560:	bfd5                	j	554 <memcmp+0x38>

0000000000000562 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 562:	1141                	addi	sp,sp,-16
 564:	e406                	sd	ra,8(sp)
 566:	e022                	sd	s0,0(sp)
 568:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 56a:	00000097          	auipc	ra,0x0
 56e:	f56080e7          	jalr	-170(ra) # 4c0 <memmove>
}
 572:	60a2                	ld	ra,8(sp)
 574:	6402                	ld	s0,0(sp)
 576:	0141                	addi	sp,sp,16
 578:	8082                	ret

000000000000057a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 57a:	4885                	li	a7,1
 ecall
 57c:	00000073          	ecall
 ret
 580:	8082                	ret

0000000000000582 <exit>:
.global exit
exit:
 li a7, SYS_exit
 582:	4889                	li	a7,2
 ecall
 584:	00000073          	ecall
 ret
 588:	8082                	ret

000000000000058a <wait>:
.global wait
wait:
 li a7, SYS_wait
 58a:	488d                	li	a7,3
 ecall
 58c:	00000073          	ecall
 ret
 590:	8082                	ret

0000000000000592 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 592:	4891                	li	a7,4
 ecall
 594:	00000073          	ecall
 ret
 598:	8082                	ret

000000000000059a <read>:
.global read
read:
 li a7, SYS_read
 59a:	4895                	li	a7,5
 ecall
 59c:	00000073          	ecall
 ret
 5a0:	8082                	ret

00000000000005a2 <write>:
.global write
write:
 li a7, SYS_write
 5a2:	48c1                	li	a7,16
 ecall
 5a4:	00000073          	ecall
 ret
 5a8:	8082                	ret

00000000000005aa <close>:
.global close
close:
 li a7, SYS_close
 5aa:	48d5                	li	a7,21
 ecall
 5ac:	00000073          	ecall
 ret
 5b0:	8082                	ret

00000000000005b2 <kill>:
.global kill
kill:
 li a7, SYS_kill
 5b2:	4899                	li	a7,6
 ecall
 5b4:	00000073          	ecall
 ret
 5b8:	8082                	ret

00000000000005ba <exec>:
.global exec
exec:
 li a7, SYS_exec
 5ba:	489d                	li	a7,7
 ecall
 5bc:	00000073          	ecall
 ret
 5c0:	8082                	ret

00000000000005c2 <open>:
.global open
open:
 li a7, SYS_open
 5c2:	48bd                	li	a7,15
 ecall
 5c4:	00000073          	ecall
 ret
 5c8:	8082                	ret

00000000000005ca <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 5ca:	48c5                	li	a7,17
 ecall
 5cc:	00000073          	ecall
 ret
 5d0:	8082                	ret

00000000000005d2 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 5d2:	48c9                	li	a7,18
 ecall
 5d4:	00000073          	ecall
 ret
 5d8:	8082                	ret

00000000000005da <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5da:	48a1                	li	a7,8
 ecall
 5dc:	00000073          	ecall
 ret
 5e0:	8082                	ret

00000000000005e2 <link>:
.global link
link:
 li a7, SYS_link
 5e2:	48cd                	li	a7,19
 ecall
 5e4:	00000073          	ecall
 ret
 5e8:	8082                	ret

00000000000005ea <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5ea:	48d1                	li	a7,20
 ecall
 5ec:	00000073          	ecall
 ret
 5f0:	8082                	ret

00000000000005f2 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5f2:	48a5                	li	a7,9
 ecall
 5f4:	00000073          	ecall
 ret
 5f8:	8082                	ret

00000000000005fa <dup>:
.global dup
dup:
 li a7, SYS_dup
 5fa:	48a9                	li	a7,10
 ecall
 5fc:	00000073          	ecall
 ret
 600:	8082                	ret

0000000000000602 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 602:	48ad                	li	a7,11
 ecall
 604:	00000073          	ecall
 ret
 608:	8082                	ret

000000000000060a <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 60a:	48b1                	li	a7,12
 ecall
 60c:	00000073          	ecall
 ret
 610:	8082                	ret

0000000000000612 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 612:	48b5                	li	a7,13
 ecall
 614:	00000073          	ecall
 ret
 618:	8082                	ret

000000000000061a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 61a:	48b9                	li	a7,14
 ecall
 61c:	00000073          	ecall
 ret
 620:	8082                	ret

0000000000000622 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 622:	1101                	addi	sp,sp,-32
 624:	ec06                	sd	ra,24(sp)
 626:	e822                	sd	s0,16(sp)
 628:	1000                	addi	s0,sp,32
 62a:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 62e:	4605                	li	a2,1
 630:	fef40593          	addi	a1,s0,-17
 634:	00000097          	auipc	ra,0x0
 638:	f6e080e7          	jalr	-146(ra) # 5a2 <write>
}
 63c:	60e2                	ld	ra,24(sp)
 63e:	6442                	ld	s0,16(sp)
 640:	6105                	addi	sp,sp,32
 642:	8082                	ret

0000000000000644 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 644:	7139                	addi	sp,sp,-64
 646:	fc06                	sd	ra,56(sp)
 648:	f822                	sd	s0,48(sp)
 64a:	f426                	sd	s1,40(sp)
 64c:	f04a                	sd	s2,32(sp)
 64e:	ec4e                	sd	s3,24(sp)
 650:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 652:	c299                	beqz	a3,658 <printint+0x14>
 654:	0005cd63          	bltz	a1,66e <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 658:	2581                	sext.w	a1,a1
  neg = 0;
 65a:	4301                	li	t1,0
 65c:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 660:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 662:	2601                	sext.w	a2,a2
 664:	00000897          	auipc	a7,0x0
 668:	4cc88893          	addi	a7,a7,1228 # b30 <digits>
 66c:	a801                	j	67c <printint+0x38>
    x = -xx;
 66e:	40b005bb          	negw	a1,a1
 672:	2581                	sext.w	a1,a1
    neg = 1;
 674:	4305                	li	t1,1
    x = -xx;
 676:	b7dd                	j	65c <printint+0x18>
  }while((x /= base) != 0);
 678:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 67a:	8836                	mv	a6,a3
 67c:	0018069b          	addiw	a3,a6,1
 680:	02c5f7bb          	remuw	a5,a1,a2
 684:	1782                	slli	a5,a5,0x20
 686:	9381                	srli	a5,a5,0x20
 688:	97c6                	add	a5,a5,a7
 68a:	0007c783          	lbu	a5,0(a5)
 68e:	00f70023          	sb	a5,0(a4)
  }while((x /= base) != 0);
 692:	0705                	addi	a4,a4,1
 694:	02c5d7bb          	divuw	a5,a1,a2
 698:	fec5f0e3          	bleu	a2,a1,678 <printint+0x34>
  if(neg)
 69c:	00030b63          	beqz	t1,6b2 <printint+0x6e>
    buf[i++] = '-';
 6a0:	fd040793          	addi	a5,s0,-48
 6a4:	96be                	add	a3,a3,a5
 6a6:	02d00793          	li	a5,45
 6aa:	fef68823          	sb	a5,-16(a3)
 6ae:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 6b2:	02d05963          	blez	a3,6e4 <printint+0xa0>
 6b6:	89aa                	mv	s3,a0
 6b8:	fc040793          	addi	a5,s0,-64
 6bc:	00d784b3          	add	s1,a5,a3
 6c0:	fff78913          	addi	s2,a5,-1
 6c4:	9936                	add	s2,s2,a3
 6c6:	36fd                	addiw	a3,a3,-1
 6c8:	1682                	slli	a3,a3,0x20
 6ca:	9281                	srli	a3,a3,0x20
 6cc:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 6d0:	fff4c583          	lbu	a1,-1(s1)
 6d4:	854e                	mv	a0,s3
 6d6:	00000097          	auipc	ra,0x0
 6da:	f4c080e7          	jalr	-180(ra) # 622 <putc>
  while(--i >= 0)
 6de:	14fd                	addi	s1,s1,-1
 6e0:	ff2498e3          	bne	s1,s2,6d0 <printint+0x8c>
}
 6e4:	70e2                	ld	ra,56(sp)
 6e6:	7442                	ld	s0,48(sp)
 6e8:	74a2                	ld	s1,40(sp)
 6ea:	7902                	ld	s2,32(sp)
 6ec:	69e2                	ld	s3,24(sp)
 6ee:	6121                	addi	sp,sp,64
 6f0:	8082                	ret

00000000000006f2 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 6f2:	7119                	addi	sp,sp,-128
 6f4:	fc86                	sd	ra,120(sp)
 6f6:	f8a2                	sd	s0,112(sp)
 6f8:	f4a6                	sd	s1,104(sp)
 6fa:	f0ca                	sd	s2,96(sp)
 6fc:	ecce                	sd	s3,88(sp)
 6fe:	e8d2                	sd	s4,80(sp)
 700:	e4d6                	sd	s5,72(sp)
 702:	e0da                	sd	s6,64(sp)
 704:	fc5e                	sd	s7,56(sp)
 706:	f862                	sd	s8,48(sp)
 708:	f466                	sd	s9,40(sp)
 70a:	f06a                	sd	s10,32(sp)
 70c:	ec6e                	sd	s11,24(sp)
 70e:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 710:	0005c483          	lbu	s1,0(a1)
 714:	18048d63          	beqz	s1,8ae <vprintf+0x1bc>
 718:	8aaa                	mv	s5,a0
 71a:	8b32                	mv	s6,a2
 71c:	00158913          	addi	s2,a1,1
  state = 0;
 720:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 722:	02500a13          	li	s4,37
      if(c == 'd'){
 726:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 72a:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 72e:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 732:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 736:	00000b97          	auipc	s7,0x0
 73a:	3fab8b93          	addi	s7,s7,1018 # b30 <digits>
 73e:	a839                	j	75c <vprintf+0x6a>
        putc(fd, c);
 740:	85a6                	mv	a1,s1
 742:	8556                	mv	a0,s5
 744:	00000097          	auipc	ra,0x0
 748:	ede080e7          	jalr	-290(ra) # 622 <putc>
 74c:	a019                	j	752 <vprintf+0x60>
    } else if(state == '%'){
 74e:	01498f63          	beq	s3,s4,76c <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 752:	0905                	addi	s2,s2,1
 754:	fff94483          	lbu	s1,-1(s2)
 758:	14048b63          	beqz	s1,8ae <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 75c:	0004879b          	sext.w	a5,s1
    if(state == 0){
 760:	fe0997e3          	bnez	s3,74e <vprintf+0x5c>
      if(c == '%'){
 764:	fd479ee3          	bne	a5,s4,740 <vprintf+0x4e>
        state = '%';
 768:	89be                	mv	s3,a5
 76a:	b7e5                	j	752 <vprintf+0x60>
      if(c == 'd'){
 76c:	05878063          	beq	a5,s8,7ac <vprintf+0xba>
      } else if(c == 'l') {
 770:	05978c63          	beq	a5,s9,7c8 <vprintf+0xd6>
      } else if(c == 'x') {
 774:	07a78863          	beq	a5,s10,7e4 <vprintf+0xf2>
      } else if(c == 'p') {
 778:	09b78463          	beq	a5,s11,800 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 77c:	07300713          	li	a4,115
 780:	0ce78563          	beq	a5,a4,84a <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 784:	06300713          	li	a4,99
 788:	0ee78c63          	beq	a5,a4,880 <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 78c:	11478663          	beq	a5,s4,898 <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 790:	85d2                	mv	a1,s4
 792:	8556                	mv	a0,s5
 794:	00000097          	auipc	ra,0x0
 798:	e8e080e7          	jalr	-370(ra) # 622 <putc>
        putc(fd, c);
 79c:	85a6                	mv	a1,s1
 79e:	8556                	mv	a0,s5
 7a0:	00000097          	auipc	ra,0x0
 7a4:	e82080e7          	jalr	-382(ra) # 622 <putc>
      }
      state = 0;
 7a8:	4981                	li	s3,0
 7aa:	b765                	j	752 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 7ac:	008b0493          	addi	s1,s6,8
 7b0:	4685                	li	a3,1
 7b2:	4629                	li	a2,10
 7b4:	000b2583          	lw	a1,0(s6)
 7b8:	8556                	mv	a0,s5
 7ba:	00000097          	auipc	ra,0x0
 7be:	e8a080e7          	jalr	-374(ra) # 644 <printint>
 7c2:	8b26                	mv	s6,s1
      state = 0;
 7c4:	4981                	li	s3,0
 7c6:	b771                	j	752 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7c8:	008b0493          	addi	s1,s6,8
 7cc:	4681                	li	a3,0
 7ce:	4629                	li	a2,10
 7d0:	000b2583          	lw	a1,0(s6)
 7d4:	8556                	mv	a0,s5
 7d6:	00000097          	auipc	ra,0x0
 7da:	e6e080e7          	jalr	-402(ra) # 644 <printint>
 7de:	8b26                	mv	s6,s1
      state = 0;
 7e0:	4981                	li	s3,0
 7e2:	bf85                	j	752 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 7e4:	008b0493          	addi	s1,s6,8
 7e8:	4681                	li	a3,0
 7ea:	4641                	li	a2,16
 7ec:	000b2583          	lw	a1,0(s6)
 7f0:	8556                	mv	a0,s5
 7f2:	00000097          	auipc	ra,0x0
 7f6:	e52080e7          	jalr	-430(ra) # 644 <printint>
 7fa:	8b26                	mv	s6,s1
      state = 0;
 7fc:	4981                	li	s3,0
 7fe:	bf91                	j	752 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 800:	008b0793          	addi	a5,s6,8
 804:	f8f43423          	sd	a5,-120(s0)
 808:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 80c:	03000593          	li	a1,48
 810:	8556                	mv	a0,s5
 812:	00000097          	auipc	ra,0x0
 816:	e10080e7          	jalr	-496(ra) # 622 <putc>
  putc(fd, 'x');
 81a:	85ea                	mv	a1,s10
 81c:	8556                	mv	a0,s5
 81e:	00000097          	auipc	ra,0x0
 822:	e04080e7          	jalr	-508(ra) # 622 <putc>
 826:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 828:	03c9d793          	srli	a5,s3,0x3c
 82c:	97de                	add	a5,a5,s7
 82e:	0007c583          	lbu	a1,0(a5)
 832:	8556                	mv	a0,s5
 834:	00000097          	auipc	ra,0x0
 838:	dee080e7          	jalr	-530(ra) # 622 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 83c:	0992                	slli	s3,s3,0x4
 83e:	34fd                	addiw	s1,s1,-1
 840:	f4e5                	bnez	s1,828 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 842:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 846:	4981                	li	s3,0
 848:	b729                	j	752 <vprintf+0x60>
        s = va_arg(ap, char*);
 84a:	008b0993          	addi	s3,s6,8
 84e:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 852:	c085                	beqz	s1,872 <vprintf+0x180>
        while(*s != 0){
 854:	0004c583          	lbu	a1,0(s1)
 858:	c9a1                	beqz	a1,8a8 <vprintf+0x1b6>
          putc(fd, *s);
 85a:	8556                	mv	a0,s5
 85c:	00000097          	auipc	ra,0x0
 860:	dc6080e7          	jalr	-570(ra) # 622 <putc>
          s++;
 864:	0485                	addi	s1,s1,1
        while(*s != 0){
 866:	0004c583          	lbu	a1,0(s1)
 86a:	f9e5                	bnez	a1,85a <vprintf+0x168>
        s = va_arg(ap, char*);
 86c:	8b4e                	mv	s6,s3
      state = 0;
 86e:	4981                	li	s3,0
 870:	b5cd                	j	752 <vprintf+0x60>
          s = "(null)";
 872:	00000497          	auipc	s1,0x0
 876:	2d648493          	addi	s1,s1,726 # b48 <digits+0x18>
        while(*s != 0){
 87a:	02800593          	li	a1,40
 87e:	bff1                	j	85a <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 880:	008b0493          	addi	s1,s6,8
 884:	000b4583          	lbu	a1,0(s6)
 888:	8556                	mv	a0,s5
 88a:	00000097          	auipc	ra,0x0
 88e:	d98080e7          	jalr	-616(ra) # 622 <putc>
 892:	8b26                	mv	s6,s1
      state = 0;
 894:	4981                	li	s3,0
 896:	bd75                	j	752 <vprintf+0x60>
        putc(fd, c);
 898:	85d2                	mv	a1,s4
 89a:	8556                	mv	a0,s5
 89c:	00000097          	auipc	ra,0x0
 8a0:	d86080e7          	jalr	-634(ra) # 622 <putc>
      state = 0;
 8a4:	4981                	li	s3,0
 8a6:	b575                	j	752 <vprintf+0x60>
        s = va_arg(ap, char*);
 8a8:	8b4e                	mv	s6,s3
      state = 0;
 8aa:	4981                	li	s3,0
 8ac:	b55d                	j	752 <vprintf+0x60>
    }
  }
}
 8ae:	70e6                	ld	ra,120(sp)
 8b0:	7446                	ld	s0,112(sp)
 8b2:	74a6                	ld	s1,104(sp)
 8b4:	7906                	ld	s2,96(sp)
 8b6:	69e6                	ld	s3,88(sp)
 8b8:	6a46                	ld	s4,80(sp)
 8ba:	6aa6                	ld	s5,72(sp)
 8bc:	6b06                	ld	s6,64(sp)
 8be:	7be2                	ld	s7,56(sp)
 8c0:	7c42                	ld	s8,48(sp)
 8c2:	7ca2                	ld	s9,40(sp)
 8c4:	7d02                	ld	s10,32(sp)
 8c6:	6de2                	ld	s11,24(sp)
 8c8:	6109                	addi	sp,sp,128
 8ca:	8082                	ret

00000000000008cc <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 8cc:	715d                	addi	sp,sp,-80
 8ce:	ec06                	sd	ra,24(sp)
 8d0:	e822                	sd	s0,16(sp)
 8d2:	1000                	addi	s0,sp,32
 8d4:	e010                	sd	a2,0(s0)
 8d6:	e414                	sd	a3,8(s0)
 8d8:	e818                	sd	a4,16(s0)
 8da:	ec1c                	sd	a5,24(s0)
 8dc:	03043023          	sd	a6,32(s0)
 8e0:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 8e4:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 8e8:	8622                	mv	a2,s0
 8ea:	00000097          	auipc	ra,0x0
 8ee:	e08080e7          	jalr	-504(ra) # 6f2 <vprintf>
}
 8f2:	60e2                	ld	ra,24(sp)
 8f4:	6442                	ld	s0,16(sp)
 8f6:	6161                	addi	sp,sp,80
 8f8:	8082                	ret

00000000000008fa <printf>:

void
printf(const char *fmt, ...)
{
 8fa:	711d                	addi	sp,sp,-96
 8fc:	ec06                	sd	ra,24(sp)
 8fe:	e822                	sd	s0,16(sp)
 900:	1000                	addi	s0,sp,32
 902:	e40c                	sd	a1,8(s0)
 904:	e810                	sd	a2,16(s0)
 906:	ec14                	sd	a3,24(s0)
 908:	f018                	sd	a4,32(s0)
 90a:	f41c                	sd	a5,40(s0)
 90c:	03043823          	sd	a6,48(s0)
 910:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 914:	00840613          	addi	a2,s0,8
 918:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 91c:	85aa                	mv	a1,a0
 91e:	4505                	li	a0,1
 920:	00000097          	auipc	ra,0x0
 924:	dd2080e7          	jalr	-558(ra) # 6f2 <vprintf>
}
 928:	60e2                	ld	ra,24(sp)
 92a:	6442                	ld	s0,16(sp)
 92c:	6125                	addi	sp,sp,96
 92e:	8082                	ret

0000000000000930 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 930:	1141                	addi	sp,sp,-16
 932:	e422                	sd	s0,8(sp)
 934:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 936:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 93a:	00000797          	auipc	a5,0x0
 93e:	21678793          	addi	a5,a5,534 # b50 <__bss_start>
 942:	639c                	ld	a5,0(a5)
 944:	a805                	j	974 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 946:	4618                	lw	a4,8(a2)
 948:	9db9                	addw	a1,a1,a4
 94a:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 94e:	6398                	ld	a4,0(a5)
 950:	6318                	ld	a4,0(a4)
 952:	fee53823          	sd	a4,-16(a0)
 956:	a091                	j	99a <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 958:	ff852703          	lw	a4,-8(a0)
 95c:	9e39                	addw	a2,a2,a4
 95e:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 960:	ff053703          	ld	a4,-16(a0)
 964:	e398                	sd	a4,0(a5)
 966:	a099                	j	9ac <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 968:	6398                	ld	a4,0(a5)
 96a:	00e7e463          	bltu	a5,a4,972 <free+0x42>
 96e:	00e6ea63          	bltu	a3,a4,982 <free+0x52>
{
 972:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 974:	fed7fae3          	bleu	a3,a5,968 <free+0x38>
 978:	6398                	ld	a4,0(a5)
 97a:	00e6e463          	bltu	a3,a4,982 <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 97e:	fee7eae3          	bltu	a5,a4,972 <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 982:	ff852583          	lw	a1,-8(a0)
 986:	6390                	ld	a2,0(a5)
 988:	02059713          	slli	a4,a1,0x20
 98c:	9301                	srli	a4,a4,0x20
 98e:	0712                	slli	a4,a4,0x4
 990:	9736                	add	a4,a4,a3
 992:	fae60ae3          	beq	a2,a4,946 <free+0x16>
    bp->s.ptr = p->s.ptr;
 996:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 99a:	4790                	lw	a2,8(a5)
 99c:	02061713          	slli	a4,a2,0x20
 9a0:	9301                	srli	a4,a4,0x20
 9a2:	0712                	slli	a4,a4,0x4
 9a4:	973e                	add	a4,a4,a5
 9a6:	fae689e3          	beq	a3,a4,958 <free+0x28>
  } else
    p->s.ptr = bp;
 9aa:	e394                	sd	a3,0(a5)
  freep = p;
 9ac:	00000717          	auipc	a4,0x0
 9b0:	1af73223          	sd	a5,420(a4) # b50 <__bss_start>
}
 9b4:	6422                	ld	s0,8(sp)
 9b6:	0141                	addi	sp,sp,16
 9b8:	8082                	ret

00000000000009ba <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9ba:	7139                	addi	sp,sp,-64
 9bc:	fc06                	sd	ra,56(sp)
 9be:	f822                	sd	s0,48(sp)
 9c0:	f426                	sd	s1,40(sp)
 9c2:	f04a                	sd	s2,32(sp)
 9c4:	ec4e                	sd	s3,24(sp)
 9c6:	e852                	sd	s4,16(sp)
 9c8:	e456                	sd	s5,8(sp)
 9ca:	e05a                	sd	s6,0(sp)
 9cc:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9ce:	02051993          	slli	s3,a0,0x20
 9d2:	0209d993          	srli	s3,s3,0x20
 9d6:	09bd                	addi	s3,s3,15
 9d8:	0049d993          	srli	s3,s3,0x4
 9dc:	2985                	addiw	s3,s3,1
 9de:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 9e2:	00000797          	auipc	a5,0x0
 9e6:	16e78793          	addi	a5,a5,366 # b50 <__bss_start>
 9ea:	6388                	ld	a0,0(a5)
 9ec:	c515                	beqz	a0,a18 <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9ee:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9f0:	4798                	lw	a4,8(a5)
 9f2:	03277f63          	bleu	s2,a4,a30 <malloc+0x76>
 9f6:	8a4e                	mv	s4,s3
 9f8:	0009871b          	sext.w	a4,s3
 9fc:	6685                	lui	a3,0x1
 9fe:	00d77363          	bleu	a3,a4,a04 <malloc+0x4a>
 a02:	6a05                	lui	s4,0x1
 a04:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 a08:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a0c:	00000497          	auipc	s1,0x0
 a10:	14448493          	addi	s1,s1,324 # b50 <__bss_start>
  if(p == (char*)-1)
 a14:	5b7d                	li	s6,-1
 a16:	a885                	j	a86 <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 a18:	00000797          	auipc	a5,0x0
 a1c:	15078793          	addi	a5,a5,336 # b68 <base>
 a20:	00000717          	auipc	a4,0x0
 a24:	12f73823          	sd	a5,304(a4) # b50 <__bss_start>
 a28:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a2a:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a2e:	b7e1                	j	9f6 <malloc+0x3c>
      if(p->s.size == nunits)
 a30:	02e90b63          	beq	s2,a4,a66 <malloc+0xac>
        p->s.size -= nunits;
 a34:	4137073b          	subw	a4,a4,s3
 a38:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a3a:	1702                	slli	a4,a4,0x20
 a3c:	9301                	srli	a4,a4,0x20
 a3e:	0712                	slli	a4,a4,0x4
 a40:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a42:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a46:	00000717          	auipc	a4,0x0
 a4a:	10a73523          	sd	a0,266(a4) # b50 <__bss_start>
      return (void*)(p + 1);
 a4e:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a52:	70e2                	ld	ra,56(sp)
 a54:	7442                	ld	s0,48(sp)
 a56:	74a2                	ld	s1,40(sp)
 a58:	7902                	ld	s2,32(sp)
 a5a:	69e2                	ld	s3,24(sp)
 a5c:	6a42                	ld	s4,16(sp)
 a5e:	6aa2                	ld	s5,8(sp)
 a60:	6b02                	ld	s6,0(sp)
 a62:	6121                	addi	sp,sp,64
 a64:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 a66:	6398                	ld	a4,0(a5)
 a68:	e118                	sd	a4,0(a0)
 a6a:	bff1                	j	a46 <malloc+0x8c>
  hp->s.size = nu;
 a6c:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 a70:	0541                	addi	a0,a0,16
 a72:	00000097          	auipc	ra,0x0
 a76:	ebe080e7          	jalr	-322(ra) # 930 <free>
  return freep;
 a7a:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 a7c:	d979                	beqz	a0,a52 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a7e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a80:	4798                	lw	a4,8(a5)
 a82:	fb2777e3          	bleu	s2,a4,a30 <malloc+0x76>
    if(p == freep)
 a86:	6098                	ld	a4,0(s1)
 a88:	853e                	mv	a0,a5
 a8a:	fef71ae3          	bne	a4,a5,a7e <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 a8e:	8552                	mv	a0,s4
 a90:	00000097          	auipc	ra,0x0
 a94:	b7a080e7          	jalr	-1158(ra) # 60a <sbrk>
  if(p == (char*)-1)
 a98:	fd651ae3          	bne	a0,s6,a6c <malloc+0xb2>
        return 0;
 a9c:	4501                	li	a0,0
 a9e:	bf55                	j	a52 <malloc+0x98>
