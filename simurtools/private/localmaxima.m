% LOCALMAXIMA Determina los puntos que son m�ximos locales de una funci�n en un entorno 
%
% LOCALMAXIMA Determina los puntos que son m�ximos locales de una funci�n en un entorno 
% 
% Syntax: lista=localmaxima(datos,N)
% 
% Input parameters:
%   datos-> se�al en la que se buscar�n los m�ximos
%   N    -> n�mero de datos a cada lado que deben ser menores para que el punto se considere m�ximo local
%
% Output parameters:
%   maximos<- vector conteniendo la posicion de los maximos
%
% Examples:
%
% See also: buscamaximos, buscamaximosth

% Author:   Javi
% History:  xx.yy.zz    Javi crea el archivo
%           04.01.2008  incorporada a la toolbox v0.4
%           21.01.2008  documentada

function [f]=localmaxima(x,N)
%algoritmo sencillo de lozalizaci�n de m�ximos relativos
%N indica el n� de muestras por cada lado que el punto tiene que ser mayor
%para ser un maximo
contador=1;
f=[];
for i=N+1:length(x)-N
   if(x(i)==max(x((i-N):(i+N))))
      f(contador)=i; %#ok<AGROW>
      contador=contador+1;
   end
end
