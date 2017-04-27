.data 0x10000000
.word -3,2,1,15,-1,8
.text
main:  ori  $a0,$0,0x1000
	   sll  $a0,$a0,16 #$a0存储data地址也就是数组起始地址
	   addi $a1,$0,6  #数组里有6个数
#sort函数两个参数v起始地址存储在$a0,n存储在$a1
sort:  addi $sp, $sp, -20
       sw   $ra, 16($sp)
       sw   $s3, 12($sp)
       sw   $s2, 8($sp)
       sw   $s1, 4($sp)
       sw   $s0, 0($sp)
	   move $s0, $zero    #循环初始化
loopbody1: bge  $s0,$a1, exit1 #$a1存储外循环次数n，$s0为外循环变量i
#内循环循环体
	       addi $s1, $s0,-1 #$s1存储内循环变量j，初始化为i-1
loopbody2: blt  $s1,0,loopbody1c
	       sll  $t1,$s1,2
	       add  $t1,$a0,$t1#仿照loop写法，计算v[j]地址存入$t1
	       lw   $t0,0($t1)#$t0=v[j]
	       lw   $t2,4($t1)#$t2=v[j+1]
           bgt  $t0,$t2,loopbody1c#内循环终止的第二个条件
	       move $a3,$s1
	       jal  swap
	       addi $s1,$s1,-1
	       j    loopbody2
loopbody1c:addi $s0,$s0,1
	       j    loopbody1
swap:  sll  $t1, $a3, 2 #a3存储变量k，a0存储v起始地址
	   add  $t1, $a0, $t1
	   lw   $t0, 0($t1)
	   lw   $t2, 4($t1)
	   sw   $t2, 0($t1)
	   sw   $t0, 4($t1)
	   jr   $ra
exit1: lw   $s0, 0($sp)
       lw   $s1, 4($sp)
       lw   $s2, 8($sp)
       lw   $s3, 12($sp)
       lw   $ra, 16($sp)
       addi $sp, $sp, 20
       jr   $ra
