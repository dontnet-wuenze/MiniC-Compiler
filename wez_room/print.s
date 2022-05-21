	.text
	.file	"main"
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	$10, 4(%rsp)
	movl	$.L_Const_String_, %edi
	movl	$10, %esi
	xorl	%eax, %eax
	callq	printf
	movl	4(%rsp), %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.type	.L_Const_String_,@object # @_Const_String_
	.section	.rodata,"a",@progbits
.L_Const_String_:
	.asciz	"%d\\n"
	.size	.L_Const_String_, 5

	.section	".note.GNU-stack","",@progbits
