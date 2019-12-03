% dinteg_msi   Realiza la doble integral de una aceleracion mediante el metodo , 
%                     para obtener una velocidad suponiendo:
%   1) que la aceleración tiene media cero. (velocidad final igual a la
%      inicial)
% 
% Syntax: pos=dinteg_msi(acc,freq)
% 
% Input parameters:
%   acc-> senl de aceleracion
%   freq-> frecuencia de muestreo
%
% Output parameters:
%   pos<- signal de posicion
%
% Examples: 
%
% See also: dinteg_lri, dinteg_msi, dinteg_ofi, dinteg_ddi

% Author:   Diego
% History:  renaming, JC 30-11-2019 


function pos=dinteg_msi(acc,freq)

% supone que la velocidad final es igual que la velocidad inicial. 

    %Eliminamos la media
    acc_filt=acc-mean(acc);
    %Se realiza la integración.
    vel=cumsum(acc_filt/freq);
    pos=cumsum(vel/freq);
    

