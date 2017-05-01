#include<stdio.h>
/*@
    ensures \result == x * x * x;
*/
int p2(int x){
    int z=0,v=0,w=1,t=3,u=0,u2=0;
    /*@ loop invariant z == u*u*u;
        loop assigns z,v,w,t,u; */
    while ( u < x ){
        // on calcul (u+1)^3 = u^3 + 3u^2 + 3u + 1
        z=z+v+w;
        v=v+t ;
        //@ assert v==3*u*u;
        t = t+6;
        w=w+3;
        //@ assert w==3*u+1;
        u=u+1;
        //@ assert z==u*u*u;
        printf("z:%d, v:%d, t:%d, w:%d,u:%d, u2:%d\n",z,v,t,w,u,u2);
    }
    return ( z ) ;
}

int main (){
    int v,r;
    printf("Entrez la valeur pour v : " );
    scanf ("%d",&v);
    r=v*v*v;
    printf( "voici la réponse de votre solution p2(%d)=%d et devrait valeur %d\n ",v,p2(v),r);
    return 0 ;
}
