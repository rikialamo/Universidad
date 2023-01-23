#include <stdio.h>
#include <stdlib.h>

int main(void){

    char car;
    int i;
    float f;
    printf("Introduzca un caracter: ");
    scanf("%c", &car);
    printf("Introduzca un entero: ");
    scanf("%d", &i);
    printf("Introduzca un real: ");
    scanf("%f", &f);
    printf("El caracter es: %c\n", car);
    printf("El entero es: %d\n", i);
    printf("El real es: %f\n", f);

    return 0;
    }
