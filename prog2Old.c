#include<stdio.h>


void printArray(int*array,int size){
    int i ;
    printf ( " [ " ) ;
    for ( i = 0 ; i < size ; i ++)
        printf( "%d " , array[i] ) ;
    printf( " ]\n " ) ;
}

/*@	ensures \forall int i; 0 <= i <= size-1 ==> \result >=array[i];
*/
int findLargestNum(int *array,int size){
    int i ;
    int largestNum = -1;
    /*@ loop invariant \forall int k; 0 <= k < i ==> largestNum >= array[k];
    @ loop assigns i, largestNum;*/
    for(i=0;i<size;i++){
        if ( array[i] > largestNum )
            largestNum = array [ i ] ;
    }
    //@ assert \forall int k; 0 <= k <= size-1 ==> largestNum >= array[k];
    return largestNum ;
}
/*@ 	requires size>0;*/
//	ensures \forall int k; 1 <= k < size ==> *(array + (k - 1)) ≤ *(array + k);
void radixSort(int * array,int size){
    printf( " \n\nRunning Radix Sort on Unsorted List !\n\n " ) ;
    int i ;
    int semiSorted [ size ];
    int significantDigit = 1 ;
    int largestNum = findLargestNum(array,size);
    /*@ loop invariant \forall integer k2; 1 <= k2 < size ==> array[k2-1]%significantDigit <= array[k2]%significantDigit;
    @ loop assigns i,array;*/
    
    while ( largestNum / significantDigit> 0 ) {
        printf ( "Sorting : %d  place" , significantDigit) ;
        printArray ( array , size ) ;
        int bucket[10] = {0};
        // Counts the number of " keys " or digits that will go into each bucket
        for ( i = 0 ; i < size ; i ++)
            bucket [ ( array [ i ] / significantDigit) % 10]++;
        printArray(bucket,10);
        /*
         Add the count o f the previou s buckets ,
        ∗ Acquires the indexe safter the end o f each bucket location in the array
        ∗ Works similar to the count sort algorithm
        */
        
        /*@ loop invariant \forall int k; 1 <= k < i ==> bucket[k-1] <= bucket[k];
        @ loop assigns i,*bucket; */
        for(i=1;i<size;i++)
            bucket[i]+=bucket[i-1];
        printArray ( bucket , 10 ) ;

        // Use the bucket to fill a " semiSorted " array
        for(i=size-1;i>=0;i--){
            semiSorted[--bucket[(array[i]/significantDigit)%10]] = array[i];
                        printf("--");

            printArray(semiSorted,10);
        }
                printf("\n");

        for(i=0;i<size;i++)
            array [ i ] = semiSorted [ i ] ;
        // Move t o next significant digit
        
        printArray ( bucket , 10 ) ;
        significantDigit*=10;
    }
}

int main ( ) {
    printf( " \n\nRunning Radix Sort Example in C! \n " ) ;
    printf ( "−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−\n " ) ;
    int size = 12 ;
    int list[] = { 10 , 2 , 303 , 4021 , 293 , 1 , 0 , 429 , 480 , 92 , 2999 , 14 } ;
    printf( " \nUnsorted List : " ) ;
    printArray (&list[0] , size ) ;
    radixSort(&list[0],size ) ;
    printf( " \nSorted List : " ) ;
    printArray (&list[0] , size) ;
    printf( " \n " ) ;
    return 0 ;
}
