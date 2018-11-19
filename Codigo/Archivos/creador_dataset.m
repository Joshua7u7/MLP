fac=1;
data=zeros(100,1);
pos=1;
a=-2:0.04:2;
for p = -2:0.04:2
	data(pos)=1+sin((pi*p*8)/4);
	pos=pos+1;
end

ip=fopen('target_#4.txt' ,'w');
for d=1:101
fprintf(ip,'%.4f\n',data(d));
end
fclose(ip);


ipp=fopen('input_#4.txt' ,'w');
for d=1:101
fprintf(ipp,'%.4f\n',a(d));
end
fclose(ipp);