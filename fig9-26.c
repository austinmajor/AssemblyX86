/* C program to provide I/O for quadratic equation solver */
/* author: R. Detmer */
/* date: 7/2013 */

#include <stdio.h>

void roots(float a, float b, float c, float* x1, float* x2);
/* find roots of quadratic equation */

int main()
{
    float a, b, c;
    float root1, root2;

    printf("please enter coefficients: ");
    scanf("%f %f %f", &a, &b, &c); 
    roots(a, b, c, &root1, &root2);
    printf("\nroot 1 %f\nroot 2 %f\n", root1, root2);
    return 0;
}