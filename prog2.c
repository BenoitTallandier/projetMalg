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
    int semiSorted [ 10 ];
    unsigned int significantDigit = 0 ;
    int largestNum = findLargestNum(array,size);
    /* loop invariant \forall integer k2; 1 <= k2 < size ==> array[k2-1]%significantDigit <= array[k2]%significantDigit;*/
    while ( largestNum / significantDigit> 0 ) {
        int bucket[10]={0};
        
        for ( i = 0 ; i < size ; i ++)
            bucket [ ( array [ i ] / significantDigit) % 10]++;
	printArray(bucket,10);
        
        for(i=1;i<10;i++)
            bucket[i]+=bucket[i-1];
            
        /*@ loop invariant \forall integer k; i < k < size ==> semiSorted[k-1] <= semiSorted[k]; */
        for(i=size-1;i>=0;i--)
            semiSorted[ --bucket[ (array[i]/significantDigit)%10 ] ] = array[i];
            
	/*@ loop invariant \forall integer k; 0 <= k < i ==> array[k] == semiSorted[k] ;*/
        for(i=0;i<size;i++)
            array [ i ] = semiSorted [ i ] ;
        
        // assert \forall integer k2; 1 <= k2 < size ==> (array[k2-1])%significantDigit <= (array[k2])%significantDigit;    
        significantDigit*=10;
        //@ assert significantDigit >=0;
        printf( " \n\tBucket : " ) ;
        printArray ( bucket , 10 ) ;
        
    }
    // assert \forall integer k; 1 <= k < size ==> *(array + (k - 1)) ≤ *(array + k);
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
