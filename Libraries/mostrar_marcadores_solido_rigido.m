% Funcion para plotear los marcadores que definen un solido rigido
% mostrar_marcadores_solido_rigido(Matriz1,[26 29 32],true)
% ENTRADAS
    % Matriz de puntos
    % Marcadores que forman el solido rígido
% Salidas
    % Plot de los marcadores que forman el solido
    % En consola se muestra el numero de posiciones en las que se capto el
        % solido rigido, las totales y su eficiencia
    % Archivo donde salen las posiciones que ha recorrido
    
    function [Datos]= mostrar_marcadores_solido_rigido(Matriz,Marcadores,representar)
    marc=length(Marcadores);
    trayectoria=[];
    trayectoria2=[];
    i=1;
    m=[];
    while i<=marc
        trayectoria=[trayectoria trayectoria_marcador(Matriz, Marcadores(i))];
        
        i=i+1;
    end
  
   
   long=marc*3;
   i=1;
   max=length(trayectoria);
   while i<=max
       t=trayectoria(i,:);
       s=Matriz(i,[1 2 3 4 5 6]);
       if (norm(t)~=0)
           trayectoria2=[trayectoria2;s t];
           ii=1;
           x1=[];
           y1=[];
           z1=[];
           while ii<=long
                x1=[x1 t(ii)];
                y1=[y1 t(ii+1)];
                z1=[z1 t(ii+2)];
                ii=ii+3;
           end
           x1=[x1 t(1)];
           y1=[y1 t(2)];
           z1=[z1 t(3)];
           if representar==true
               plot3(x1,y1,z1)
               hold on
           else
               hold off
           end
           
       end
       i=i+1;
   end
   
   [Datos]=trayectoria2;
   efici=(length(trayectoria2)/length(trayectoria))*100;
   fprintf(" Se tienen %i posiciones de solido rigido de %i frames \n",length(trayectoria2),length(trayectoria)) 
   fprintf("Eficiencia de %2.3f por ciento\n",efici)
   fprintf("---------------------------------------------------------------------- \n")
    end