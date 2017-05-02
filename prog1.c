#include <stdio.h>
#include <math.h>
int main(){
    unsigned int n,c,k,nombre,temp;
    printf("Entre un nb decimal\n");
    scanf("%d",&n);
    nombre = 0;
    //@ assert nombre==0;
    printf("en binaire:\n");
    for(c=31;c>=0;c--){
        k=n>>c;
        //@ assert k==n>>c;
        //@ assert k>=0;
        temp = (k&1)*((int)pow(2,c));
        //@ assert temp >=0;
        nombre = nombre + temp;
        //@ assert nombre>=0;
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
