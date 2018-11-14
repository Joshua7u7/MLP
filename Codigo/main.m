addpath("./Funciones/")

% 1a y 1b Pedir archivos%
archivo_entrada=input('Ingrese el nombre del archivo con los datos de entrada: ','s');
ruta='Archivos/';
archivo_entrada=strcat(ruta,archivo_entrada);

datos_entrada=importdata(archivo_entrada);
[filas_entrada,columnas_entrada]=size(datos_entrada);

archivo_entrada=input('Ingrese el nombre del archivo con los targets: ','s');
ruta='Archivos/';
archivo_entrada=strcat(ruta,archivo_entrada);

targets=importdata(archivo_entrada);
[filas_target,columnas_target]=size(targets);

%Fin de la peticion de entradas%

% 1c Se pide el rango de la señal%
limite_inferior=input('Limite inferior de la senal: ');
limite_superior=input('Limite superior de la senal: ');
if(limite_inferior<=limite_superior)
	rango=limite_inferior:1/(filas_entrada):limite_superior;
else
	rango=limite_superior:1/(filas_entrada):limite_inferior;
end 
%Fin del modulo%

% 1d Pedir vectores de arquitectura%
vector_arquitectura=input('Vector de arquitectura: ');
[uno,tam_vector_arquitectura]=size(vector_arquitectura);
vector_funciones=input('Vector de funciones: ');
[uno,numero_capas]=size(vector_funciones);
%Fin del modulo 1d%

% 1e Pedir valor del factor de aprendizaje%
factor_aprendizaje=input('Ingrese el factor de aprendizaje: ');
%Fin del modulo 1e%

%1f valores de las condiciones de finalizacion%
epocas=input('Numero de epocas: ');
error_epoch_max=input('Senal de error: ');
epoch_val=input('Cada cuantas iteraciones se llevara a cabo una epoca de validacion: ');
num_val=input('Numero maximo de incrementos consecutivos del error de epoca de validacion: ');
%Fin del modulo 1f%

%1g Division del dataset en 3%
disp('Escoja la opcion que guste para la division del dataset: ');
disp('1. 80%-10%-10%');
disp('2. 70%-15%-15%');
opcion=input(' ');
[conjunto_entrenamiento,conjunto_validacion,conjunto_prueba,target_entrenamiento,target_validacion,target_prueba]=separar_datos(datos_entrada,targets,opcion,filas_entrada);
%Fin del modulo 1g%


% 2. Se inician los valores aleatorios entre -1 y 1%
capas=cell(numero_capas,2);
for i=1:tam_vector_arquitectura-1
	capas(i,1)=-1+2*rand(vector_arquitectura(1,i+1),vector_arquitectura(1,i));
	capas(i,2)=-1+2*rand(vector_arquitectura(i+1),1);
end
%Final del modulo 2%





