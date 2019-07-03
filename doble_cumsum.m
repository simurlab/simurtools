% DOBLE_CUMSUM   Realiza la doble integral de una aceleracion para obtener una velocidad
% 
% Syntax: pos=doble_cumsum(acc,freq)
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
% See also: 

% Author:   Diego
% History:  

function pos=doble_cumsum(acc,freq)
    
    %Se realiza la integración.
    vel=cumsum(acc/freq);
    pos=cumsum(vel/freq);
    

