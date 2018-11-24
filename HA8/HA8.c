//my version
#include <stdio.h>
int gcd(int a, int b);
int main()
{
   int a, b;
   printf("Enter a: ");
   scanf("%d", &a);

   printf("Enter b: ");
   scanf("%d", &b);

   printf("G.C.D of %d and %d is %d.", a, b, gcd(a,b));
   return 0;
}

int gcd(int a, int b)
{
    if (a > b)
       return gcd(a - b, b);

    if (a < b)
       return gcd(a, b - a);

  return a;
}

