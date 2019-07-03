% CUMCAMSIMP   Realiza la integral numérica de cavalieri-simpson. 
%  y(t)=y(t-1)+1/6(x(t-1)+4x(t)+x(t+1))
%
%
% Syntax: p=cumcamsimp(v)
% 
% Input parameters:
%   v-> señal a integrar
%
% Output parameters:
%   p<- señal integrada
%
% Examples: 
%
% See also: 

% Author:   Diego
% History:  


function [ p ] = cumcamsimp( v )
%cumcamsimp Extiende la idea de cumsum y cumtrapz para realizar la integral
%   mediante la aproximación de cavalieri-simpson.
v=[0;0;v;0;0];

p=zeros(length(v)-1,1);

for k=2:(length(v)-1)
    p(k)=p(k-1)+1/6*(v(k-1)+4*v(k)+v(k+1));
end

