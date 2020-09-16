%Funcion para obtener la trayectoria de un marcador
    %ENTRADAS
        % Matriz de puntos
        % Cordenada X del marcador
    %Salidas
        % Vector con las posiciones del marcador
        % Plot de las posiciones del marcador
    % Para  usar
        % --> Punto1=trayectoria_marcador(Matriz,7)
function [Marcador]= trayectoria_marcador(Matriz,i1)
    a=Matriz(:,i1);
    b=Matriz(:,i1+1);
    c=Matriz(:,i1+2);
    scatter3(a,b,c)
    Marcador=[a,b,c];
end
        