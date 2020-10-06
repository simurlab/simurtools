
% Funcion extraer información de un archivo de MOCAB con CABEZAL
% Para usar Matriz1=extraer_info_mocab('prueba_movimiento_cabezal.csv')
    % Entradas
        % Path del archivo
    % Salidas
        % Da como salida una matriz de datos del matlab
        % En el command window extrae
            % Nº de Solido Rigidos y su posición
            % Nº de Marcadores de SR y su posicion 
            % Nº de Marcadores sin SR y su posicion


function [Datos] = extraer_info_mocab(path)

cont=0;
cont1=0;
cell=readcell(path);
L={'W'};
L1={'Marker'};
r=[];
r1=[];
for c=1:14
   
    M=cell(c,:);
    
    for c1=1:length(M)
       if isequal(M(c1),L)
            s=c;
            r=[r c1];
            cont=cont+1;
            L2(cont)={cell(c-4,c1)};
       end
       if isequal(M(c1),L1)
           cont1=cont1+1;
           r1=[r1 c1];
       end
    end
   
end

for c2=1:length(L2)
   L3(c2)=string(L2(c2));
   L3(c2)=strcat(L3(c2),' Marker');
end
M=cell(s-4,:);
t=[];
for c3=1:length(L3)
    for c4=1:length(M)
        if isequal(L3(c3),M(c4))
            t=[t c4];   
        end
    end
end


d=s+1;
[Datos]=csvread(path,d,0);
r11=min(r1):3:max(r1);
cont1=cont1/3;
i=1;
t1=[];
tx=[];
while i<length(t)
    tx=t(i);
    if t(i)==(max(t)-2)

        i=i+342432;
    end
    t1=[t1 tx];
    i=i+3;
end
fprintf('El numero de cuerpo rigidos son %i,  marcadores con solido %i y marcadores sin solido %i .\n',cont,length(t1),cont1)
if cont>0
    fprintf('La posicion del cordenada X del solido rigido es:\n')
    disp(r-3)
    fprintf(' Al ser solido rigido primero cuaternion X Y Z W luego posicion centro del solido rigido X Y Z \n')
    fprintf('------------------------------------------------------------------------------------\n')
end

if t>0
    fprintf('La primera posicion de cada marcador correspondiente solido rigido \n')
    disp(t1)
    fprintf('Corresponde a la coordenada X de cada marcador (X Y Z)\n')
    fprintf('------------------------------------------------------------------------------------\n')
end

if cont1>0
    fprintf('La primera posicion de cada marcador sin solido rigido \n')
    disp(r11)
    fprintf('Corresponde a la coordenada X de cada marcador (X Y Z)\n')
end

fprintf('La salida de la funcion es una matriz con los datos del archivo csv \n')
end