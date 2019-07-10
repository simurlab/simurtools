% DOBLE_CUMSUM_ZIJLSTRA   Realiza la doble integral de una aceleracion mediante el método de Kose, 
%                     para obtener una velocidad suponiendo:
%   1) que la aceleración tiene media cero. (velocidad final igual a la
%      inicial)
%   2) que los valores inicial y final de aceleración son aproximadamente
%      cero para no incluir una distorsión por el filtro paso alto.
%   3) que la velocidad tiene media cero, y por lo tanto la posición final es igual a la inicial 
% 
% Syntax: pos=doble_cumsum_zijlstra(acc,freq)
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

function pos=doble_cumsum_zijlstra(acc,freq)

%%Este método sólo funciona bien con señales que empiezan y terminan en
%%cero(o distorsiona los bordos). Supone valor final de posición 0. En esto 
%es más exigente que todos los otros. 
%%Además el filtro paso alto supone que la 
%media debería ser cero.

    %Diseñamos el filtro de butterworth de orden 2 a 20Hz
    [b,a]=butter(2,20/(freq/2));
    %Aplicamos el filtro de forma bidireccional para que sea de orden 4 y
    %con zero lag. En el paper no dicen si modifican o no la frecuencia del
    %cálculo. 
    acc=filtfilt(b,a,acc);
    
    %Se realiza la integración. No se especifica método, uso rectangular. 
    vel=cumsum(acc/freq);
    pos=cumsum(vel/freq);
    
    %Se filtra para evitar el drift de la doble integral
    [b,a]=butter(2,0.1/(freq/2),'high');
    pos=filtfilt(b,a,pos);

