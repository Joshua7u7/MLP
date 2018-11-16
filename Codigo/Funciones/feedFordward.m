function Salida=feedFordward(pesos,entrada,bias,num_capas,funciones)
	a=cell(num_capas+1,1);
	a(1,1)=entrada;
	for i=2:num_capas+1
		a(i,1)=funcion_activacion(pesos{i-1},bias{i-1},a{i-1},funciones(1,i-1));
	end
	Salida=a{i};
end