% BUSCAMAXIMOS Detecta todos los m�ximos de una se�al despu�s de aplicar un threshold
%
% BUSCAMAXIMOS Detecta todos los m�ximos de una se�al despu�s de aplicar un threshold
% 
% Syntax: maximos=buscamaximosth(datos,th)
% 
% Input parameters:
%   datos-> se�al en la que se buscar�n los m�ximos
%   th   -> umbral por debajo del cual un punto no se considerar� m�ximo de la se�al
%
% Output parameters:
%   maximos<- se�al del mismo tama�o que datos, en la que aparece un 1 en la posici�n de cada
%  		m�ximo y un 0 en el resto de instantes.
%
% Examples:
%
% See also: buscamaximos

function maximos=buscamaximosth(Datos,th)

%% Algoritmo: primero se convierte la se�al en una rectangular, con unos en las
%% pendientes positivas y ceros en las negativas.
%% Luego se repite la operaci�n para la se�al rectangular, con lo que
%% queda una con pulsos de valores +1 (en las transiciones de 0 a 1) y 
%% -1 (en las transiciones de 1 a 0). Los pulsos +1 son los m�ximos.

tam=size(Datos);
tam=tam(1);

%% Obtenci�n de la se�al rectangular:
Datos2=Datos(2:tam)-Datos(1:tam-1);
Datos2=Datos2>=0;

%% Obtenci�n de las se�al de pulsos:
Datos2=Datos2(1:tam-2)-Datos2(2:tam-1);

%% los m�ximos son los pulsos positivos:
%%maximos=Datos>0;

for i=1:(tam-2),
    maximos(i)=0; %#ok<AGROW>
    if (Datos2(i)>0) && (Datos(i+1)>th)
        maximos(i)=1; %#ok<AGROW>
    end
end
