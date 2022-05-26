	.text
	.file	"main"
	.globl	quicksort               # -- Begin function quicksort
	.p2align	4, 0x90
	.type	quicksort,@function
quicksort:                              # @quicksort
	.cfi_startproc
# %bb.0:                                # %entry
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movq	%rdi, 16(%rsp)
	movl	%esi, 32(%rsp)
	movl	%edx, 28(%rsp)
	movl	%esi, 12(%rsp)
	movl	%edx, 8(%rsp)
	addl	%edx, %esi
	movl	%esi, %eax
	shrl	$31, %eax
	addl	%esi, %eax
	sarl	%eax
	cltq
	movl	(%rdi,%rax,4), %eax
	movl	%eax, 24(%rsp)
	.p2align	4, 0x90
.LBB0_1:                                # %cond
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_7 Depth 2
                                        #     Child Loop BB0_9 Depth 2
	movl	12(%rsp), %eax
	cmpl	8(%rsp), %eax
	jg	.LBB0_2
	.p2align	4, 0x90
.LBB0_7:                                # %cond9
                                        #   Parent Loop BB0_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	12(%rsp), %rax
	movq	16(%rsp), %rcx
	movl	(%rcx,%rax,4), %eax
	cmpl	24(%rsp), %eax
	jge	.LBB0_9
# %bb.8:                                # %loop10
                                        #   in Loop: Header=BB0_7 Depth=2
	incl	12(%rsp)
	jmp	.LBB0_7
	.p2align	4, 0x90
.LBB0_10:                               # %loop20
                                        #   in Loop: Header=BB0_9 Depth=2
	decl	8(%rsp)
.LBB0_9:                                # %cond19
                                        #   Parent Loop BB0_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	24(%rsp), %eax
	movslq	8(%rsp), %rcx
	movq	16(%rsp), %rdx
	cmpl	(%rdx,%rcx,4), %eax
	jl	.LBB0_10
# %bb.11:                               # %afterLoop21
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	12(%rsp), %eax
	cmpl	8(%rsp), %eax
	jg	.LBB0_1
# %bb.12:                               # %if
                                        #   in Loop: Header=BB0_1 Depth=1
	movq	16(%rsp), %rax
	movslq	12(%rsp), %rcx
	movl	(%rax,%rcx,4), %edx
	movl	%edx, 36(%rsp)
	movslq	8(%rsp), %rdx
	movl	(%rax,%rdx,4), %edx
	movl	%edx, (%rax,%rcx,4)
	movslq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movl	36(%rsp), %edx
	movl	%edx, (%rcx,%rax,4)
	incl	12(%rsp)
	decl	8(%rsp)
	jmp	.LBB0_1
.LBB0_2:                                # %afterLoop
	movl	32(%rsp), %eax
	cmpl	8(%rsp), %eax
	jge	.LBB0_4
# %bb.3:                                # %if45
	movq	16(%rsp), %rdi
	movl	32(%rsp), %esi
	movl	8(%rsp), %edx
	callq	quicksort
.LBB0_4:                                # %afterifonly46
	movl	12(%rsp), %eax
	cmpl	28(%rsp), %eax
	jge	.LBB0_6
# %bb.5:                                # %if54
	movq	16(%rsp), %rdi
	movl	12(%rsp), %esi
	movl	28(%rsp), %edx
	callq	quicksort
.LBB0_6:                                # %afterifonly55
	addq	$40, %rsp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end0:
	.size	quicksort, .Lfunc_end0-quicksort
	.cfi_endproc
                                        # -- End function
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$64, %rsp
	leaq	-8(%rbp), %rsi
	movl	$.L_Const_String_, %edi
	xorl	%eax, %eax
	callq	scanf
	movl	$0, -4(%rbp)
	.p2align	4, 0x90
.LBB1_1:                                # %cond
                                        # =>This Inner Loop Header: Depth=1
	movl	-4(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jge	.LBB1_3
# %bb.2:                                # %loop
                                        #   in Loop: Header=BB1_1 Depth=1
	movslq	-4(%rbp), %rax
	leaq	-52(%rbp,%rax,4), %rsi
	movl	$.L_Const_String_.1, %edi
	xorl	%eax, %eax
	callq	scanf
	incl	-4(%rbp)
	jmp	.LBB1_1
.LBB1_3:                                # %afterLoop
	movq	%rsp, %rax
	leaq	-16(%rax), %rsp
	movl	$0, -16(%rax)
	movq	%rsp, %rcx
	leaq	-16(%rcx), %rsp
	movl	-8(%rbp), %edx
	decl	%edx
	movl	%edx, -16(%rcx)
	movl	-16(%rax), %esi
	leaq	-52(%rbp), %rdi
	callq	quicksort
	movl	$0, -4(%rbp)
	.p2align	4, 0x90
.LBB1_4:                                # %cond8
                                        # =>This Inner Loop Header: Depth=1
	movl	-4(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jge	.LBB1_6
# %bb.5:                                # %loop9
                                        #   in Loop: Header=BB1_4 Depth=1
	movslq	-4(%rbp), %rax
	movl	-52(%rbp,%rax,4), %esi
	movl	$.L_Const_String_.2, %edi
	xorl	%eax, %eax
	callq	printf
	incl	-4(%rbp)
	jmp	.LBB1_4
.LBB1_6:                                # %afterLoop10
	movl	$0, -12(%rbp)
	xorl	%eax, %eax
	movq	%rbp, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
	.cfi_endproc
                                        # -- End function
	.type	.LA,@object             # @A
	.local	.LA
	.comm	.LA,800000,16
	.type	.L_Const_String_,@object # @_Const_String_
	.section	.rodata,"a",@progbits
.L_Const_String_:
	.asciz	"%d"
	.size	.L_Const_String_, 3

	.type	.L_Const_String_.1,@object # @_Const_String_.1
.L_Const_String_.1:
	.asciz	"%d"
	.size	.L_Const_String_.1, 3

	.type	.L_Const_String_.2,@object # @_Const_String_.2
.L_Const_String_.2:
	.asciz	"%d\n"
	.size	.L_Const_String_.2, 4

	.section	".note.GNU-stack","",@progbits
