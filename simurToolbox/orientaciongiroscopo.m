% ORIENTACIONGIROSCOPO Calcula la orientación en base a los datos de un giróscopo situado en el COG
%
% ORIENTACIONGIROSCOPO Realiza una integral simple de la señal del giro en el eje vertical. La función
% conserva los valores de la orientación y la frecuencia de captura entre llamadas, por lo que no 
% tienen que ser proporcionados esos valores cada vez que es llamada.
% 
% 
% Syntax: 
%   function angulo=orientaciongiroscopo(velgiro, angulo0, freq)
%
%   Parámetros de entrada:
%                 velgiro    - vector con la velocidad de giro respecto al eje vertical en cada periodo
%                              de muestreo. Puede contener cualquier número
%                              de muestras
%                 angulo0    - valor del ángulo inicial. Si no se proporciona la función lo inicializa a cero
%                              El angulo se conserva final se conserva para
%                              la siguiente llamada
%                 freq       - frecuencia de muestreo. Si no se proporciona, en la primera llamada se inicializa a 100Hz
%                              Se conserva entre llamadas.
%   Parámetros de salida:
%                 distancia  - vector con el angulo correspondiente a cada
%                              instante del vector velgiro
% 
% Examples: 
%   
%
% See also: orientacionbrujula, orientacionKalman

% Author:   Diego Álvarez
% History:  ??.??.200? creado
%           13.12.2007 adaptado para trabajar on-line y documentado
%


function angulo=orientaciongiroscopo(velgiro,angulo0,freq)

persistent SILOP_orientaciongiroscopo
if (isempty(SILOP_orientaciongiroscopo))
    SILOP_orientaciongiroscopo.angulo0=0;
    SILOP_orientaciongiroscopo.freq=100;
end

if (nargin>1)
  SILOP_orientaciongiroscopo.angulo0=angulo0;
  if (nargin>2)
	SILOP_orientaciongiroscopo.freq=freq;
  else 
	SILOP_orientaciongiroscopo.freq=100;
  end
end

angulo=cumsum(velgiro)/SILOP_orientaciongiroscopo.freq;
angulo=angulo+SILOP_orientaciongiroscopo.angulo0;
SILOP_orientaciongiroscopo.angulo0=angulo(end);