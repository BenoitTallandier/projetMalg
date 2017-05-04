------------------------------ MODULE prog2------------------------------
EXTENDS TLC,Integer,Naturals
CONSTANTS largestNum,list,size

(*
--algorithm radix{
variables semiSorted=[], significantDigit,array=list,temp;
{
    significantDigit := 1;
    while((largestNum/significantDigit)>0){
        bucket:=[0,0,0,0,0,0,0,0,0,0];
        temp:=0;

        while(temp<size){
            bucket[ (array[temp]/significantDigit)%10 ] := bucket[ (array[temp]/significantDigit)%10 ] +1;
            temp := temp + 1;
        }
        temp:=1;
        while(temp<size){
            bucket[temp] := bucket[temp] + bucket[temp-1] ;
            temp := temp-1;
        }
        temp :=size-1;
        while(temp>=0){
            semiSorted[bucket[(array[temp]/significantDigit)%10]-1] := array[temp];
            temp := temp -1;
        }
        temp := size;
        while(temp<size){
            array[temp] := semiSorted[temp];
            temp := temp+1;
        }
        significantDigit := significantDigit*;
    }
}
}
