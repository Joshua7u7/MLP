function Salida=funcion_activacion(pesos,bias,entrada,opcion)
	if(opcion==1)
		Salida = pesos*entrada+bias;
	end
	if(opcion==2)
		Salida=logsig(pesos*entrada+bias);
	end
	if(opcion==3)
		Salida=tansig(pesos*entrada+bias);
	end
end

function Salida=logsig(n)
	for i=1:size(n,1)
		for j=1:size(n,2)
			Salida(i,j)=1/(1+exp(-n(i,j)));
		end
	end
end

function Salida=tansig(n)
	for i=1:size(n,1)
		for j=1:size(n,2)
			Salida(i,j)=(exp(n(i,j))-exp(-n(i,j)))/(exp(n(i,j))+exp(-n(i,j)));
		end
	end
end

