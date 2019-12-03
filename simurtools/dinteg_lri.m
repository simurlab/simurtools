% DINTEG_LRI   Realiza la doble integral de una aceleracion mediante el metodo LRI, 
%                     para obtener un desplazamiento
% 
% Syntax: pos=dinteg_lri(acc,freq)
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
% See also: dinteg_ddi, dinteg_msi, dinteg_ofi, dinteg_cms

% Author:   Diego
% History:  renaming, JC 30-11-2019

function pos=dinteg_lri(acc,freq)

%%Sabatini05
%Calculamos la intergral mediante aproximacion trapezoidal
veloc=cumtrapz((acc)/freq);
%Se corrige para lograr velocidad final igual a cero
vel=linspace(1,0,length(veloc))'.*veloc;

%Se vuelve a integrar para obtener la posicion
%con la integral trapezoidal de la velocidad.
pos=cumtrapz((vel)/freq);
end