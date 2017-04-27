#8queen
#寄存器分配情况，
#$s0-Site[8]起始地址，$s1queen循环变量,
#$a0-$a2传递参数:$a0-n,$a1-QUEENS,$a2-iCounts,由于调用过程中不会修改n，$a0也顺便用作Valid的参数。对iCounts的计算直接存储在$a2，最后move到$v0返回
#$v0Valid和Queen返回值、系统调用
#$t0-$t6Valid计算所用:$t0循环变量
.data 0x10000000
.word 0,0,0,0,0,0,0,0 #Site[8]
str:
  	.asciiz "Eight Queen problems, entering the number of queens:"
.text
init:   ori $s0,$zero,0x1000 
		sll $s0,$s0,16  #$s0存储Site[8]起始地址
        j main
valid:  li $t0,0 #循环变量i存储在临时寄存器$t0里，因为不会调用其它过程来破坏寄存器
		sll $t1,$a0,2
		add $t1,$s0,$t1#$t1存储Site[n]地址
		lw $t2,0($t1) #$t2存储Site[n]
		sub $t3,$zero,$t2#$t3存储-Site[n]
valid_lp:  bge $t0,$a0,valid_end
		   sll $t1,$t0,2
		   add $t1,$s0,$t1#$t1存储Site[n]地址
		   lw $t4,0($t1)#$t4存储SIte[i]
		   beq $t2,$t4,valid_nend#if(Site[i]==Site[n]) return 0;
		   add $t5,$t4,$t3 #$t5=Site[i]-Site[n]
		   abs $t5,$t5 #$t5=abs(Site[i]-Site[n])
		   sub $t6,$zero,$t0#$t6=-i
		   add $t6,$a0,$t6#$t6=n-i
		   beq $t5,$t6,valid_nend#if(abs(Site[i] - Site[n]) == (n - i)) return 0;
		   addi $t0,$t0,1
		   j valid_lp
valid_nend:li $v0,0
	       jr $ra
valid_end: li $v0,1
	       jr $ra
	
queen:  bne  $a0,$a1,queen_lpi #Queen函数的三个参数$a0代表n，$a1代表QUEENS,$a2代表iCount，返回值在$v0
		addi $a2,$a2,1
		move $v0,$a2
		jr $ra
queen_lpi:addi $sp,$sp,-4
          sw $s1,0($sp)#存储$s1到栈，因为会被占用
		  li $s1,1 #$s1存储循环变量i
queen_lp: bgt $s1,$a1,queen_end
		  sll $t0,$a0,2 #计算Site偏移量n
		  add $t0,$s0,$t0
		  sw $s1, 0($t0) #Site[n]=i;
		  addi $sp,$sp,-4#调用过程前保存$ra
		  sw $ra,0($sp)
	      jal valid
	      lw $ra,0($sp)
	      addi $sp,$sp,4#用完退栈，下同
	      beq $v0,0,queen_lp2
queen_rc: addi $sp,$sp,-12#这里是Valid(n)==True执行的代码，递归调用Queen
	      sw $ra,8($sp)#须保护$a0-$a2,$s1,$ra，$s1由被调用者保护，$a0就是加减1免去sw,lw
	      sw $a2,4($sp)
	      #sw $a0,0($sp)
	      addi $a0,$a0,1
	      jal queen
	      lw $ra,8($sp)
		  lw $a2,4($sp)
	      addi $a0,$a0,-1
	      #lw $a0,0($sp)#改成减1,其实这条指令去掉后可以把上面的4和8改成0和4，减小栈的大小
	      move $a2,$v0
	      addi $sp,$sp,12
queen_lp2:addi $s1,$s1,1
	      j queen_lp	  
queen_end:lw $s1,0($sp)
	      addi $sp,$sp,4
	      move $v0,$a2
	      jr $ra

main:	la	$a0, str
		li 	$v0, 4
		syscall			# print string
		li      $v0, 5
		syscall		#readint,存储在v0中
		move    $a0,$zero#设置Queen参数
		move    $a1,$v0
		move    $a2,$zero#iCount就是0且在此后不被调用不被修改，忽略掉了
		jal queen
		move $a0,$v0
		li $v0,1
		syscall #print int
		li	$v0, 10
		syscall			# exit





