#include <stdio.h>
#include <conio.h>
  
int main(){
    int inputArray[100], elementCount, index, counter=0;
      
    printf("Enter Number of Elements in Array\n");
    scanf("%d", &elementCount);
    printf("Enter %d numbers \n", elementCount);
     
    /* Read array elements */
    for(index = 0; index < elementCount; index++){
        scanf("%d", &inputArray[index]);
    }
        
    /* Iterate form index 0 to elementCount-1 and 
 check for negative numbers */
    for(index = 0; index < elementCount; index++){
        if(inputArray[index] < 0) {
            counter++;
        }
    }
     
    printf("Number of Negative Elements in Array : %d\n", counter);
    getch();
    return 0;
}