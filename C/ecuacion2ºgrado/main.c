#include <stdio.h>
#include <math.h>

int main(void){

    float a, b, c, aux;
    float res, res2;

    printf("¿Cual es el valor de a?\n");
    scanf("%f",&a);

    printf("\n¿Cual es el valor de b?\n");
    scanf("%f",&b);

    printf("\n¿Cual es el valor de c?\n");
    scanf("%f",&c);
    printf("\n");



    if(pow(b,2)-4*a*c<0){
        printf("raiz negativa");
        res=(-1*b)/(2*a);
        res2=pow(b,2)-4*a*c;
        res2 = sqrt(-res2);
        aux=2.0*a;
        res2 = res2/aux;
        /*printf("\n%f + (sqrt(%f) i)/%f\n", res, res2, aux);
        printf("%f - (sqrt(%f) i)/%f", res, res2, aux);*/
        printf("\n%f + %fi\n", res, res2);
        printf("\n%f - %fi\n", res, res2);
    }else{
        res=((-1.0*b)+sqrt(pow(b,2)-4.0*a*c))/(2.0*a);
        res2=((-1.0*b)-sqrt(pow(b,2)-4.0*a*c))/(2.0*a);

        printf("el resultado de la ecuación es %f y %f", res, res2);
    }


    return 0;
}
