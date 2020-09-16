% ORIENTACIONCOMPAS Calcula la orientación en base a los datos de una brújula/compás situada en el COG
%
% ORIENTACIONCOMPAS Calcula la orientación en base al vector magnético existente en cada instante.
% También calcula si dicho vector está señalando fuera del plano horizontal, en cuyo caso su
% lectura no resultará fiable.
% 
% 
% Syntax: 
%   function [angulo,fiable]=orientacioncompas(campox,campoy,campoz)
%
%   Parámetros de entrada:
%                 campox    - componente x(antero-posterior) del vector magnético. 
%                 campoy    - componente y(medio-lateral) del vector magnético. 
%                 campoz    - componente z(vertical) del vector magnético.
%                 angulo0   - valor a ser restado del angulo obtenido por
%                             el campo, de forma que se puedan hacer
%                             medidas diferenciales. Por defecto vale 0. Se
%                             conserva entre llamadas a la funcion
%   Parámetros de salida:
%                 angulo  - vector con el angulo correspondiente a cada instante
%                 fiable  - vector indicando si el campo es fiable (1) o no
%                           (0), en cada instante
% 
% Examples: 
%   
%
% See also: orientaciongiroscopo, orientacionKalman

% Author:   Diego Álvarez
% History:  ??.??.200? creado
%           13.12.2007 adaptado para trabajar on-line y documentado
%


function [angulo,fiable]=orientacioncompas(campox,campoy,campoz,angulo0)

persistent SILOP_orientacioncompas
if (isempty(SILOP_orientacioncompas))
    SILOP_orientacioncompas.angulo0=0;
end

if (nargin>3)
  SILOP_orientacioncompas.angulo0=angulo0;
end


angulo=unwrap(atan2(campoy,campox));
angulo=angulo-SILOP_orientacioncompas.angulo0;
    
fiable=(campoz<1 & campoz>-1);
    
    
