#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <ctype.h>

int M[4][5];
int values=0;
char buffer[100];

bool comprobar()
{
    values=0;
    for(int i=0;i<4;i++){
        for(int j=0;j<5;j++){
            if(M[i][j] > 0){
                values+=1;
            }
        }
    }
    if((100*values/20) <= 30){
        return true;
    }
    return false;
}

void limpiar_matriz()
{
    for(int i=0 ; i<4 ; i++){
		for(int j=0 ; j<5 ; j++){
		    M[i][j]=0;
        }
    }
}

void imprimir()
{
    printf("\n Matriz\n ");
    for(int i=0;i<4;i++){
        printf("\n");
        for(int j=0;j<5;j++){
            printf(" %d ",M[i][j]);
        }
    }
    printf("\n ");
}

void comprimir()
{
    int C[3][values];
    int index=0;
    for(int i=0;i<4;i++){
        for(int j=0;j<5;j++){
            if(M[i][j] > 0){
                C[0][index] = i;
                C[1][index] = j;
                C[2][index] = M[i][j];
                index+=1;
            }
        }
    }

    printf("\n Matriz Comprimida\n\n");
    for(int i=0;i<3;i++){
        if(i == 0){
            printf(" Fila     ");
        }
        if(i == 1){
            printf(" Columna  ");
        }
        if(i == 2){
            printf(" Valores  ");
        }
        for(int j=0;j<values;j++){
            printf(" %d ",C[i][j]);
        }
        printf("\n");
    }
    printf("\n\n ");
    system("PAUSE");
}

void ingresar()
{
    int aux;
    for(int i=0;i<4;i++){
        for(int j=0;j<5;j++){
            printf("\n Ingrese Valor [%d][%d]: ",i,j);
            scanf("%d",&M[i][j]);
            }
    }
    if(comprobar()){
        imprimir();
        comprimir();
        menu();
    }
    else{
        printf("\n La Matriz ingresada no es Dispersa.\n\n ");
        system("PAUSE");
        menu();
    }
}


void generar()
{
    for(int i=0 ; i<4 ; i++){
		for(int j=0 ; j<5 ; j++){
		    if((rand()%10)+1 <= 7)
		    	M[i][j] = 0;
		    else
		    	M[i][j]=(rand()%9)+1;
        }
    }
    if(comprobar()){
        imprimir();
        comprimir();
        menu();
    }
    else{
        generar();
    }
}

void menu()
{
    limpiar_matriz();
    system("cls");
    int opt=0;
    printf(" \n ******** MENU ********\n\n 1.- Ingresar Matriz.\n 2.- Generar Matriz Automaticamente.\n 3.- Salir.\n\n Ingrese Opcion: ");
    scanf("%d",&opt);
    fgets (buffer, 100, stdin);
    if(opt < 1 && opt > 3){
        printf(" \nOpcion Ingresada Invalida!\n\n ");
        //system("PAUSE");
        menu();
    }
    if(opt == 1){
        ingresar();
        system("PAUSE");
    }
    if(opt == 2){
        generar();
        system("PAUSE");
    }
    else{
        exit(0);
    }
}

int main()
{
    srand(time(NULL));
    menu();
    return 0;
}
