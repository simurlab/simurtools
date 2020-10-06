%Funcion para obtener la orientacion de un solido rigido 
% mostrar_orientacion_solido_rigido(Matriz1, 20, true,19,[26 29 32],true)
%Entradas
    %Matriz es la matriz leida previamente desde el archivo CSV
    %Paso--> Paso en el calculo de la orientación (para ahorrar tiempo)
    %total--> Variable booleana para saber si representamos toda al secuencia o
            %una parte
    % pos1--> Columna de la matriz correspondiente a la primera columna del
        % marcador
    % Marcadores: Posicion de los marcadores que definen el solido rigido
    % MostrarMarcadores: Funcion booleana: 
        %Si es true: muestra el solido rigido y los marcadores
        %Si es false: Muestra solo el solido rígido
%Salidas
    % Plot con las posiciones y la orientacion del solido rigido y el
        % los marcadores qe lo definen
% Para usar --> mostrar_orientacion_solido_rigido(M2,25,true,19,[26 29 32],true);


function [Datos] = mostrar_orientacion_solido_rigido(Matriz,Paso,total,pos1,Marcadores,MostrarMarcadores)
a=Matriz(:,pos1);
b=Matriz(:,pos1+1);
c=Matriz(:,pos1+2);
d=Matriz(:,pos1+3);
quat=[d,a,b,c];
quat_norm=normalize(quat);

solidorig=trayectoria_marcador(Matriz,pos1+4);
hold off
mostrar_marcadores_solido_rigido(Matriz,Marcadores,MostrarMarcadores);
hold on
if total==true
    max=length(solidorig);
    i=1;
else
   max=2000;
   i=1300;
end
T0=eye(4);
while i <max
    T1= trvec2tform(solidorig(i,:)) * quat2tform(quat_norm(i,:)) * T0;
    pframe(T1,'green',50);%representacion del frame en color verde axis equal
    title('MOVIMIENTO RIGID BODY') 
    legend('Prueba representacion')
    grid on 
    hold on
     i=i+Paso;
end
end