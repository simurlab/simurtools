% Funcion para calcular la distancia recorrida por el marcador o el solido
% rigido dentro de una columna de datos (un eje). Para usar --> 
%distancia_recorrida_marcador(M1,17);
% Entrada
    % Matriz previamente cargada
    % Numero de la columan que queremos leer.
% Salida
    %Distancia recorrida


function [Datos] = distancia_recorrida_marcador(Matriz, i1)
Columna=Matriz(:,i1);
max=length(Columna);
distancia=0;
suma=0;
i=1;
while i<max
     
     if (Columna(i)<=0) || (Columna(i+1)<=0)
         suma=0;
     else
        if (Columna(i)>Columna(i+1))
            suma=(Columna(i)-Columna(i+1));
        else
            suma=(Columna(i+1)-Columna(i));
        end
        
     end
     distancia=distancia+suma;
    i=i+1;
end

[Datos]=distancia;
fprintf('Distancia recorrida es %6.4f, en la unidad del archivo original. \n',distancia)
end