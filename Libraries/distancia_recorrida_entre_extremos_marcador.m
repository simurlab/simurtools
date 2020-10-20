% Funcion para calcular la distancia entre los puntos mas lejanos tomados
% dentro de una columna de datos (un eje). Para usar --> 
% distancia_recorrida_entre_extremos_marcador(M1,17);
% Corresponde con el desplazamiento en un eje de un marcador o un solido
% rigido
% Entrada
    % Matriz previamente cargada
    % Numero de la columan que queremos leer.
% Salida
    %Tabla del con valores maximos y minimos medidos y la diferencia


function [Datos]=distancia_recorrida_entre_extremos_marcador(Matriz,Columna)
vec=length(Columna);
i=1;
[Datos]=[];
while i<=vec
    A=Matriz(:,Columna(i));
    Max=max(A(A>0));
    Min=min(A(A>0));
    Salida=[Max; Min; (Max-Min)];
    [Datos]=[Datos Salida];
    i=i+1;
end

[Clases]=["Maximo"; "Minimo"; "Distancia entre extremos"];
TTT=table(Clases,Datos)

end
    
    





