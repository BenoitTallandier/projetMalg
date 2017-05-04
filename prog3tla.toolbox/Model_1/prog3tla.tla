------------------------------ MODULE prog3tla ------------------------------

EXTENDS TLC,Naturals,Integers
CONSTANT x

(*
--algorithm prog3tla
{
    variables z=0,v=0,w=1,t=3,u=0,u2=0;
    {
        while( u < x )
        {
            z:=z+v+w;
            v:=v+t;
            t:=t+6;
            w:=w+3;
            u:=u+1;
        };
        print<<"fin de la boucle while">>;
        if (z=x*x*x)
        {
            print <<"z = x*x*x",z>>;
        }else{
            print<<"probleme">>;
        }
    }
}
*)
\* BEGIN TRANSLATION
VARIABLES z, v, w, t, u, u2, pc

vars == << z, v, w, t, u, u2, pc >>

Init == (* Global variables *)
        /\ z = 0
        /\ v = 0
        /\ w = 1
        /\ t = 3
        /\ u = 0
        /\ u2 = 0
        /\ pc = "Lbl_1"

Lbl_1 == /\ pc = "Lbl_1"
         /\ IF u < x
               THEN /\ z' = z+v+w
                    /\ v' = v+t
                    /\ t' = t+6
                    /\ w' = w+3
                    /\ u' = u+1
                    /\ pc' = "Lbl_1"
               ELSE /\ PrintT(<<"fin de la boucle while">>)
                    /\ IF z=x*x*x
                          THEN /\ PrintT(<<"z = x*x*x",z>>)
                          ELSE /\ PrintT(<<"probleme">>)
                    /\ pc' = "Done"
                    /\ UNCHANGED << z, v, w, t, u >>
         /\ u2' = u2

Next == Lbl_1
           \/ (* Disjunct to prevent deadlock on termination *)
              (pc = "Done" /\ UNCHANGED vars)

Spec == Init /\ [][Next]_vars

Termination == <>(pc = "Done")

\* END TRANSLATION


=============================================================================
\* Modification History
\* Last modified Thu May 04 09:43:18 CEST 2017 by Stefy
\* Created Thu May 04 09:33:05 CEST 2017 by Stefy
