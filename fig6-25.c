/* C test driver for assembly language procedure add5 */
/* author: R. Detmer */
/* date: 6/2013 */

int add5(int x1, int x2, int x3, int x4, int x5);
/* returns sum of arguments */

#include <stdio.h>

int main()
{
    int a=5;
    int b=7;
    int c=9;

    int sum;

    sum = add5(a, 6, b, 8, c);
    printf("The sum is %d\n", sum);
    return 0;
}