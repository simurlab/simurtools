% BUSCAMAXIMOS Detecta todos los máximos de una señal
% 
% Syntax: maximos=buscamaximos(datos)
% 
% Input parameters:
%   datos-> señal en la que se buscarán los máximos
%
% Output parameters:
%   maximos<- señal del mismo tamaño que datos, en la que aparece un 1 en la posición de cada
%  		máximo y un 0 en el resto de instantes.
%
% Examples:
%
% See also: buscamaximosth, localmaxima

% Author:   Diego
% History:  xx.yy.zz    Diego  creacion del archivo
%           	        JC, añade comentarios
%           19.12.07    incorporada a la toolbox
%           21.01.08    documentada


function maximos=buscamaximos(Datos)

%% Algoritmo: primero se convierte la se–al en una rectangular, con unos en las
%% pendientes positivas y ceros en las negativas.
%% Luego se repite la operaci—n para la se–al rectangular, con lo que
%% queda una con pulsos de valores +1 (en las transiciones de 0 a 1) y 
%% -1 (en las transiciones de 1 a 0). Los pulsos +1 son los m‡ximos.

tam=size(Datos);
tam=tam(1);

%% Obtenci—n de la se–al rectangular:
Datos=Datos(2:tam)-Datos(1:tam-1);
Datos=Datos>=0;

%% Obtenci—n de las se–al de pulsos:
Datos=Datos(1:tam-2)-Datos(2:tam-1);

%% los m‡ximos son los pulsos positivos:
maximos=Datos>0;
