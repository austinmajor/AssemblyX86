; load values on floating point stack

.586
.MODEL FLAT
.STACK  4096

.DATA
two      DWORD  2
three    DWORD  3
fpValue  REAL4  10.0
intValue DWORD  20

.CODE
main     PROC
         finit             ; initialize fp stack
         fild    three     ; test fp load instructions
         fild    two
         fld1
         fld     fpValue
         fld     st(2)
         fldz
         fldpi

         mov    eax, 0
         ret

main     ENDP
END