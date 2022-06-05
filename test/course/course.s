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
	pushq	%r14
	pushq	%rbx
	subq	$32, %rsp
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	movl	$0, -36(%rbp)
	movl	$0, -20(%rbp)
	movl	$0, -28(%rbp)
	movl	$0, -24(%rbp)
	movl	$0, -32(%rbp)
	.p2align	4, 0x90
.LBB0_1:                                # %cond
                                        # =>This Inner Loop Header: Depth=1
	imull	$1000, -32(%rbp), %eax  # imm = 0x3E8
	cltq
	leaq	.Lcourse_info(%rax), %rdi
	xorl	%eax, %eax
	callq	gets
	imull	$1000, -32(%rbp), %eax  # imm = 0x3E8
	cltq
	cmpb	$0, .Lcourse_info(%rax)
	je	.LBB0_2
# %bb.57:                               # %afterifonly
                                        #   in Loop: Header=BB0_1 Depth=1
	incl	-32(%rbp)
	jmp	.LBB0_1
.LBB0_2:                                # %afterLoop
	movq	%rsp, %rax
	leaq	-16(%rax), %r14
	movq	%r14, %rsp
	movl	$0, -16(%rax)
	jmp	.LBB0_3
	.p2align	4, 0x90
.LBB0_22:                               # %afterifonly129
                                        #   in Loop: Header=BB0_3 Depth=1
	incl	(%r14)
.LBB0_3:                                # %cond3
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_5 Depth 2
                                        #     Child Loop BB0_10 Depth 2
	movl	(%r14), %eax
	cmpl	-32(%rbp), %eax
	jge	.LBB0_23
# %bb.4:                                # %loop4
                                        #   in Loop: Header=BB0_3 Depth=1
	movq	%rsp, %rax
	leaq	-16(%rax), %rdx
	movq	%rdx, %rsp
	imull	$1000, (%r14), %ecx     # imm = 0x3E8
	movl	%ecx, -16(%rax)
	movq	%rsp, %rax
	leaq	-16(%rax), %rcx
	movq	%rcx, %rsp
	imull	$1000, (%r14), %esi     # imm = 0x3E8
	movl	%esi, -16(%rax)
	jmp	.LBB0_5
	.p2align	4, 0x90
.LBB0_8:                                # %afterifonly20
                                        #   in Loop: Header=BB0_5 Depth=2
	incl	(%rdx)
.LBB0_5:                                # %cond11
                                        #   Parent Loop BB0_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	(%rdx), %rax
	cmpb	$124, .Lcourse_info(%rax)
	je	.LBB0_9
# %bb.6:                                # %loop12
                                        #   in Loop: Header=BB0_5 Depth=2
	movslq	(%rdx), %rax
	cmpb	$99, .Lcourse_info(%rax)
	je	.LBB0_8
# %bb.7:                                # %if19
                                        #   in Loop: Header=BB0_5 Depth=2
	movslq	(%r14), %rax
	movl	.Lcourse_id(,%rax,4), %esi
	leal	(%rsi,%rsi,4), %esi
	movslq	(%rdx), %rdi
	movzbl	.Lcourse_info(%rdi), %edi
	leal	-48(%rdi,%rsi,2), %esi
	movl	%esi, .Lcourse_id(,%rax,4)
	jmp	.LBB0_8
	.p2align	4, 0x90
.LBB0_9:                                # %afterLoop13
                                        #   in Loop: Header=BB0_3 Depth=1
	incl	(%rdx)
	movq	%rsp, %rsi
	leaq	-16(%rsi), %rax
	movq	%rax, %rsp
	movslq	(%rdx), %rdi
	movb	.Lcourse_info(%rdi), %bl
	addb	$-48, %bl
	movzbl	%bl, %edi
	movl	%edi, -16(%rsi)
	addl	%edi, -36(%rbp)
	addl	$2, (%rdx)
	.p2align	4, 0x90
.LBB0_10:                               # %cond44
                                        #   Parent Loop BB0_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	(%rdx), %rsi
	cmpb	$124, .Lcourse_info(%rsi)
	je	.LBB0_12
