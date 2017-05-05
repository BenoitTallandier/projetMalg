------------------------------ MODULE pro2------------------------------
EXTENDS TLC,Integers,Naturals
CONSTANTS largestNum,list,size

(*
--algorithm radix{
variables semiSorted=list, significantDigit,array=list,temp,bucket=[p \in 1..10 |-> 0];
{
    significantDigit := 1;
    while((largestNum \div significantDigit)>0){
        bucket:=[p \in 1..10 |-> 0];
        
        temp:=1;
        while(temp<=size){
            bucket[ ((array[temp] \div significantDigit) % 10)+1 ] := bucket[ ((array[temp] \div significantDigit) % 10)+1 ] + 1;
            temp := temp + 1;
        };
        temp:=2;
        while(temp<=10){
            bucket[temp] := bucket[temp] + bucket[temp-1] ;
            temp := temp+1;
        };
        temp :=size;
        while(temp>0){
            semiSorted[(bucket[((array[temp] \div significantDigit -1 )%10)+1])+1] := array[temp];
            temp := temp -1;
        };
        temp := 1;
        while(temp<=size){
            array[temp] := semiSorted[temp];
            temp := temp+1;
        };
        significantDigit := significantDigit*10;
    };
    print array;
}
}
*)
\* BEGIN TRANSLATION
CONSTANT defaultInitValue
VARIABLES semiSorted, significantDigit, array, temp, bucket, pc

vars == << semiSorted, significantDigit, array, temp, bucket, pc >>

Init == (* Global variables *)
        /\ semiSorted = list
        /\ significantDigit = defaultInitValue
        /\ array = list
        /\ temp = defaultInitValue
        /\ bucket = [p \in 1..10 |-> 0]
        /\ pc = "Lbl_1"

Lbl_1 == /\ pc = "Lbl_1"
         /\ significantDigit' = 1
         /\ pc' = "Lbl_2"
         /\ UNCHANGED << semiSorted, array, temp, bucket >>

Lbl_2 == /\ pc = "Lbl_2"
         /\ IF (largestNum \div significantDigit)>0
               THEN /\ bucket' = [p \in 1..10 |-> 0]
                    /\ temp' = 1
                    /\ pc' = "Lbl_3"
               ELSE /\ PrintT(array)
                    /\ pc' = "Done"
                    /\ UNCHANGED << temp, bucket >>
         /\ UNCHANGED << semiSorted, significantDigit, array >>

Lbl_3 == /\ pc = "Lbl_3"
         /\ IF temp<=size
               THEN /\ bucket' = [bucket EXCEPT ![ ((array[temp] \div significantDigit) % 10)+1 ] = bucket[ ((array[temp] \div significantDigit) % 10)+1 ] + 1]
                    /\ temp' = temp + 1
                    /\ pc' = "Lbl_3"
               ELSE /\ temp' = 2
                    /\ pc' = "Lbl_4"
                    /\ UNCHANGED bucket
         /\ UNCHANGED << semiSorted, significantDigit, array >>

Lbl_4 == /\ pc = "Lbl_4"
         /\ IF temp<=10
               THEN /\ bucket' = [bucket EXCEPT ![temp] = bucket[temp] + bucket[temp-1]]
                    /\ temp' = temp+1
                    /\ pc' = "Lbl_4"
               ELSE /\ temp' = size
                    /\ pc' = "Lbl_5"
                    /\ UNCHANGED bucket
         /\ UNCHANGED << semiSorted, significantDigit, array >>

Lbl_5 == /\ pc = "Lbl_5"
         /\ IF temp>0
               THEN /\ semiSorted' = [semiSorted EXCEPT ![(bucket[((array[temp] \div significantDigit -1 )%10)+1])] = array[temp]]
                    /\ temp' = temp -1
                    /\ pc' = "Lbl_5"
               ELSE /\ temp' = 1
                    /\ pc' = "Lbl_6"
                    /\ UNCHANGED semiSorted
         /\ UNCHANGED << significantDigit, array, bucket >>

Lbl_6 == /\ pc = "Lbl_6"
         /\ IF temp<=size
               THEN /\ array' = [array EXCEPT ![temp] = semiSorted[temp]]
                    /\ temp' = temp+1
                    /\ pc' = "Lbl_6"
                    /\ UNCHANGED significantDigit
               ELSE /\ significantDigit' = significantDigit*10
                    /\ pc' = "Lbl_2"
                    /\ UNCHANGED << array, temp >>
         /\ UNCHANGED << semiSorted, bucket >>

Next == Lbl_1 \/ Lbl_2 \/ Lbl_3 \/ Lbl_4 \/ Lbl_5 \/ Lbl_6
           \/ (* Disjunct to prevent deadlock on termination *)
              (pc = "Done" /\ UNCHANGED vars)

Spec == Init /\ [][Next]_vars

Termination == <>(pc = "Done")

\* END TRANSLATION


==================================================================
