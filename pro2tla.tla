------------------------------ MODULE pro2tla ------------------------------

EXTENDS TLC,Integers,Naturals
CONSTANTS list,size

(*
--algorithm radix
{
    variables i=1,array=list,semiSorted=[p \in 1..size |-> 0],significantDigit=1,bucket=[p \in 1..10 |-> 0],largestNum=-1;
    {
        (*find largest Num*)
        i := 1;
        while ( i <= size )
        {
            if ( array[i] > largestNum )
            {
                largestNum := array[i];
            };
            i := i+1;
        };
    
        while (largestNum \div significantDigit > 0)
        {
            i := 1;
            bucket := [p \in 1..10 |-> 0];
            (*premier for*)
            while(i<=size)
            {
                bucket[(((array[i]) \div significantDigit)%10) +1] := bucket[(((array[i]) \div significantDigit)%10) +1]+1;
                i := i+1;
            };
            
            
            (*deuxieme for*)
            i := 2;
            while(i<=10)
            {
                bucket[i] := bucket[i] + bucket[i-1];
                i := i+1;
            };
            
            (*troisieme for*)
            i := size;
            while( i > 0 )
            {
                bucket[((array[i] \div significantDigit) % 10)+1] := bucket[((array[i] \div significantDigit) % 10)+1]-1;
                semiSorted[(bucket[((array[i] \div significantDigit) % 10)+1])+1] := array[i];
                i := i-1;
            };
            
            (*quatrième for*)
            i := 1;
            while (i <= size)
            {
                array[i] := semiSorted[i];
                i:=i+1;
            };
            
            significantDigit := significantDigit * 10;
            print(array);
        }
    }
}
*)
\* BEGIN TRANSLATION
VARIABLES i, array, semiSorted, significantDigit, bucket, largestNum, pc

vars == << i, array, semiSorted, significantDigit, bucket, largestNum, pc >>

Init == (* Global variables *)
        /\ i = 1
        /\ array = list
        /\ semiSorted = [p \in 1..size |-> 0]
        /\ significantDigit = 1
        /\ bucket = [p \in 1..10 |-> 0]
        /\ largestNum = -1
        /\ pc = "Lbl_1"

Lbl_1 == /\ pc = "Lbl_1"
         /\ i' = 1
         /\ pc' = "Lbl_2"
         /\ UNCHANGED << array, semiSorted, significantDigit, bucket, 
                         largestNum >>

Lbl_2 == /\ pc = "Lbl_2"
         /\ IF i <= size
               THEN /\ IF array[i] > largestNum
                          THEN /\ largestNum' = array[i]
                          ELSE /\ TRUE
                               /\ UNCHANGED largestNum
                    /\ i' = i+1
                    /\ pc' = "Lbl_2"
               ELSE /\ pc' = "Lbl_3"
                    /\ UNCHANGED << i, largestNum >>
         /\ UNCHANGED << array, semiSorted, significantDigit, bucket >>

Lbl_3 == /\ pc = "Lbl_3"
         /\ IF largestNum \div significantDigit > 0
               THEN /\ i' = 1
                    /\ bucket' = [p \in 1..10 |-> 0]
                    /\ pc' = "Lbl_4"
               ELSE /\ pc' = "Done"
                    
                    (*on verriefie que le tableau est bien trié*)
                    /\ array[1] <= array[2]
                    /\ array[2] <= array[3]
                    /\ array[3] <= array[4]
                    /\ array[4] <= array[5]
                    /\ array[5] <= array[6]
                    /\ array[6] <= array[7]
                    /\ array[7] <= array[8]
                    /\ array[8] <= array[9]
                    /\ array[9] <= array[10]
                    /\ array[10] <= array[11]
                    /\ array[11] <= array[12]
                    
                    /\ UNCHANGED << i, bucket >>
         /\ UNCHANGED << array, semiSorted, significantDigit, largestNum >>

