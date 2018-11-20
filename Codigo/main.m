addpath("./Funciones/")

% 1a y 1b Pedir archivos%
archivo_entrada=input('Ingrese el nombre del archivo con los datos de entrada: ','s');
ruta='Archivos/';
archivo_entrada=strcat(ruta,archivo_entrada);

datos_entrada=importdata(archivo_entrada);
datos_grafica=datos_entrada;
[filas_entrada,columnas_entrada]=size(datos_entrada);

archivo_entrada=input('Ingrese el nombre del archivo con los targets: ','s');
ruta='Archivos/';
archivo_entrada=strcat(ruta,archivo_entrada);

targets=importdata(archivo_entrada);
[filas_target,columnas_target]=size(targets);
targets_grafica=targets;
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
epocas_totales=input('Numero de epocas: ');
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
[filas_validacion,columnas_validacion]=size(conjunto_validacion);
%Fin del modulo 1g%


% 2. Se inician los valores aleatorios entre -1 y 1%
pesos=cell(numero_capas,1);
bias=cell(numero_capas,1);
for i=1:tam_vector_arquitectura-1
	pesos(i,1)=-1+2*rand(vector_arquitectura(1,i+1),vector_arquitectura(1,i));
	bias(i,1)=-1+2*rand(vector_arquitectura(i+1),1);
end
%Final del modulo 2%

% Comenzando el entrenamiento %
error_epoca_val=zeros(100,1);
contador_validacion=2;
contador_val=0;
Salida_iteracion=0;
band=0;
eleccion=1;
while(eleccion==1)
	inicio=1;
	for epoca=inicio:epocas_totales

		if mod(epoca,epoch_val)==0
			suma_errores=0;
			for iteracion=1:size(conjunto_validacion,1)
				Salida_iteracion=feedFordward(pesos,conjunto_validacion(iteracion),bias,numero_capas,vector_funciones);
				suma_error=suma_error+(target_validacion(iteracion)-Salida_iteracion{numero_capas+1})^2;
			end
			error_epoca_val(contador_validacion)=suma_error/filas_entrada;
			
			if epoca>2
				if error_epoca_val(contador_validacion-1)<error_epoca_val(contador_validacion)
					contador_val=contador_val+1;
				else
					contador_val=0;
				end
			end

			if contador_val==num_val
				fprintf(1, '\nSalida por aumento de errores en validacion\n');
				band=1;
				break;
			end
			contador_validacion=contador_validacion+1;
		

	    else
	    	suma_error=0;
	    	fprintf(1,'---------------------');
			for iteracion=1:size(conjunto_entrenamiento,1)
				Salida_iteracion=feedFordward(pesos,conjunto_entrenamiento(iteracion),bias,numero_capas,vector_funciones);
				error_it=(target_entrenamiento(iteracion)-Salida_iteracion{numero_capas+1})^2;	
				suma_error=suma_error+error_it;
				%Salida_iteracion{numero_capas+1}
				[pesos,bias]=backpropagation(pesos,bias,error_it,vector_arquitectura,vector_funciones,Salida_iteracion,factor_aprendizaje);
			end
			fprintf(1,'---------------------');
			Error=(suma_error/size(conjunto_entrenamiento,1))

			if Error<error_epoch_max
				band=1;
				fprintf(1,'Salida exitosa con el error %d\n',Error);
				break;
			end

			if epoca==epocas_totales
				eleccion=input('Desea hacer mas iteraciones? 1. si 2 no');
			end
		end
	end

	if band==1
		break;
	end
end
% Fin del entrenamiento %

% Comprobacion %
suma_error=0;
for iteracion=1:size(conjunto_prueba,1)
	Salida_iteracion=feedFordward(pesos,conjunto_prueba(iteracion),bias,numero_capas,vector_funciones);
	error_it=(target_prueba(iteracion)-Salida_iteracion{numero_capas+1});	
	suma_error=suma_error+error_it;
	
end

Error=suma_error/size(conjunto_prueba,1);
if(abs(Error)<0.00001)
	fprintf(1,"Aprendido exitosamente\n");
end	
% Fin de la comprobacion%



% Graficando resultados %
plot(transpose(datos_grafica),transpose(targets_grafica));
hold on;
for iteracion=1:size(datos_grafica,1)
	Salida_iteracion=feedFordward(pesos,datos_entrada(iteracion),bias,numero_capas,vector_funciones);
	salida_red(iteracion)=Salida_iteracion{numero_capas+1};
end
plot(transpose(datos_grafica),transpose(salida_red));
% Fin de la impresion %

