% DISTANCIA_PENDULO Calcula la distancia recorrida en un paso mediante el modelo del pendulo invertido desde el COG
%
% DISTANCIA_PENDULO Aplica el modelo del pendulo invertido para calcular el desplazamiento horizontal
% en funci�n del desplazamiento vertical. Puede aplicar o no una correcci�n para eliminar la media de las 
% aceleraciones verticales, lo que es necesario para los casos en los que el drift de la integral es importante.
% 
% Esta funci�n es incompatible con la funci�n del mismo nombre disponible en SilopToolbox v0.2 o anterior
% 
% Syntax: 
%   function distancia=distancia_pendulo(AccVert, freq, pierna, correccion)
%
%   Par�metros de entrada:
%                 AccVert    - vector con la aceleraci�n vertical del paso a estudiar
%                 freq       - frecuencia de muestreo. Es opcional, por
%                              defecto vale 100Hz. Se conserva entre llamadas
%                 pierna     - longitud de la pierna (longitud del arco recorrido por el COG). Es opcional
%                              y por defecto vale 0.8m. Se conserva entre
%                              llamadas.
%                 correccion - bandera que indica si se debe eliminar la media de las se�ales para 
%                              reducir el drift. Es opcional, por defecto
%                              se aplica la correcci�n (correccion=1); Se
%                              conserva entre llamadas
% 
% Examples: 
%   
%
% See also: distancia_penduloparcial, distancia_arco, distancia_raizcuarta

% Author:   Diego �lvarez
% History:  ??.??.200? creado
%           12.12.2007 adaptado para trabajar con los datos de un �nico paso y 
%                      funcionar on-line. Incompatible con versiones anteriores
%           03.01.2007 corregida la frecuencia por defecto a 100Hz


function distancia=distancia_pendulo(AccVert,freq,pierna,correccion)

persistent SILOP_distanciapendulo
if (isempty(SILOP_distanciapendulo))
    SILOP_distanciapendulo.freq=100;
    SILOP_distanciapendulo.pierna=0.8;
    SILOP_distanciapendulo.correccion=1;
end

%Longitud de la pierna por defecto si no se proporciona el par�metro 
if (nargin>1)
    SILOP_distanciapendulo.freq=freq;
    if (nargin>2)
        SILOP_distanciapendulo.pierna=pierna;
        if (nargin>3)
            SILOP_distanciapendulo.correccion=correccion;
        end
    end
end


%Se calcula el desplazamienot vertical
%vertical=[];
%Paso a paso. Doble integral
aceleracion=AccVert;
aceleracion=aceleracion-SILOP_distanciapendulo.correccion*mean(aceleracion);%Correcci�n
velocidad=cumsum(aceleracion)/SILOP_distanciapendulo.freq;
velocidad=velocidad-SILOP_distanciapendulo.correccion*mean(velocidad);
verticaltiempo=cumsum(velocidad)/SILOP_distanciapendulo.freq;
vertical=max(verticaltiempo)-min(verticaltiempo);

%El maximo es como protecci�n para los casos en los que sale un desplazamiento negativo
%algo que no deber�a ocurrir nunca.
distancia=2*sqrt(max(0,2*SILOP_distanciapendulo.pierna*vertical-vertical^2));
