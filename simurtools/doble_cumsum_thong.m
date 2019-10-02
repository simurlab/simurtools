% DOBLE_CUMSUM_THONG   Realiza la doble integral de una aceleracion mediante el método de Kose, 
%                     para obtener una velocidad suponiendo:
%   1) que la aceleración tiene media cero. (velocidad final igual a la
%      inicial)
% 
% Syntax: pos=doble_cumsum_thong(acc,freq)
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


function pos=doble_cumsum_thong(acc,freq)

%%Este método sólo supone que la velocidad final es igual que la velocidad 
%%inicial. 


    %Eliminamos la media
    acc_filt=acc-mean(acc);
    %Se realiza la integración.
    vel=cumsum(acc_filt/freq);
    pos=cumsum(vel/freq);
    

