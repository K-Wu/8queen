.data 0x10000000
.word -3,2,1,15,-1,8
.text
main:  ori  $a0,$0,0x1000
	   sll  $a0,$a0,16 #$a0�洢data��ַҲ����������ʼ��ַ
	   addi $a1,$0,6  #��������6����
#sort������������v��ʼ��ַ�洢��$a0,n�洢��$a1
sort:  addi $sp, $sp, -20
       sw   $ra, 16($sp)
       sw   $s3, 12($sp)
       sw   $s2, 8($sp)
       sw   $s1, 4($sp)
       sw   $s0, 0($sp)
	   move $s0, $zero    #ѭ����ʼ��
loopbody1: bge  $s0,$a1, exit1 #$a1�洢��ѭ������n��$s0Ϊ��ѭ������i
#��ѭ��ѭ����
	       addi $s1, $s0,-1 #$s1�洢��ѭ������j����ʼ��Ϊi-1
loopbody2: blt  $s1,0,loopbody1c
	       sll  $t1,$s1,2
	       add  $t1,$a0,$t1#����loopд��������v[j]��ַ����$t1
	       lw   $t0,0($t1)#$t0=v[j]
	       lw   $t2,4($t1)#$t2=v[j+1]
           bgt  $t0,$t2,loopbody1c#��ѭ����ֹ�ĵڶ�������
	       move $a3,$s1
	       jal  swap
	       addi $s1,$s1,-1
	       j    loopbody2
loopbody1c:addi $s0,$s0,1
	       j    loopbody1
swap:  sll  $t1, $a3, 2 #a3�洢����k��a0�洢v��ʼ��ַ
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
