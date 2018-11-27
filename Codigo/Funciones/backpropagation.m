function [Pesos,Bias]=backpropagation(pesos,bias,error_i,arquitectura,funciones,salida,factor_a)

	%Sensitividades %
	total_capas=size(funciones,2);
	S=cell(total_capas,1);
	derivada=derivada_funcion_activacion(funciones(1,total_capas),arquitectura(size(arquitectura,2)),salida{total_capas+1});
	S{total_capas}=-2*derivada*error_i;

	for capa=total_capas:-1:2
		derivada=derivada_funcion_activacion(funciones(1,capa-1),arquitectura(1,capa),salida{capa});
		S{capa-1}=derivada*transpose(pesos{capa})*S{capa};
	end
	%Final de sensitividades%

	% Actualizando pesos y bias%
	for it=total_capas:-1:1
		pesos{it}=pesos{it}-factor_a*S{it}*transpose(salida{it});
		bias{it}=bias{it}-factor_a*S{it};
	end
	%Finaliza actualizacion%
	Pesos=pesos;
	Bias=bias;
end

function S=derivada_funcion_activacion(opcion,n_neuronas,salida)
	Matriz=zeros(n_neuronas);

	if opcion==1
		for i=1:size(Matriz,1)
			for j=1:size(Matriz,2)
				Matriz(i,j)=1;
			end
		end
	end

	if opcion==2
		for i=1:size(Matriz,1)
			for j=1:size(Matriz,2)
				if i==j
					Matriz(i,j)=salida(i)*(1-salida(i));
				end
			end
		end
	end

	if opcion==3
		for i=1:size(Matriz,1)
			for j=1:size(Matriz,2)
				if i==j
					Matriz(i,j)=1-salida(i)^2;
				end
			end
		end
	end

	S=Matriz;
end