
#include <stdio.h>
#define MAX 6

extern int _minimo(int*,int);
extern int _maximo(int*,int);
extern int _sumatoria(int*,int);


int main(void)
{
    int arreglo[MAX] = {5,-2,9,22,-11,10}; //33
	printf("\n ARREGLO:");	
	for(int i=0; i<MAX ; i++)
		printf("%d ",arreglo[i]);

    printf("\n\r Minimo Ensamblador: %d\n\r",_minimo(arreglo,MAX));
	printf("\n\r Maximo Ensamblador: %d\n\r",_maximo(arreglo,MAX));
	printf("\n\r Sumatoria: %d\n\r",_sumatoria(arreglo,MAX));
	return 0;
}
