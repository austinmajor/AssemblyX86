	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 10, 14
	.intel_syntax noprefix
	.globl	_main                   ## -- Begin function main
	.p2align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## %bb.0:
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset rbp, -16
	mov	rbp, rsp
	.cfi_def_cfa_register rbp
	sub	rsp, 48
	lea	rdi, [rip + L_.str]
	mov	dword ptr [rbp - 4], 0
	mov	al, 0
	call	_printf
	lea	rdi, [rip + L_.str.1]
	lea	rsi, [rbp - 8]
	mov	dword ptr [rbp - 16], eax ## 4-byte Spill
	mov	al, 0
	call	_scanf
	lea	rdi, [rip + L_.str.2]
	mov	dword ptr [rbp - 20], eax ## 4-byte Spill
	mov	al, 0
	call	_printf
	lea	rdi, [rip + L_.str.1]
	lea	rsi, [rbp - 12]
	mov	dword ptr [rbp - 24], eax ## 4-byte Spill
	mov	al, 0
	call	_scanf
	mov	esi, dword ptr [rbp - 8]
	mov	edx, dword ptr [rbp - 12]
	mov	edi, dword ptr [rbp - 8]
	mov	ecx, dword ptr [rbp - 12]
	mov	dword ptr [rbp - 28], esi ## 4-byte Spill
	mov	esi, ecx
	mov	dword ptr [rbp - 32], eax ## 4-byte Spill
	mov	dword ptr [rbp - 36], edx ## 4-byte Spill
	call	_gcd
	lea	rdi, [rip + L_.str.3]
	mov	esi, dword ptr [rbp - 28] ## 4-byte Reload
	mov	edx, dword ptr [rbp - 36] ## 4-byte Reload
	mov	ecx, eax
	mov	al, 0
	call	_printf
	xor	ecx, ecx
	mov	dword ptr [rbp - 40], eax ## 4-byte Spill
	mov	eax, ecx
	add	rsp, 48
	pop	rbp
	ret
	.cfi_endproc
                                        ## -- End function
	.globl	_gcd                    ## -- Begin function gcd
	.p2align	4, 0x90
_gcd:                                   ## @gcd
	.cfi_startproc
## %bb.0:
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset rbp, -16
	mov	rbp, rsp
	.cfi_def_cfa_register rbp
	sub	rsp, 16
	mov	dword ptr [rbp - 8], edi
	mov	dword ptr [rbp - 12], esi
	mov	esi, dword ptr [rbp - 8]
	cmp	esi, dword ptr [rbp - 12]
	jle	LBB1_2
## %bb.1:
	mov	eax, dword ptr [rbp - 8]
	sub	eax, dword ptr [rbp - 12]
	mov	esi, dword ptr [rbp - 12]
	mov	edi, eax
	call	_gcd
	mov	dword ptr [rbp - 4], eax
	jmp	LBB1_5
LBB1_2:
	mov	eax, dword ptr [rbp - 8]
	cmp	eax, dword ptr [rbp - 12]
	jge	LBB1_4
## %bb.3:
	mov	edi, dword ptr [rbp - 8]
	mov	eax, dword ptr [rbp - 12]
	sub	eax, dword ptr [rbp - 8]
	mov	esi, eax
	call	_gcd
	mov	dword ptr [rbp - 4], eax
	jmp	LBB1_5
LBB1_4:
	mov	eax, dword ptr [rbp - 8]
	mov	dword ptr [rbp - 4], eax
LBB1_5:
	mov	eax, dword ptr [rbp - 4]
	add	rsp, 16
	pop	rbp
	ret
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"Enter a: "

L_.str.1:                               ## @.str.1
	.asciz	"%d"

L_.str.2:                               ## @.str.2
	.asciz	"Enter b: "

L_.str.3:                               ## @.str.3
	.asciz	"G.C.D of %d and %d is %d."


.subsections_via_symbols
