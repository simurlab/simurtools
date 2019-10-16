% kin_irb120
%   Define la matriz de cinemática directa del robot ASEA IRB-120
%   en forma simbólica. los cinco ejes.
%   Se puede simular 5 o 6 ejes, en el parametro num_ejes

function Tirb120=kin_irb120(num_ejes)

if (nargin<1)
    num_ejes=5;
end

syms t0 t1 t2 t3 t4 t5
if num_ejes==5,
    theta = [t0 t1+(pi/2) t2 t3 t4];
    dof=5;
else
    theta = [t0 t1+(pi/2) t2 t3 t4 t5];
    dof = 6;
end

% Parámetros DH del ABB irb-120:
d = [290 0 0 302 0 72];
a = [0 -270 -70 0 0 0];
alpha = [-pi/2 0 pi/2 -pi/2 pi/2 0];


% Estructuras de datos:
T = cell(dof,1);
T_mult = cell(dof,1);
origins = [];
M = eye(4,4);

%% Matriz homogénea de cada eslabón:
for i = 1:dof
    T{i} = simplify(dhparam2matrix(theta(i), d(i), a(i), alpha(i))); 
    M = M*T{i};
    T_mult{i} = M;
end
% Matriz cinemática directa:
if num_ejes==5,
    Tirb120 = T{1}*T{2}*T{3}*T{4}*T{5};
else
    Tirb120 = T{1}*T{2}*T{3}*T{4}*T{5}*T{6};
end


end


function T = dhparam2matrix(theta, d, a, alpha)
    Rotz = [cos(theta) -sin(theta) 0 0; sin(theta) cos(theta) 0 0; 0 0 1 0; 0 0 0 1];
    Transz = [1 0 0 0; 0 1 0 0; 0 0 1 d; 0 0 0 1];
    Transx = [1 0 0 a; 0 1 0 0; 0 0 1 0; 0 0 0 1];
    Rotx = [1 0 0 0; 0 cos(alpha) -sin(alpha) 0; 0 sin(alpha) cos(alpha) 0; 0 0 0 1];
    T = Rotz*Transz*Transx*Rotx;
end