addpath("./Funciones/")

%Pedir archivos%
archivo_entrada=input('Ingrese el nombre del archivo con los datos de entrada: ','s');
ruta='Archivos/';
archivo_entrada=strcat(ruta,archivo_entrada);

datos_entrada=importdata(archivo_entrada);

archivo_entrada=input('Ingrese el nombre del archivo con los targets: ','s');
ruta='Archivos/';
archivo_entrada=strcat(ruta,archivo_entrada);

targets=importdata(archivo_entrada);
%Fin de la peticion de entradas%

