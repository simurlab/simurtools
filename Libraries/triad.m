%TRIAD Algoritmo para la estimacion de la rotacion mediante el triad.
%  Esta version es solo apropiada para posiciones estaticas. 
%
%Se usa:
% R=triad(acc, mg, acc0, mg0)
%
%Parametros: 
%   acc=[acc_x, acc_y, acc_z] vector con los tres valores de aceleracion
%   mg= [mg_x, mg_y, mg_z], vector con los tres valores del campo magnetico
%   acc0=[acc_x0, acc_y0, acc_z0] vector con los valores de acc de rotación 0
%   mg0= [mg_x0, mg_y0, mg_z0] vector con los valores del campo magnitico a
%                              rotación 0
%
%   R matriz de rotación que convierte de los ejes actuales a los
%                iniciales.
%Creado: 29-07-2019 por Diego

function R=triad(acc,mg,acc0,mg0)
    V1=acc/norm(acc);
    tmp=mg/norm(mg);
    V2=cross(V1,tmp);
    V2=V2/norm(V2);
    V3=cross(V1,V2);
    V=[V1',V2',V3'];
        
    v1=acc0/norm(acc0);
    tmp=mg0/norm(mg0);
    v2=cross(v1,tmp);
    v2=v2/norm(v2);
    v3=cross(v1,v2);
    v=[v1',v2',v3'];
        
    R=v*inv(V);
        
    
    
    
    
        
   
    

    
