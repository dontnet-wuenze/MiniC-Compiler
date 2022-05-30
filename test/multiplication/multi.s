	.text
	.file	"main"
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
	subq	$32, %rsp
	leaq	-20(%rbp), %rsi
	leaq	-16(%rbp), %rdx
	movl	$.L_Const_String_, %edi
	xorl	%eax, %eax
	callq	scanf
	movl	$0, -8(%rbp)
	movl	$0, -4(%rbp)
	jmp	.LBB0_1
	.p2align	4, 0x90
.LBB0_5:                                # %afterLoop4
                                        #   in Loop: Header=BB0_1 Depth=1
	incl	-8(%rbp)
.LBB0_1:                                # %cond
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_3 Depth 2
	movl	-8(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jge	.LBB0_6
# %bb.2:                                # %loop
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	$0, -4(%rbp)
	.p2align	4, 0x90
.LBB0_3:                                # %cond2
                                        #   Parent Loop BB0_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-4(%rbp), %eax
	cmpl	-16(%rbp), %eax
	jge	.LBB0_5
# %bb.4:                                # %loop3
                                        #   in Loop: Header=BB0_3 Depth=2
	movl	-8(%rbp), %eax
	imull	-16(%rbp), %eax
	addl	-4(%rbp), %eax
	cltq
	leaq	.LA(,%rax,4), %rsi
	movl	$.L_Const_String_.1, %edi
	xorl	%eax, %eax
	callq	scanf
	incl	-4(%rbp)
	jmp	.LBB0_3
.LBB0_6:                                # %afterLoop
	leaq	-24(%rbp), %rsi
	leaq	-12(%rbp), %rdx
	movl	$.L_Const_String_.2, %edi
	xorl	%eax, %eax
	callq	scanf
	movl	$0, -8(%rbp)
	movl	$0, -4(%rbp)
	jmp	.LBB0_7
	.p2align	4, 0x90
.LBB0_11:                               # %afterLoop25
                                        #   in Loop: Header=BB0_7 Depth=1
	incl	-8(%rbp)
.LBB0_7:                                # %cond16
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_9 Depth 2
	movl	-8(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jge	.LBB0_12
# %bb.8:                                # %loop17
                                        #   in Loop: Header=BB0_7 Depth=1
	movl	$0, -4(%rbp)
	.p2align	4, 0x90
.LBB0_9:                                # %cond23
                                        #   Parent Loop BB0_7 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-4(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jge	.LBB0_11
# %bb.10:                               # %loop24
                                        #   in Loop: Header=BB0_9 Depth=2
	movl	-8(%rbp), %eax
	imull	-12(%rbp), %eax
	addl	-4(%rbp), %eax
	cltq
	leaq	.LB(,%rax,4), %rsi
	movl	$.L_Const_String_.3, %edi
	xorl	%eax, %eax
	callq	scanf
	incl	-4(%rbp)
	jmp	.LBB0_9
.LBB0_12:                               # %afterLoop18
	movl	-16(%rbp), %eax
	cmpl	-24(%rbp), %eax
	je	.LBB0_15
# %bb.13:                               # %if
	movl	$.L_Const_String_.4, %edi
	xorl	%eax, %eax
	callq	printf
.LBB0_14:                               # %afterLoop87
	movl	$0, -28(%rbp)
	movl	-28(%rbp), %eax
	movq	%rbp, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.LBB0_15:                               # %afterifonly
	.cfi_def_cfa %rbp, 16
	movl	$0, -8(%rbp)
	movl	$0, -4(%rbp)
	jmp	.LBB0_16
	.p2align	4, 0x90
.LBB0_29:                               # %afterLoop49
                                        #   in Loop: Header=BB0_16 Depth=1
	incl	-8(%rbp)
.LBB0_16:                               # %cond40
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_18 Depth 2
                                        #       Child Loop BB0_20 Depth 3
	movl	-8(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jge	.LBB0_23
# %bb.17:                               # %loop41
                                        #   in Loop: Header=BB0_16 Depth=1
	movl	$0, -4(%rbp)
	jmp	.LBB0_18
	.p2align	4, 0x90
.LBB0_22:                               # %afterLoop59
                                        #   in Loop: Header=BB0_18 Depth=2
	incl	-4(%rbp)
.LBB0_18:                               # %cond47
                                        #   Parent Loop BB0_16 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB0_20 Depth 3
	movl	-4(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jge	.LBB0_29
# %bb.19:                               # %loop48
                                        #   in Loop: Header=BB0_18 Depth=2
	movl	-8(%rbp), %eax
	imull	-12(%rbp), %eax
	addl	-4(%rbp), %eax
	cltq
	movl	$0, .LC(,%rax,4)
	movq	%rsp, %rcx
	leaq	-16(%rcx), %rax
	movq	%rax, %rsp
	movl	$0, -16(%rcx)
	.p2align	4, 0x90
.LBB0_20:                               # %cond57
                                        #   Parent Loop BB0_16 Depth=1
                                        #     Parent Loop BB0_18 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movl	(%rax), %ecx
	cmpl	-16(%rbp), %ecx
	jge	.LBB0_22
# %bb.21:                               # %loop58
                                        #   in Loop: Header=BB0_20 Depth=3
	movl	-8(%rbp), %ecx
	movl	-12(%rbp), %edx
	movl	%ecx, %esi
	imull	%edx, %esi
	movl	-4(%rbp), %edi
	addl	%edi, %esi
	movslq	%esi, %r8
	imull	-16(%rbp), %ecx
	movl	(%rax), %esi
	addl	%esi, %ecx
	movslq	%ecx, %rcx
	movl	.LA(,%rcx,4), %ecx
	imull	%edx, %esi
	addl	%edi, %esi
	movslq	%esi, %rdx
	imull	.LB(,%rdx,4), %ecx
	addl	%ecx, .LC(,%r8,4)
	incl	(%rax)
	jmp	.LBB0_20
.LBB0_23:                               # %afterLoop42
	movl	$0, -8(%rbp)
	jmp	.LBB0_24
	.p2align	4, 0x90
.LBB0_28:                               # %afterLoop94
                                        #   in Loop: Header=BB0_24 Depth=1
	movl	$.L_Const_String_.6, %edi
	xorl	%eax, %eax
	callq	printf
	incl	-8(%rbp)
.LBB0_24:                               # %cond85
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_26 Depth 2
	movl	-8(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jge	.LBB0_14
# %bb.25:                               # %loop86
                                        #   in Loop: Header=BB0_24 Depth=1
	movl	$0, -4(%rbp)
	.p2align	4, 0x90
.LBB0_26:                               # %cond92
                                        #   Parent Loop BB0_24 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-4(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jge	.LBB0_28
# %bb.27:                               # %loop93
                                        #   in Loop: Header=BB0_26 Depth=2
	movl	-8(%rbp), %eax
	imull	-12(%rbp), %eax
	addl	-4(%rbp), %eax
	cltq
	movl	.LC(,%rax,4), %esi
	movl	$.L_Const_String_.5, %edi
	xorl	%eax, %eax
	callq	printf
	incl	-4(%rbp)
	jmp	.LBB0_26
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.type	.LA,@object             # @A
	.local	.LA
	.comm	.LA,800000,16
	.type	.LB,@object             # @B
	.local	.LB
	.comm	.LB,800000,16
	.type	.LC,@object             # @C
	.local	.LC
	.comm	.LC,800000,16
	.type	.Linput,@object         # @input
	.local	.Linput
	.comm	.Linput,100000,16
	.type	.L_Const_String_,@object # @_Const_String_
	.section	.rodata,"a",@progbits
.L_Const_String_:
	.asciz	"%d %d\n"
	.size	.L_Const_String_, 7

	.type	.L_Const_String_.1,@object # @_Const_String_.1
.L_Const_String_.1:
	.asciz	"%d"
	.size	.L_Const_String_.1, 3

	.type	.L_Const_String_.2,@object # @_Const_String_.2
.L_Const_String_.2:
	.asciz	"%d %d"
	.size	.L_Const_String_.2, 6

	.type	.L_Const_String_.3,@object # @_Const_String_.3
.L_Const_String_.3:
	.asciz	"%d"
	.size	.L_Const_String_.3, 3

	.type	.L_Const_String_.4,@object # @_Const_String_.4
	.p2align	4
.L_Const_String_.4:
	.asciz	"Incompatible Dimensions\n"
	.size	.L_Const_String_.4, 25

	.type	.L_Const_String_.5,@object # @_Const_String_.5
.L_Const_String_.5:
	.asciz	"%10d"
	.size	.L_Const_String_.5, 5

	.type	.L_Const_String_.6,@object # @_Const_String_.6
.L_Const_String_.6:
	.asciz	"\n"
	.size	.L_Const_String_.6, 2

	.section	".note.GNU-stack","",@progbits
