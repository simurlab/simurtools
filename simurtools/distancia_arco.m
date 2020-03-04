% DISTANCIA_ARCO Calcula la distancia recorrida en un paso basandose en el modelo de movimiento angular 
% a velocidad constante
%
% DISTANCIA_ARCO Aplica el modelo de movimiento angular a velocida constante que relaciona la distancia
% recorrida con la aceleraci�n normal en el instante de foot flat. Este m�todo est� basado en los trabajos 
% realizados por VTI 
% 
% Esta funci�n es incompatible con la funci�n del mismo nombre disponible en SilopToolbox v0.2 o anterior.
% 
% Syntax: 
%   function distancia=distancia_arco(AccVert, freq, pierna)
%
%   Par�metros de entrada:
%                 AccVert    - vector con la aceleraci�n vertical del paso a estudiar. Esta aceleraci�n debe 
%                              comenzar 0.1s antes del inicio del paso y terminar 0.1s despues del final del paso
%                 freq       - frecuencia de muestreo. Opcional, por
%                              defecto vale 100Hz. Se conserva entre llamadas
%                 pierna     - longitud de la pierna (radio de la circunferencia descrita por el COG). Es opcional, 
%                              por defecto vale 1m y se conserva entre
%                              llamadas
%   Par�metros de salida:
%                 distancia  - distancia recorrida
% 
% Examples: 
%   
%
% See also: distancia_raizcuarta, distancia_pendulo, distancia_penduloparcial

% Author:   Diego �lvarez
% History:  ??.??.200? creado
%           12.12.2007 adaptado para trabajar con los datos de un �nico paso y 
%                      funcionar on-line. Incompatible con versiones anteriores
%


function distancia=distancia_arco(AccVert,freq,pierna)

persistent SILOP_distanciaarco
if (isempty(SILOP_distanciaarco))
    SILOP_distanciaarco.freq=100;
    SILOP_distanciaarco.pierna=1;
end

%Longitud de la pierna por defecto si no se proporciona el par�metro 
if (nargin>1)
    SILOP_distanciaarco.freq=freq;
    if (nargin>2)
        SILOP_distanciaarco.pierna=pierna;
    end
end

b=ones(1,ceil(SILOP_distanciaarco.freq/10))/ceil(SILOP_distanciaarco.freq/10);
AccVert=filter(b,1,AccVert);

   minima=min(AccVert);
   velocidad=sqrt(SILOP_distanciaarco.pierna)*sqrt(9.81-minima);
   tiempo=length(AccVert)/SILOP_distanciaarco.freq;
   distancia=velocidad*tiempo;

