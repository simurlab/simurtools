% BUSCAMAXIMOS Detecta todos los maximos de una senhal
% 
% Syntax: maximos=buscamaximos(datos)
% 
% Input parameters:
%   datos-> senhal en la que se buscaran los maximos
%
% Output parameters:
%   maximos<- senhal del mismo tamanho que datos, en la que aparece un 1 en 
%       la posicion de cada maximo y un 0 en el resto de instantes.
%
% Examples:
%
% See also: buscamaximosth
%


% Author:   Diego
% History:  xx.yy.zz    Diego  creacion del archivo
%           	        JC, añade comentarios
%           19.12.07    incorporada a la toolbox
%           21.01.08    documentada
%           30.09.19    adaptada a la nueva documentación


function maximos=buscamaximos(Datos)

%% Se calcula la derivada
Datos=conv(Datos,[1,-1]);

%% Y se determina su signo
Datos=1*(Datos>=0);

%% La segunda derivada indica los pasos de creciente a decreciente
% Se cambia el signo para que sea positivo en máximos
%  y negativo en mínimos
Datos=conv(Datos,[-1,1]);


%% Se corrige el retraso de una muestra introducida por las dos derivadas
Datos=Datos(2:end);

%% Los maximos son los pulsos positivos:
maximos=(Datos>0);

