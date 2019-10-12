/******************************************************************************
* file: arm_lab_cs18m524_assignment_3
* author: Ananya Barat
* Guide: Prof. Madhumutyam IITM, PACE
******************************************************************************/

/*
  This is the starter code for assignment 3
  */

  @ BSS section
      .bss


  
	  
@ DATA SECTION
      .data
data_start: .word 0x205A15E3 ;
            .word 0x256C8700 ;
data_end:   .word 0x295468F2 ;

NUM: .word 0x00;
WEIGHT : .word 0x00;
	
@ TEXT section
      .text

.globl _main

	  LDR R4 , =data_start
	  LDR R6 , =data_end
	  LDR R5 , [R4]  	@to traverse through the array
	  LDR R3 , [R4]  	@will store the max weight element
	  MOV R8 , #0x00 	@will store the max weight
	  MOV R2 , #0x00 	@holds weight of the current element
	  LDR R7 , [R6]  	@will store the last element
	  
LOOP: 
	  CMP R2, R8
	  BGT Update_Max 	@if weight of current element > max_weight, update max_weight

/*Numbers are traversed here */
	  
NEXT: 
	  LDR R5, [R4], #4
	  MOV R9, R5 		@ introducing duplicate to retain the value
	  MOV R0, R5		@ We will process R0 bit by bit
	  MOV R1, #0x20     @length of every elemnt is 32 bits
	  MOV R2 , #0x00    @weight of the element is initialized to zero
	  
/*Weight of every element is calculated here */

Count: 
	  MOVS R0 , R0 , RRX @right shift by 1 bit
	  ADDCS R2, R2, #0x1 @if carry flag is set add 1 to R2
	  SUBS R1, R1 , #0x1
	  BNE Count
	  
	  
	  CMP R5, R7  @check if we reached the last element
	  BNE LOOP
	  B Check     @if it is the last element check if it is the max_weight element

/* Swapping current element and it's weight with max element and it's weight */

Update_Max:
	  MOV R8, R2 
	  MOV R3, R9
	  B NEXT
	  
/*For the last element */
	  
Update_Max1:
	  MOV R8, R2
	  MOV R3, R9
	  B exit
	  
/*Check if the last element is the max weight element */	  
Check:
	  CMP R2, R8
	  BGT Update_Max1
	  B exit
	  
exit: 
	  LDR R10, =NUM
	  STR R3, [R10] @The number with the max weight is stored in the memory location labelled NUM
	  LDR R11, =WEIGHT
	  STR R8 , [R11] @The max weight is tored in the memory location labelled WEIGHT
@end 

	  

	  

 