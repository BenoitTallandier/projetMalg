#include<stdio.h>

int p2(int x){
    unsigned int z=0,v=0,w=1,t=3,u=0,u2=0;
    while ( u < x ){
        z=z+v+w;
        v=v+t ;
        t = t+6;
        w=w+3;
        u=u+1;
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
