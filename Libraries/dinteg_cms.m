% dinteg_cms    Performs the integral double, p.e. of an acceleration to obtain a
% position
% 
% Syntax: pos=dinteg_cms(acc,freq)
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

function pos=dinteg_cms(acc,freq)
    
    %Se realiza la integracion.
    vel=cumsum(acc/freq);
    pos=cumsum(vel/freq);
    