Lbl_4 == /\ pc = "Lbl_4"
         /\ IF i<=size
               THEN /\ bucket' = [bucket EXCEPT ![(((array[i]) \div significantDigit)%10) +1] = bucket[(((array[i]) \div significantDigit)%10) +1]+1]
                    /\ i' = i+1
                    /\ pc' = "Lbl_4"
               ELSE /\ i' = 2
                    /\ pc' = "Lbl_5"
                    /\ UNCHANGED bucket
         /\ UNCHANGED << array, semiSorted, significantDigit, largestNum >>

Lbl_5 == /\ pc = "Lbl_5"
         /\ IF i<=10
               THEN /\ bucket' = [bucket EXCEPT ![i] = bucket[i] + bucket[i-1]]
                    /\ i' = i+1
                    /\ pc' = "Lbl_5"
               ELSE /\ i' = size
                    /\ pc' = "Lbl_6"
                    /\ UNCHANGED bucket
         /\ UNCHANGED << array, semiSorted, significantDigit, largestNum >>

Lbl_6 == /\ pc = "Lbl_6"
         /\ IF i > 0
               THEN /\ bucket' = [bucket EXCEPT ![((array[i] \div significantDigit) % 10)+1] = bucket[((array[i] \div significantDigit) % 10)+1]-1]
                    /\ semiSorted' = [semiSorted EXCEPT ![(bucket'[((array[i] \div significantDigit) % 10)+1])+1] = array[i]]
                    /\ i' = i-1
                    /\ pc' = "Lbl_6"
               ELSE /\ i' = 1
                    /\ pc' = "Lbl_7"
                    /\ UNCHANGED << semiSorted, bucket >>
         /\ UNCHANGED << array, significantDigit, largestNum >>

Lbl_7 == /\ pc = "Lbl_7"
         /\ IF i <= size
               THEN /\ array' = [array EXCEPT ![i] = semiSorted[i]]
                    /\ i' = i+1
                    /\ pc' = "Lbl_7"
                    /\ UNCHANGED significantDigit
               ELSE /\ significantDigit' = significantDigit * 10
                    /\ PrintT((array))
                    
                    (*on verriefie que sur 10^i le tabeau est bien trié*)
                    /\ (semiSorted[1] \div significantDigit) % 10 <= (semiSorted[2] \div significantDigit) % 10
                    /\ (semiSorted[2] \div significantDigit) % 10 <= (semiSorted[3] \div significantDigit) % 10
                    /\ (semiSorted[3] \div significantDigit) % 10 <= (semiSorted[4] \div significantDigit) % 10
                    /\ (semiSorted[4] \div significantDigit) % 10 <= (semiSorted[5] \div significantDigit) % 10
                    /\ (semiSorted[5] \div significantDigit) % 10 <= (semiSorted[6] \div significantDigit) % 10
                    /\ (semiSorted[6] \div significantDigit) % 10 <= (semiSorted[7] \div significantDigit) % 10
                    /\ (semiSorted[7] \div significantDigit) % 10 <= (semiSorted[8] \div significantDigit) % 10
                    /\ (semiSorted[8] \div significantDigit) % 10 <= (semiSorted[9] \div significantDigit) % 10
                    /\ (semiSorted[9] \div significantDigit) % 10 <= (semiSorted[10] \div significantDigit) % 10
                    /\ (semiSorted[10] \div significantDigit) % 10 <= (semiSorted[11] \div significantDigit) % 10
                    /\ (semiSorted[11] \div significantDigit) % 10 <= (semiSorted[12] \div significantDigit) % 10
                    
                    
                    /\ pc' = "Lbl_3"
                    /\ UNCHANGED << i, array >>
         /\ UNCHANGED << semiSorted, bucket, largestNum >>

Next == Lbl_1 \/ Lbl_2 \/ Lbl_3 \/ Lbl_4 \/ Lbl_5 \/ Lbl_6 \/ Lbl_7
           \/ (* Disjunct to prevent deadlock on termination *)
              (pc = "Done" /\ UNCHANGED vars)

Spec == Init /\ [][Next]_vars

Termination == <>(pc = "Done")

\* END TRANSLATION

invI == i \in 0..size+1

=============================================================================
\* Modification History
\* Last modified Sat May 06 19:05:49 CEST 2017 by Stefy
\* Created Sat May 06 16:47:25 CEST 2017 by Stefy