# %bb.11:                               # %loop45
                                        #   in Loop: Header=BB0_10 Depth=2
	movslq	(%rcx), %rsi
	movslq	(%rdx), %rdi
	movzbl	.Lcourse_info(%rdi), %ebx
	movb	%bl, .Lpre_course(%rsi)
	incl	(%rcx)
	incl	(%rdx)
	jmp	.LBB0_10
	.p2align	4, 0x90
.LBB0_12:                               # %afterLoop46
                                        #   in Loop: Header=BB0_3 Depth=1
	movslq	(%rcx), %rcx
	movb	$0, .Lpre_course(%rcx)
	movq	%rsp, %rsi
	leaq	-16(%rsi), %rcx
	movq	%rcx, %rsp
	movl	(%rdx), %edx
	incl	%edx
	movslq	%edx, %rdx
	movb	.Lcourse_info(%rdx), %dl
	movb	%dl, -16(%rsi)
	cmpb	$65, %dl
	jne	.LBB0_14
# %bb.13:                               # %if64
                                        #   in Loop: Header=BB0_3 Depth=1
	movl	(%rax), %edx
	shll	$2, %edx
	xorps	%xmm0, %xmm0
	cvtsi2ss	%edx, %xmm0
	addss	-20(%rbp), %xmm0
	movss	%xmm0, -20(%rbp)
	movl	(%rax), %edx
	addl	%edx, -24(%rbp)
	movl	(%rax), %edx
	addl	%edx, -28(%rbp)
	movslq	(%r14), %rdx
	movslq	.Lcourse_id(,%rdx,4), %rdx
	movl	$1, .Lpass_course(,%rdx,4)
.LBB0_14:                               # %afterifonly65
                                        #   in Loop: Header=BB0_3 Depth=1
	cmpb	$66, (%rcx)
	jne	.LBB0_16
# %bb.15:                               # %if80
                                        #   in Loop: Header=BB0_3 Depth=1
	movl	(%rax), %edx
	leal	(%rdx,%rdx,2), %edx
	xorps	%xmm0, %xmm0
	cvtsi2ss	%edx, %xmm0
	addss	-20(%rbp), %xmm0
	movss	%xmm0, -20(%rbp)
	movl	(%rax), %edx
	addl	%edx, -24(%rbp)
	movl	(%rax), %edx
	addl	%edx, -28(%rbp)
	movslq	(%r14), %rdx
	movslq	.Lcourse_id(,%rdx,4), %rdx
	movl	$1, .Lpass_course(,%rdx,4)
.LBB0_16:                               # %afterifonly81
                                        #   in Loop: Header=BB0_3 Depth=1
	cmpb	$67, (%rcx)
	jne	.LBB0_18
# %bb.17:                               # %if96
                                        #   in Loop: Header=BB0_3 Depth=1
	movl	(%rax), %edx
	addl	%edx, %edx
	xorps	%xmm0, %xmm0
	cvtsi2ss	%edx, %xmm0
	addss	-20(%rbp), %xmm0
	movss	%xmm0, -20(%rbp)
	movl	(%rax), %edx
	addl	%edx, -24(%rbp)
	movl	(%rax), %edx
	addl	%edx, -28(%rbp)
	movslq	(%r14), %rdx
	movslq	.Lcourse_id(,%rdx,4), %rdx
	movl	$1, .Lpass_course(,%rdx,4)
.LBB0_18:                               # %afterifonly97
                                        #   in Loop: Header=BB0_3 Depth=1
	cmpb	$68, (%rcx)
	jne	.LBB0_20
# %bb.19:                               # %if112
                                        #   in Loop: Header=BB0_3 Depth=1
	xorps	%xmm0, %xmm0
	cvtsi2ssl	(%rax), %xmm0
	addss	-20(%rbp), %xmm0
	movss	%xmm0, -20(%rbp)
	movl	(%rax), %edx
	addl	%edx, -24(%rbp)
	movl	(%rax), %edx
	addl	%edx, -28(%rbp)
	movslq	(%r14), %rdx
	movslq	.Lcourse_id(,%rdx,4), %rdx
	movl	$1, .Lpass_course(,%rdx,4)
