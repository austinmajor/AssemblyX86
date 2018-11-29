//my version
#include <stdio.h>
int mymul(int a, int b);
int main() 
{
   int a, b;
   printf("Enter a: ");
   scanf("%d", &a);

   printf("Enter b: ");
   scanf("%d", &b);

   printf("The answer is %d.\n", mymul(a,b));
   return 0;
}

int mymul(int a, int b)
{
    if (b > 0)
       return mymul(a , b - 1) + a;

  return 0;
}