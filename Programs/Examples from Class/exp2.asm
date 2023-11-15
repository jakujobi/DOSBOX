			;; the algorithm
			x = 0
			two_to_x = 1
			while two_to_x <= number do
				multiply two_to_x by 2
				add 1 to x
			end while
			subtract 1 from x ;; the answer!
			
			;; modified code
			sub cx,cx	;fast way to set a register to 0
			;; xor cx,cx another way to set a register to 0
			mov ax,1
while_1:	cmp ax,number	
			jnle end_while_1
body_1:		;;mov bx,2 no longer needed!
			;;imul bx
			add ax,ax ; same as multiply by 2
			inc cx
			jmp while_1
end_while_1:
			dec cx ; cx holds the answer