.LBB0_20:                               # %afterifonly113
                                        #   in Loop: Header=BB0_3 Depth=1
	cmpb	$70, (%rcx)
	jne	.LBB0_22
# %bb.21:                               # %if128
                                        #   in Loop: Header=BB0_3 Depth=1
	movl	(%rax), %eax
	addl	%eax, -24(%rbp)
	jmp	.LBB0_22
.LBB0_23:                               # %afterLoop5
	cmpl	$0, -24(%rbp)
	je	.LBB0_25
# %bb.24:                               # %if136
	movss	-20(%rbp), %xmm0        # xmm0 = mem[0],zero,zero,zero
	cvtsi2ssl	-24(%rbp), %xmm1
	divss	%xmm1, %xmm0
	movss	%xmm0, -20(%rbp)
.LBB0_25:                               # %afterifonly137
	movss	-20(%rbp), %xmm0        # xmm0 = mem[0],zero,zero,zero
	cvtss2sd	%xmm0, %xmm0
	movl	$.L_Const_String_, %edi
	movb	$1, %al
	callq	printf
	movl	-24(%rbp), %esi
	movl	$.L_Const_String_.1, %edi
	xorl	%eax, %eax
	callq	printf
	movl	-28(%rbp), %esi
	movl	$.L_Const_String_.2, %edi
	xorl	%eax, %eax
	callq	printf
	movq	%rsp, %rbx
	leaq	-16(%rbx), %rsp
	movl	-36(%rbp), %esi
	subl	-28(%rbp), %esi
	movl	%esi, -16(%rbx)
	movl	$.L_Const_String_.3, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L_Const_String_.4, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L_Const_String_.5, %edi
	xorl	%eax, %eax
	callq	printf
	cmpl	$0, -16(%rbx)
	jne	.LBB0_28
# %bb.26:                               # %if155
	movl	$.L_Const_String_.6, %edi
	xorl	%eax, %eax
	callq	printf
.LBB0_27:                               # %afterLoop163
	movl	$0, -40(%rbp)
	movl	-40(%rbp), %eax
	leaq	-16(%rbp), %rsp
	popq	%rbx
	popq	%r14
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.LBB0_28:                               # %afterifonly156
	.cfi_def_cfa %rbp, 16
	movl	$0, (%r14)
	jmp	.LBB0_29
	.p2align	4, 0x90
.LBB0_34:                               # %afterifonly169
                                        #   in Loop: Header=BB0_29 Depth=1
	incl	(%r14)
.LBB0_29:                               # %cond161
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_36 Depth 2
                                        #     Child Loop BB0_54 Depth 2
	movl	(%r14), %eax
	cmpl	-32(%rbp), %eax
	jge	.LBB0_27
# %bb.30:                               # %loop162
                                        #   in Loop: Header=BB0_29 Depth=1
	movslq	(%r14), %rax
	movslq	.Lcourse_id(,%rax,4), %rax
	cmpl	$0, .Lpass_course(,%rax,4)
	jne	.LBB0_34
# %bb.31:                               # %if168
                                        #   in Loop: Header=BB0_29 Depth=1
	movq	%rsp, %rcx
	leaq	-16(%rcx), %rax
	movq	%rax, %rsp
	movl	$0, -16(%rcx)
	imull	$1000, (%r14), %ecx     # imm = 0x3E8
	movslq	%ecx, %rcx
	cmpb	$0, .Lpre_course(%rcx)
	je	.LBB0_32
# %bb.35:                               # %else
                                        #   in Loop: Header=BB0_29 Depth=1
	movq	%rsp, %rcx
	leaq	-16(%rcx), %rdx
	movq	%rdx, %rsp
	movl	$0, -16(%rcx)
	movq	%rsp, %rsi
	leaq	-16(%rsi), %rcx
	movq	%rcx, %rsp
	movl	$1, -16(%rsi)
	movq	%rsp, %rdi
	leaq	-16(%rdi), %rsi
	movq	%rsi, %rsp
	imull	$1000, (%r14), %ebx     # imm = 0x3E8
	movl	%ebx, -16(%rdi)
	jmp	.LBB0_36
	.p2align	4, 0x90
