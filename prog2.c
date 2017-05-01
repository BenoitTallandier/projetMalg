#include<stdio.h>
void printArray(int*array,int size){
    int i ;
    printf ( " [ " ) ;
    for ( i = 0 ; i < size ; i ++)
        printf( "%d " , array[i] ) ;
    printf( " ]\n " ) ;
}

int findLargestNum(int *array,int size){
    int i ;
    int largestNum = -1;
    for(i=0;i<size;i++){
        if ( array [ i ] > largestNum )
            largestNum = array [ i ] ;
    }
    return largestNum ;
}
    // Radix Sort
void radixSort(int * array,int size){
    printf( " \n\nRunning Radix Sort on Unsorted L i s t !\n\n " ) ;
    // Base 10 i s used
    int i ;
    int semiSorted [ size ] ;
    int significantDigit = 1 ;
    int largestNum = findLargestNum(array,size);
    // Loop u n t i l we reach the l a r g e s t s i g n i f i c a n t d i g i t
    while ( largestNum / significantDigit> 0 ) {
        printf ( "Sorting : %d  place" , significantDigit) ;
        printArray ( array , size ) ;
        int bucket[10] = {0};
        // Counts the number o f " keys " or d i g i t s t h a t w i l l go i n t o each bucket
        for ( i = 0 ; i < size ; i ++)
            bucket [ ( array [ i ] / significantDigit) % 10]++;
        /*
         Add the count o f the p r e v i o u s buckets ,
        ∗ Acquires the i n d e x e s a f t e r the end o f each bucket l o c a t i o n in the array
        ∗ Works s i m i l a r t o the count s o r t algorithm
        */
        for(i=1;i<10;i++)
            bucket[i]+=bucket[i-1];
        // Use the bucket t o f i l l a " semiSorted " array
        for(i=size-1;i>=0;i--)
            semiSorted[--bucket[(array[i]/significantDigit)%10]] = array[i];
        for(i=0;i<size;i++)
            array [ i ] = semiSorted [ i ] ;
        // Move t o next s i g n i f i c a n t d i g i t
        significantDigit*=10;
        printf( " \n\tBucket : " ) ;
        printArray ( bucket , 10 ) ;
    }
}

int main ( ) {
    printf( " \n\nRunning Radix Sort Example in C! \n " ) ;
    printf ( "−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−\n " ) ;
    int size = 12 ;
    int list[] = { 10 , 2 , 303 , 4021 , 293 , 1 , 0 , 429 , 480 , 92 , 2999 , 14 } ;
    printf( " \nUnsorted L i s t : " ) ;
    printArray (&list[0] , size ) ;
    radixSort(&list[0],size ) ;
    printf( " \nSorted L i s t : " ) ;
    printArray (&list[0] , size) ;
    printf( " \n " ) ;
    return 0 ;
}
