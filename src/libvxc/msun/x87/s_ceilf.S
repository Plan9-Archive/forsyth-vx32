/*
 * Written by J.T. Conklin <jtc@netbsd.org>.
 * Public domain.
 */

#include <asm.h>

ENTRY(ceilf)
	pushl	%ebp
	movl	%esp,%ebp
	subl	$8,%esp

	fstcw	-12(%ebp)		/* store fpu control word */
	movw	-12(%ebp),%dx
	orw	$0x0800,%dx		/* round towards +oo */
	andw	$0xfbff,%dx
	movw	%dx,-16(%ebp)
	fldcw	-16(%ebp)		/* load modfied control word */

	flds	8(%ebp);		/* round */
	frndint

	fldcw	-12(%ebp)		/* restore original control word */

	leave
	ret