.LBB0_52:                               # %afterifonly243
                                        #   in Loop: Header=BB0_36 Depth=2
	incl	(%rsi)
.LBB0_36:                               # %cond185
                                        #   Parent Loop BB0_29 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	(%rsi), %rdi
	cmpb	$0, .Lpre_course(%rdi)
	je	.LBB0_37
# %bb.40:                               # %afterifonly189
                                        #   in Loop: Header=BB0_36 Depth=2
	movslq	(%rsi), %rdi
	cmpb	$59, .Lpre_course(%rdi)
	jne	.LBB0_46
# %bb.41:                               # %if207
                                        #   in Loop: Header=BB0_36 Depth=2
	movslq	(%rdx), %rdi
	cmpl	$0, .Lpass_course(,%rdi,4)
	jne	.LBB0_43
# %bb.42:                               # %if214
                                        #   in Loop: Header=BB0_36 Depth=2
	movl	$0, (%rcx)
.LBB0_43:                               # %afterifonly215
                                        #   in Loop: Header=BB0_36 Depth=2
	cmpl	$1, (%rcx)
	jne	.LBB0_45
# %bb.44:                               # %if221
                                        #   in Loop: Header=BB0_36 Depth=2
	movl	$1, (%rax)
.LBB0_45:                               # %afterifonly222
                                        #   in Loop: Header=BB0_36 Depth=2
	movl	$0, (%rdx)
	movl	$1, (%rcx)
	incl	(%rsi)
.LBB0_46:                               # %afterifonly208
                                        #   in Loop: Header=BB0_36 Depth=2
	movslq	(%rsi), %rdi
	cmpb	$44, .Lpre_course(%rdi)
	jne	.LBB0_50
# %bb.47:                               # %if227
                                        #   in Loop: Header=BB0_36 Depth=2
	movslq	(%rdx), %rdi
	cmpl	$0, .Lpass_course(,%rdi,4)
	jne	.LBB0_49
# %bb.48:                               # %if234
                                        #   in Loop: Header=BB0_36 Depth=2
	movl	$0, (%rcx)
.LBB0_49:                               # %afterifonly235
                                        #   in Loop: Header=BB0_36 Depth=2
	movl	$0, (%rdx)
	incl	(%rsi)
.LBB0_50:                               # %afterifonly228
                                        #   in Loop: Header=BB0_36 Depth=2
	movslq	(%rsi), %rdi
	cmpb	$99, .Lpre_course(%rdi)
	je	.LBB0_52
# %bb.51:                               # %if242
                                        #   in Loop: Header=BB0_36 Depth=2
	movl	(%rdx), %edi
	leal	(%rdi,%rdi,4), %edi
	movslq	(%rsi), %rbx
	movzbl	.Lpre_course(%rbx), %ebx
	leal	-48(%rbx,%rdi,2), %edi
	movl	%edi, (%rdx)
	jmp	.LBB0_52
	.p2align	4, 0x90
.LBB0_37:                               # %if188
                                        #   in Loop: Header=BB0_29 Depth=1
	movslq	(%rdx), %rdx
	cmpl	$0, .Lpass_course(,%rdx,4)
	jne	.LBB0_39
# %bb.38:                               # %if195
                                        #   in Loop: Header=BB0_29 Depth=1
	movl	$0, (%rcx)
.LBB0_39:                               # %afterifonly196
                                        #   in Loop: Header=BB0_29 Depth=1
	cmpl	$1, (%rcx)
	jne	.LBB0_33
.LBB0_32:                               # %if177
                                        #   in Loop: Header=BB0_29 Depth=1
	movl	$1, (%rax)
