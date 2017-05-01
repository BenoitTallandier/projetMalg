#include <stdio.h>
int main(){
    int n,c,k;
    printf("Entre un nb decimal\n");
    scanf("%d",&n);
    printf("en binaire:\n");
    /*@ loop invariant c>=0 && c<=31;*/
    for(c=31;c>=0;c--){
        k=n>>c;
        //@ assert k==1 || k==0;
        if(k&1){
            printf("1");
        }
        else{
            printf("0");
        }
    }
    printf("\n");
    return 0;
}
