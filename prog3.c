#include<stdio.h>
#include<limits.h>
//@ requires x>=0 && x<=1290 && x*x*x<INT_MAX; 
int p2(int x){
    int z=0,v=0,w=1,t=3,u=0,u2=0;
    //@ assert x>=0 && x<=1290;
    //@ assert w==1;
    //@ assert u==0;
    //@ assert v==0;
    //@ assert z==0;
    /*@ loop invariant u<=x && z==u*u*u;
    @ loop assigns z,v,t,w,u; */
    while ( u < x ){
        z=z+v+w;        
        v=v+t ;
        t = t+6;
        w=w+3;
        u=u+1;
    }
    //@ assert u==x;
    //@ assert z==x*x*x;
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
