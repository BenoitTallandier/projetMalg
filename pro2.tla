------------------------------ MODULE prog2------------------------------
EXTENDS TLC,Integer,Naturals
CONSTANTS largestNum,list

(*
--algorithm radix{
variables semiSorted=[], significantDigit,array=list,temp;
{
    significantDigit := 1;
    while((largestNum/significantDigit)>0){
        bucket:=[0,0,0,0,0,0,0,0,0,0];
        temp:=0;
        
        while(temp<10){
            bucket[ (array[i]/significantDigit)%10 ] := bucket[ (array[i]/significantDigit)%10 ] +1;
        }
        temp:=0;
        while()
    }
}
}