------------------------------- MODULE prog1 -------------------------------
EXTENDS TLC,Integers,Naturals
(*
--algorithm  compte{
variables n,c=31,k,r,nombre=0,temp;
{
  temp:=n;
  while (c >= 0)
  {  
    k := n / (2 ^ c);
    r := n % (2 ^ c);
    temp := (k & 1) * ( 2 ^ c );
    nombre := nombre + temp;
    if (k&1){
        print <<"1">>;
        n := n - ( 2 ^ c );
    }
    else
    {
        print<<"0">>;
    };
    c := c - 1;
  };
}


}
}

*)
\* BEGIN TRANSLATION
CONSTANT defaultInitValue, test
VARIABLES n, c, k, r, nombre, temp, pc

vars == << n, c, k, r, nombre, temp, pc >>

Init == (* Global variables *)
        /\ n = defaultInitValue
        /\ c = 15
        /\ k = defaultInitValue
        /\ r = defaultInitValue
        /\ nombre = 0
        /\ temp = defaultInitValue
        /\ pc = "Lbl_1"

Lbl_1 == /\ pc = "Lbl_1"
         /\ n = test
         /\ temp' = test
         /\ pc' = "Lbl_2"
         /\ UNCHANGED << c, k, r, nombre >>

Lbl_2 == /\ pc = "Lbl_2"
         /\ IF c >= 0
               THEN /\ k' = n \div 2^c
                    /\ r' = n % 2^c
                    /\ temp' = k' * ( 2 ^ c )
                    /\ nombre' = nombre + temp'
                    /\ IF (k' = 1)
                          THEN /\ PrintT(<<"1">>)
                               /\ n' = r
                          ELSE /\ PrintT(<<"0">>)
                               /\ n' = n
                    /\ c' = c - 1
                    /\ pc' = "Lbl_2"
               ELSE /\ pc' = "Done"
                    /\ UNCHANGED << n, c, k, r, nombre, temp >>

Next == Lbl_1 \/ Lbl_2
           \/ (* Disjunct to prevent deadlock on termination *)
              (pc = "Done" /\ UNCHANGED vars)

Spec == Init /\ [][Next]_vars

Termination == <>(pc = "Done")

\* END TRANSLATION
=============================================================================
\* Modification History
\* Last modified Wed May 03 11:50:26 CEST 2017 by t7
\* Created Wed May 03 10:36:04 CEST 2017 by t7
