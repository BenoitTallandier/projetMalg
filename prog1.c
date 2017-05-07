#include <stdio.h>
#include <math.h>
int main(){
    unsigned int n,c,k,nombre,temp;
    printf("Entre un nb decimal\n");
    scanf("%d",&n);
    nombre = 0;
    //@ assert nombre==0;
    printf("en binaire:\n");
    //@ loop invariant \forall integer j; c <= j <= 31 ==> nombre>>j == n>>j;
    for(c=31;c>=0;c--){
        k=n>>c;
        temp = (k&1)*((int)pow(2,c));
        nombre = nombre + temp;
        if(k&1){
            printf("1");
        }
        else{
            printf("0");
        }
    }
    printf("\n");
    //@ assert nombre==n;
    return 0;
}
