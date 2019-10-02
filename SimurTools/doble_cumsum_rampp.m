% DOBLE_CUMSUM_RAMPP   Realiza la doble integral de una aceleracion mediante el método de Rampp, 
%                     para obtener una velocidad suponiendo:
%   1) que la aceleración tiene media cero. (velocidad final igual a la
%      inicial)
%   2) que en los instantes iniciales y finales el valor real de la aceleración es cero. 
% 
% Syntax: pos=doble_cumsum_rampp(acc,freq)
% 
% Input parameters:
%   acc-> señal de aceleración
%   freq-> frecuencia d emuestreo
%
% Output parameters:
%   pos<- señal de posición
%
% Examples: 
%
% See also: doble_cumsum

% Author:   Diego
% History:  


function pos=doble_cumsum_rampp(acc,freq)

%%Este método supone que el 4% inicial de la señal, y el 2% final de la
%%señal, el sistema tiene aproximadamente aceleración 0. Lo usa para
%%estimar el drift. Si se termina con un movimiento rápido estará muy
%%distorsionado. 
%%El método también supone que las últimas 5 muestras se ha vuelto a la
%%velocidad inicial. 

%y operamos sobre cada uno de ellos

    %Se toma el primer 4% de los datos para la función de drift
    kn=round(length(acc)*4/100);
    y0=1/kn*sum(acc(1:kn));
    %y también el último 2% de los datos
    kl=round(length(acc)*2/100);
    y1=1/kl*sum(acc(end-kl+1:end));
    
    %Se calcula la función de drift para cada punto
    da=[ y0*ones(kn,1);   linspace(y0,y1,length(acc)-kn-kl)'  ;  y1*ones(kl,1) ];
    
    %Cálculo de la aceleracion compensada por el drift
    acc=acc-da;
    %Calculamos la intergral mediante aproximación trapezoidal
    vel=cumtrapz(acc/freq);
    
    %Para los casos en los que la velocidad final debería ser cero
    %el drift final en la velocidad se calcula como la media de los 
    %últimos 5 valores
    y1=mean(vel(end-4:end));
    %y suponiendo un drift de velocidad lineal
    dv=linspace(0,y1,length(vel))';
    
    velfilt=vel-dv;
    
    %La posición vuelve a ser la integral trapezoidal de la velocidad.
    pos=cumtrapz(velfilt/freq);

