#8queen
#�Ĵ������������
#$s0-Site[8]��ʼ��ַ��$s1queenѭ������,
#$a0-$a2���ݲ���:$a0-n,$a1-QUEENS,$a2-iCounts,���ڵ��ù����в����޸�n��$a0Ҳ˳������Valid�Ĳ�������iCounts�ļ���ֱ�Ӵ洢��$a2�����move��$v0����
#$v0Valid��Queen����ֵ��ϵͳ����
#$t0-$t6Valid��������:$t0ѭ������
.data 0x10000000
.word 0,0,0,0,0,0,0,0 #Site[8]
str:
  	.asciiz "Eight Queen problems, entering the number of queens:"
.text
init:   ori $s0,$zero,0x1000 
		sll $s0,$s0,16  #$s0�洢Site[8]��ʼ��ַ
        j main
valid:  li $t0,0 #ѭ������i�洢����ʱ�Ĵ���$t0���Ϊ������������������ƻ��Ĵ���
		sll $t1,$a0,2
		add $t1,$s0,$t1#$t1�洢Site[n]��ַ
		lw $t2,0($t1) #$t2�洢Site[n]
		sub $t3,$zero,$t2#$t3�洢-Site[n]
valid_lp:  bge $t0,$a0,valid_end
		   sll $t1,$t0,2
		   add $t1,$s0,$t1#$t1�洢Site[n]��ַ
		   lw $t4,0($t1)#$t4�洢SIte[i]
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
	
queen:  bne  $a0,$a1,queen_lpi #Queen��������������$a0����n��$a1����QUEENS,$a2����iCount������ֵ��$v0
		addi $a2,$a2,1
		move $v0,$a2
		jr $ra
queen_lpi:addi $sp,$sp,-4
          sw $s1,0($sp)#�洢$s1��ջ����Ϊ�ᱻռ��
		  li $s1,1 #$s1�洢ѭ������i
queen_lp: bgt $s1,$a1,queen_end
		  sll $t0,$a0,2 #����Siteƫ����n
		  add $t0,$s0,$t0
		  sw $s1, 0($t0) #Site[n]=i;
		  addi $sp,$sp,-4#���ù���ǰ����$ra
		  sw $ra,0($sp)
	      jal valid
	      lw $ra,0($sp)
	      addi $sp,$sp,4#������ջ����ͬ
	      beq $v0,0,queen_lp2
queen_rc: addi $sp,$sp,-12#������Valid(n)==Trueִ�еĴ��룬�ݹ����Queen
	      sw $ra,8($sp)#�뱣��$a0-$a2,$s1,$ra��$s1�ɱ������߱�����$a0���ǼӼ�1��ȥsw,lw
	      sw $a2,4($sp)
	      #sw $a0,0($sp)
	      addi $a0,$a0,1
	      jal queen
	      lw $ra,8($sp)
		  lw $a2,4($sp)
	      addi $a0,$a0,-1
	      #lw $a0,0($sp)#�ĳɼ�1,��ʵ����ָ��ȥ������԰������4��8�ĳ�0��4����Сջ�Ĵ�С
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
		syscall		#readint,�洢��v0��
		move    $a0,$zero#����Queen����
		move    $a1,$v0
		move    $a2,$zero#iCount����0���ڴ˺󲻱����ò����޸ģ����Ե���
		jal queen
		move $a0,$v0
		li $v0,1
		syscall #print int
		li	$v0, 10
		syscall			# exit