.LBB0_33:                               # %afterifelse
                                        #   in Loop: Header=BB0_29 Depth=1
	cmpl	$1, (%rax)
	jne	.LBB0_34
# %bb.53:                               # %if255
                                        #   in Loop: Header=BB0_29 Depth=1
	movl	$.L_Const_String_.7, %edi
	xorl	%eax, %eax
	callq	printf
	movq	%rsp, %rax
	leaq	-16(%rax), %rbx
	movq	%rbx, %rsp
	imull	$1000, (%r14), %ecx     # imm = 0x3E8
	movl	%ecx, -16(%rax)
	.p2align	4, 0x90
.LBB0_54:                               # %cond262
                                        #   Parent Loop BB0_29 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	(%rbx), %rax
	cmpb	$124, .Lcourse_info(%rax)
	je	.LBB0_56
# %bb.55:                               # %loop263
                                        #   in Loop: Header=BB0_54 Depth=2
	movslq	(%rbx), %rax
	movzbl	.Lcourse_info(%rax), %esi
	movl	$.L_Const_String_.8, %edi
	xorl	%eax, %eax
	callq	printf
	incl	(%rbx)
	jmp	.LBB0_54
	.p2align	4, 0x90
.LBB0_56:                               # %afterLoop264
                                        #   in Loop: Header=BB0_29 Depth=1
	movl	$.L_Const_String_.9, %edi
	xorl	%eax, %eax
	callq	printf
	incl	(%r14)
	jmp	.LBB0_29
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.type	.Lcourse_info,@object   # @course_info
	.local	.Lcourse_info
	.comm	.Lcourse_info,1000000,16
	.type	.Lpre_course,@object    # @pre_course
	.local	.Lpre_course
	.comm	.Lpre_course,1000000,16
	.type	.Lpass_course,@object   # @pass_course
	.local	.Lpass_course
	.comm	.Lpass_course,44400,16
	.type	.Lcourse_id,@object     # @course_id
	.local	.Lcourse_id
	.comm	.Lcourse_id,44400,16
	.type	.L_Const_String_,@object # @_Const_String_
	.section	.rodata,"a",@progbits
.L_Const_String_:
	.asciz	"GPA: %.1f\n"
	.size	.L_Const_String_, 11

	.type	.L_Const_String_.1,@object # @_Const_String_.1
	.p2align	4
.L_Const_String_.1:
	.asciz	"Hours Attempted: %d\n"
	.size	.L_Const_String_.1, 21

	.type	.L_Const_String_.2,@object # @_Const_String_.2
	.p2align	4
.L_Const_String_.2:
	.asciz	"Hours Completed: %d\n"
	.size	.L_Const_String_.2, 21

	.type	.L_Const_String_.3,@object # @_Const_String_.3
	.p2align	4
.L_Const_String_.3:
	.asciz	"Credits Remaining: %d\n"
	.size	.L_Const_String_.3, 23

	.type	.L_Const_String_.4,@object # @_Const_String_.4
.L_Const_String_.4:
	.asciz	"\n"
	.size	.L_Const_String_.4, 2

	.type	.L_Const_String_.5,@object # @_Const_String_.5
	.p2align	4
.L_Const_String_.5:
	.asciz	"Possible Courses to Take Next\n"
	.size	.L_Const_String_.5, 31

	.type	.L_Const_String_.6,@object # @_Const_String_.6
	.p2align	4
.L_Const_String_.6:
	.asciz	"  None - Congratulations!\n"
	.size	.L_Const_String_.6, 27

	.type	.L_Const_String_.7,@object # @_Const_String_.7
.L_Const_String_.7:
	.asciz	"  "
	.size	.L_Const_String_.7, 3

	.type	.L_Const_String_.8,@object # @_Const_String_.8
.L_Const_String_.8:
	.asciz	"%c"
	.size	.L_Const_String_.8, 3

	.type	.L_Const_String_.9,@object # @_Const_String_.9
.L_Const_String_.9:
	.asciz	"\n"
	.size	.L_Const_String_.9, 2

	.section	".note.GNU-stack","",@progbits
