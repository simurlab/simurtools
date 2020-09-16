function P=psolido;
%% PSOLIDO 
% Estructura de datos que define un sólido rígido prismático por sus 8 vértices.
% Se guardan en una matriz P de 16 columnas de coordenadas cartesianas
% para que facilitar su representación con plot3.
% 

%% sólido con forma de cuña simétrica: 
% factor de puntiaguda que sea la cuña, entre cero y 0.5
def=0.45;
A = [0 0   0];
B = [1 0   0];
C = [def 1.5 0];
D = [0 0   0.5];
E = [def 1.5 0.5];
F = [1 0   0.5];
G = [1-def 1.5 0];
H = [1-def 1.5 0.5];

%% solido definido con sus 8 vertices:
% A = [0 0   0];
% B = [1.5 0   0];
% C = [0 1 0];
% D = [0 0   0.5];
% E = [0 1 0.5];
% F = [1.5 0   0.5];
% G = [0 1 0];
% H = [0 1 0.5];

% preferimos poner los puntos en columnas:
P = [A;B;F;H;G;C;A;D;E;H;F;D;E;C;G;B]';