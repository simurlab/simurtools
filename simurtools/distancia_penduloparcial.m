% DISTANCIA_PENDULOPARCIAL Calcula la distancia recorrida en un paso mediante el modelo del pendulo invertido 
% mas desplazamiento.
%
% DISTANCIA_PENDULOPARCIAL Aplica el modelo del pendulo invertido para calcular el desplazamiento horizontal
% en funci�n del desplazamiento vertical durante la fase de single stance del paso. 
% Durante la fase de double stance supone un desplazamiento constante igual al tama�o de pie indicado.
% Aplica una correcci�n para eliminar la media de las 
% aceleraciones verticales, lo que es necesario para los casos en los que el drift de la integral es importante.
% 
% Esta funci�n es incompatible con la funci�n del mismo nombre disponible en SilopToolbox v0.2 o anterior
% 
% Syntax: 
%   function distancia=distancia_penduloparcial(AccVert,TO, freq, hsensor, pie, KSP)
%
%   Par�metros de entrada:
%                 AccVert    - vector con la aceleraci�n vertical del paso a estudiar
%                 TO         - n�mero de muestra de la se�al que se corresponde con el TO
%                              Si TO es de dimension 3, es que se integra una zancada, entonces, TO(1) es el
%                              contacto final contralateral, TO(2) es el contacto inicial contralateral y
%                              TO(3) es el contacto final ipsilateral.
%                 freq       - frecuencia de muestreo
%                 hsensor    - altura del sensor (Distancia desde el maleolo hasta el sensor). Es opcional
%                              y por defecto vale 0.8m
%                 pie        - longitud del pie. Es opcional y por defecto vale 0.15m
%                 KSP        - factor de correcci�n debido a la distancia entre el sensor y el final de la pierna.
%                              Es opcional y por defecto vale 1 (como si se midiese la distancia desde el maleolo
%                              hasta el trocanter).
% 
% Examples: 
%   
%
% See also: distancia_pendulo, distancia_arco, distancia_raizcuarta

% Author:   Diego �lvarez, Rafael C. Gonzalez de los Reyes
% History:  ??.??.200? creado
%           04.12.2007 adaptado para trabajar con los datos de un �nico paso y 
%                      funcionar on-line. por Rafa
% History:  12.12.07  adaptaci�n final a la toolbox
%           03.01.08  corregida la frecuencia por defecto a 100Hz


function distancia=distancia_penduloparcial(AccVert, TO, freq, hsensor, pie, KSP)

persistent SILOP_penduloparcial
if (isempty(SILOP_penduloparcial))
    SILOP_penduloparcial.freq=0;
    SILOP_penduloparcial.hsensor=0.8;
    SILOP_penduloparcial.pie=0.15;
    SILOP_penduloparcial.KSP=1;
end

%Longitud de la pierna por defecto si no se proporciona el par�metro 
if (nargin>2)
    SILOP_penduloparcial.freq=freq;
    if (nargin>3)
        SILOP_penduloparcial.hsensor=hsensor;
        if (nargin>4)
            SILOP_penduloparcial.pie=pie;
            if (nargin>5)
                SILOP_penduloparcial.KSP=KSP;
            end
        end
    end
end

if (length(TO)==1)
    %Paso a paso. Doble integral
    %aceleracion=AccVert(TO:end)-mean(AccVert);
    % Eliminamos el valor medio para imponer la condicion de que los valores
    % inicial y final de la velocidad son los mismos
    aceleracionhs=AccVert-mean(AccVert);
    %Primera integral
    velocidadhs=cumsum(aceleracionhs)/SILOP_penduloparcial.freq;
    %Segunda correccion
    %Eliminamos el valor medio de la velocidad para imponer la condicion de
    %contorno de que la altura inicial y final del COG es la misma.
    velocidadhs=velocidadhs-mean(velocidadhs);
    %Segunda integral
    verticaltiempo=cumsum(velocidadhs)/SILOP_penduloparcial.freq;

    %Buscamos la
    %variacion m�xima en desplazamiento vertical
    %entre el toe-off contralateral y el siguiente heel-strike
    vertical=max(verticaltiempo(TO:end))-min(verticaltiempo(TO:end));

    if SILOP_penduloparcial.hsensor~=0
        sl=SILOP_penduloparcial.KSP*2*sqrt(2*SILOP_penduloparcial.hsensor*vertical-vertical.^2)+SILOP_penduloparcial.pie;%Tama�o de pie medio
        %   if (~isreal(sl))
        %       sl
        %       keyboard
        %   end
    else
        sl=SILOP_penduloparcial.pie;
    end

    % sl=sl;
else
    %Paso a paso. Doble integral
    %aceleracion=AccVert(TO:end)-mean(AccVert);
    % Eliminamos el valor medio para imponer la condicion de que los valores
    % inicial y final de la velocidad son los mismos
    aceleracionhs=AccVert-mean(AccVert);
    %Primera integral
    velocidadhs=cumsum(aceleracionhs)/SILOP_penduloparcial.freq;
    %Segunda correccion
    %Eliminamos el valor medio de la velocidad para imponer la condicion de
    %contorno de que la altura inicial y final del COG es la misma.
    velocidadhs=velocidadhs-mean(velocidadhs);
    %Segunda integral
    verticaltiempo=cumsum(velocidadhs)/SILOP_penduloparcial.freq;

    %Buscamos la
    %variacion m�xima en desplazamiento vertical
    %entre el toe-off contralateral y el siguiente heel-strike
    vertical=[max(verticaltiempo(TO(1):TO(2)))-min(verticaltiempo(TO(1):TO(2))), ...
              max(verticaltiempo(TO(3):end))-min(verticaltiempo(TO(3):end))];
    if SILOP_penduloparcial.hsensor~=0
        sl=SILOP_penduloparcial.KSP*2*sqrt(2*SILOP_penduloparcial.hsensor*vertical-vertical.^2)+SILOP_penduloparcial.pie;%Tama�o de pie medio
    else
        sl=SILOP_penduloparcial.pie*ones(size(vertical));
    end
end
distancia=sl;



%C�digo antiguo de Diego
%se calcula el desplazamiento vertical
%   AccVertSS=AccVert(TO:end);
%   %Correcci�n en funci�n del paso de HS a HS+1
%   AccVertSS=AccVertSS-mean(AccVert);
%   AccVert=AccVert-mean(AccVert);
%	%Primera integral
%   VelSS=cumsum(AccVertSS)/freq;
%   vel=cumsum(AccVert)/freq;
%	%Segunda correccion
%   velSS=velSS-mean(vel);
%	%Segunda integral
%   verticaltiempo=cumsum(velSS)/freq;
% 
%   %variacion m�xima en desplazamiento vertical
%   vertical=max(verticaltiempo)-min(verticaltiempo);
%
%
%
%  distancia=2*sqrt(2*pierna*vertical-vertical^2)+pie;
%
%%distancia=sum(distancia);
