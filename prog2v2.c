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
        if ( array [ i ] > largestNum )
            largestNum = array [ i ] ;
    }
    //@ assert \forall int k; 0 <= k <= size-1 ==> largestNum >= array[k];
    return largestNum ;
}

/*@ requires size>0 && size<=20;
ensures \forall integer k; 0<k<size ==> \result[k-1]<=\result[k]*/
int * radixSort(int * array,int size){
    printf( " \n\nRunning Radix Sort on Unsorted L i s t !\n\n " ) ;
    // Base 10 i s used
    int i ;
    int semiSorted[size];
    int significantDigit = 1 ;
    int largestNum = findLargestNum(array,size);
    /*@ loop invariant \forall integer k; (0<k<size && significantDigit>=10) ==> (array[k-1]/(significantDigit/10))%10 <= (array[k]/(significantDigit/10)%10; */
    while ( largestNum / significantDigit> 0 ) {
        printf ( "Sorting : %d  place" , significantDigit) ;
        printArray ( array , size ) ;
        int bucket[10] = {0};
        for ( i = 0 ; i < size ; i ++)
            bucket [ ( array [ i ] / significantDigit) % 10]++;
        /*@ loop invariant \forall integer k; 0 < k < i ==> bucket[k-1]<=bucket[k];*/
        for(i=1;i<10;i++)
            bucket[i]+=bucket[i-1];
        /*@ loop invariant \forall integer k; 0<k<size ==> (semiSorted[k-1]%significantDigit<=semiSorted[k]%significantDigit || semiSorted[k] == array[k] || semiSorted[k]<0);*/
        for(i=size-1;i>=0;i--)
            semiSorted[--bucket[(array[i]/significantDigit)%10]] = array[i];
        /*@ loop invariant \forall integer k;0<=k<size ==> array[i] == semiSorted[i]; */
        for(i=0;i<size;i++)
            array [ i ] = semiSorted [ i ] ;
        significantDigit*=10;
        printf( " \n\tBucket : " ) ;
        printArray ( bucket , 10 ) ;
    }
    return array;
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
