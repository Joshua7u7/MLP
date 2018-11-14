function [C_E,C_V,C_P,T_E,T_V,T_P]=separar_datos(entradas,target,opcion,numero_datos)

if(opcion==1)
	indices_validacion=unique(randi([1 numero_datos],round(numero_datos/10),1))
	for i=1:round(numero_datos*0.1)
		C_V(i,1)=entradas(indices_validacion(i,1),1);
		T_V(i,1)=target(indices_validacion(i,1),1);
		entradas(indices_validacion(i,1))=[];
		target(indices_validacion(i,1))=[];
	end
	numero_datos=numero_datos-round(numero_datos*0.1);
	indices_validacion=unique(randi([1 numero_datos],round(numero_datos/10),1));
	for i=1:round(numero_datos*0.1)
		C_P(i,1)=entradas(indices_validacion(i,1));
		T_P(i,1)=target(indices_validacion(i,1));
		entradas(indices_validacion(i,1))=[];
		target(indices_validacion(i,1))=[];
	end
	numero_datos=numero_datos-round(numero_datos*0.1);
	for i=1:numero_datos
		C_E(i,1)=entradas(i,1);
		T_E(i,1)=target(i,1);
	end
end

if(opcion==2)
	indices_validacion=unique(randi([1 numero_datos],round(numero_datos*0.15),1));
	for i=1:round(numero_datos*0.15)
		C_V(i,1)=entradas(indices_validacion(i,1));
		T_V(i,1)=target(indices_validacion(i,1));
		entradas(indices_validacion(i,1))=[];
		target(indices_validacion(i,1))=[];
	end
	numero_datos=numero_datos-round(numero_datos*0.15);
	indices_validacion=unique(randi([1 numero_datos],round(numero_datos*0.15),1));
	for i=1:round(numero_datos*0.15)
		C_P(i,1)=entradas(indices_validacion(i,1));
		T_P(i,1)=target(indices_validacion(i,1));
		entradas(indices_validacion(i,1))=[];
		target(indices_validacion(i,1))=[];
	end
	numero_datos=numero_datos-round(numero_datos*0.15);
	for i=1:numero_datos
		C_E(i,1)=entradas(i,1);
		T_E(i,1)=target(i,1);
	end
end 

end