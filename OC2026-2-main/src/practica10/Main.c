#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#define SENSORS 2

extern void _setbit(unsigned char*,unsigned int);
extern unsigned char _getbit(unsigned int,unsigned int);
void update_temp( int *temps);
void update_flags( int *temps,int *last_temps, unsigned char *flags);
void show_temps(int *temps,unsigned char *flags);

int main(void)
{
	srand(time(NULL));
	int temps[SENSORS] = {25,25};
	int last_temps[SENSORS] = {25,25};
	unsigned char flags[SENSORS] = {0b00000001,0b00000001};
    int opcion = 1;

    do{
    show_temps(temps,flags);
    printf("\n\n[1]Actualizar \n[2]Salir\n\r");
    scanf("%d",&opcion);

    if(opcion == 1){

    

    last_temps[0] = temps[0];
    last_temps[1] = temps[1];
    update_temp(temps);
    update_flags(temps,last_temps,flags);
    }

    }while(opcion == 1);

	printf("\n\rFIN DE PROGRAMA\n\n\r");
	return 0;
}

void update_flags(int *temps,int *last_temps, unsigned char *flags)
{
    flags[0]= 0b00000000;
    flags[1]= 0b00000000;
    int f1,f0;
    f0 = temps[0] - last_temps[0];  
    f1 = temps[1] - last_temps[1]; 

    if( f0 < 0){
        _setbit(&flags[0],4);
        if(f0 == -1 ) _setbit(&flags[0],1);
        else if(f0 == -2)_setbit(&flags[0],2);
        else _setbit(&flags[0],3);
    }
    else if (f0 > 0){
        _setbit(&flags[0],5);
        if(f0 == 1 ) _setbit(&flags[0],1);
        else if(f0 == 2)_setbit(&flags[0],2);
        else _setbit(&flags[0],3);
    }
    else if (f0 == 0) _setbit(&flags[0],0);
    
    if( f1 < 0){
        _setbit(&flags[1],4);
        if(f1 == -1 ) _setbit(&flags[1],1);
        else if(f1 == -2)_setbit(&flags[1],2);
        else _setbit(&flags[1],3);
    }
    else if (f1 > 0){
        _setbit(&flags[1],5);
        if(f1 == 1 ) _setbit(&flags[1],1);
        else if(f1 == 2)_setbit(&flags[1],2);
        else _setbit(&flags[1],3);
    }
    else if (f1 == 0) _setbit(&flags[1],0);

}

void show_temps(int *temps,unsigned char *flags)
{
    char txt[4] = "--",msg[4] = "--";
    if(_getbit(flags[0],5)){
        if(_getbit(flags[0],1)) strcpy(txt,">");
        else if(_getbit(flags[0],2))strcpy(txt,">>");
        else if(_getbit(flags[0],3))strcpy(txt,">>>");
    }
    else if(_getbit(flags[0],4)){
        if(_getbit(flags[0],1)) strcpy(txt,"<");
        else if(_getbit(flags[0],2))strcpy(txt,"<<");
        else if(_getbit(flags[0],3))strcpy(txt,"<<<");
    }    
    else if(_getbit(flags[0],0)) strcpy(txt,"--");

    if(_getbit(flags[1],5)){
        if(_getbit(flags[1],1)) strcpy(msg,">");
        else if(_getbit(flags[1],2))strcpy(msg,">>");
        else if(_getbit(flags[1],3))strcpy(msg,">>>");
    }
    else if(_getbit(flags[1],4)){
        if(_getbit(flags[1],1)) strcpy(msg,"<");
        else if(_getbit(flags[1],2))strcpy(msg,"<<");
        else if(_getbit(flags[1],3))strcpy(msg,"<<<");
    }    
    else if(_getbit(flags[1],0)) strcpy(msg,"--");

    printf("\n Sensor 1: ~%d °C %s",temps[0],txt);
    printf("\n Sensor 2: ~%d °C %s",temps[1],msg);
 }



void update_temp( int *temps)
{
	int min = -5,max = 5;
	for(int i = 0 ; i < SENSORS; i++)
	{
		temps[i]+=rand() % (max - min + 1) + min;
	}
}