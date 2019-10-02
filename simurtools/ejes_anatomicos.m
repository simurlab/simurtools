% EJES_ANATOMICOS Reorienta los datos obtenidos para que coincidan con los ejes anat�micos.
%
% EJES_ANATOMICOS Tomando como base una se�al, en la que los instantes iniciales la �nica aceleraci�n es la de la gravedad realinea los ejes de referencia para que las aceleraciones se correspondan con los ejes antero-posterior, medio-lateral y vertical.
%
% Sintax: [acc_c,RR]=ejes_anatomicos(acc,acc_parcial,R)
%
% Par�metros de entrada:
%    acc           - matriz con todos los datos de las tres aceleraciones del sensor
%    acc_parcial   - matriz con las aceleraciones correspondientes al intervalo a 
%                    estudiar
%    R             - Matriz de rotacion opcional que transforma los datos de los ejes del
%		     acelerometro a la referencia anat�mica teorica. Soporta tres formatos
%                     1) si no se incluye el par�metro se supone que esta en la posici�n estandar
%                     2) si se incluye un vector con tres n�meros se debe indicar cual de los ejes
%                        de los aceler�metros se corresponde con la aceleraci�n antero-posterior,
%                        medio-lateral y vertical respectivamente
%                     3) si se proporciona una matriz 3x3 debe ser la matriz de rotaci�n que convierte
%                        los ejes de forma directa
%
% Par�metros de salida:
%    acc_c          - una matriz que contine las tres aceleraciones referidas a los ejes anat�micos.
%                     En la primera columna esta la aceleraci�n en la direcci�n anteroposterior (positivo en 
%                     sentido anterior). En la segunda columna la aceleraci�n en la direccion medio-lateral 
%                     (positivo en sentido medial desde la derecha) y en la tercera columna la aceleraci�n 
%                     vertical (positivo hacia arriba)
%    RR             - Opcionalmente se devuelve la matriz de rotacion total, que transforma los datos iniciales 
%                     a los ejes anatomicos. Si los datos estan en forma de vectores fila (n x 3) la forma de 
%                     obtener los datos referidos a los ejes anat�micos ser�a hacer la multiplicacion 
%                     dat_anat=(datos_sensor*RR')
% Examples:
%

% Author:   Rafael C. 
% History:  12.11.2000  file created
%                       full description at the top
%           19.11.2000  suggestions for in-code comments added
%           12.12.2007  Adaptada correctamente a la toolbox.



function [datos_c,RR]=ejes_anatomicos(datos1,datos2,R)

if (nargin==2)
	R=[3,-2,1]; %Orden estandar
end
[tam1,tam2]=size(R);
if (tam1*tam2==3)
	orden=R;
	R=zeros(3,3);
	for k=1:3
		R(k,abs(orden(k)))=sign(orden(k)); 
	end;
else if (tam1*tam2==9)
	%R=R;
else
	error('Matriz R de formato incorrecto');
    end

end

% Ordenar los ejes de los datos
datos1=datos1*R';
datos2=datos2*R';

% Calculamos la direccion de la gravedad como la suma vectorial del valor 
% medio de las aceleraciones dividido por el modulo
ug=mean(datos2,1)/norm(mean(datos2,1));

% Hacemos una rotacion en torno al eje Z (direccion vertical) para que en
% el nuevo sistema de coordenadas las aceleracion de la gravedad quede
% comprendida en el plano sagital (X,Z)

proy_ug=[ug(1) ug(2)]; % Proyeccion de la gravedad sobre el plano XY
proy_ug=proy_ug/norm(proy_ug); % Vector unitario en la direccion de la proyeccion
c1=proy_ug(1);
c2=proy_ug(2);

% Se gira para anular la componente mas cercana a cero
if (abs(c1)>abs(c2))
    % Se gira para hacer la componente Y=0;
    if (c1>0)
	Rz=[c1 c2 0;-(c2) c1 0;0 0 1];
    else
	Rz=[-c1 -(c2) 0;  c2 -c1 0; 0 0 1];
    end
    datos_c=datos1*Rz';datos2=datos2*Rz';
    
    % Hacer una rotacion respecto del eje mediolateral (Y) para anular la
    % componente anteroposterior de la gravedad
    ug=mean(datos2,1)/norm(mean(datos2,1));
    %g=norm(mean(datos2));

    % Tomar la proyeccion de ug sobre el plano sagital
    %proy_ug=[ug(1) ug(3)];
    %proy_ug=proy_ug/norm(proy_ug);
    c1=ug(1);
    c3=ug(3);

    Ry=[c3 0 -(c1); 0 1 0; c1 0 c3];

    datos_c=datos_c*Ry';
    RR=Ry*Rz*R;
else
    % se gira para anular la componente en x
    
    % Se gira para hacer la componente Y=0;
    if (c2>0)
        Rz=[c2 -(c1) 0;  c1 c2 0; 0 0 1];
    else
        Rz=[-c2 c1 0; -(c1) -c2 0; 0 0 1];
    end
    datos_c=datos1*Rz';
    datos2=datos2*Rz';
    
    % Hacer una rotacion respecto del eje mediolateral (Y) para anular la
    % componente anteroposterior de la gravedad

    ug=mean(datos2,1)/norm(mean(datos2,1));
    %g=norm(mean(datos2));

    % Tomar la proyeccion de ug sobre el plano sagital
    %proy_ug=[ug(2) ug(3)];
    %proy_ug=proy_ug/norm(proy_ug);
    c2=ug(2);
    c3=ug(3);

    Rx=[1 0 0; 0  c3 -(c2);0  c2 c3];

    datos_c=datos_c*Rx';
    RR=Rx*Rz*R;
end
