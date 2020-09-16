% DISTANCIA_RAIZCUARTA Calcula la distancia recorrida en un paso mediante el modelo emp�rico de la raiz cuarta
%
% DISTANCIA_RAIZCUARTA Aplica el modelo emp�rico que relaciona la distancia recorrida en un paso con la 
% raiz cuarta de la amplitud de la aceleraci�n vertical. 
% 
% Esta funci�n es incompatible con la funci�n del mismo nombre disponible en SilopToolbox v0.2 o anterior
% 
% Syntax: 
%   function distancia=distancia_raizcuarta(AccVert)
%
%   Par�metros de entrada:
%                 AccVert    - vector con la aceleraci�n vertical del paso a estudiar. Esta aceleraci�n debe estar 
%                              filtrada mediante un filtro paso bajo a 3Hz. (Por ejemplo mediante 
%                              filtro0(AccVert,26,0.06) si estamos trabajando offline)
% 
% Examples: 
%   
%
% See also: distancia_recto, distancia_raizcuarta_offline, distancia_arco, distancia_pendulo, distancia_penduloparcial

% Author:   Diego �lvarez
% History:  ??.??.200? creado
%           12.12.2007 adaptado para trabajar con los datos de un �nico paso y 
%                      funcionar on-line. Incompatible con versiones anteriores
%


function distancia=distancia_raizcuarta(AccVert)

  %Paso a paso. Doble integral
   vertical=max(AccVert)-min(AccVert);
	distancia=vertical.^0.25;
