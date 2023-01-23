#include <stdio.h>
#include <stdlib.h>

int main(void){

    int x=10, y=20, z;
    printf("x vale %d e y vale %d\n", x, y);
    z=x;
    x=y;
    y=z;
    printf("Después del intercambio, x vale %d e y vale %d\n", x, y);

    return 0;
}
