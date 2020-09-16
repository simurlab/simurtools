% CARGAR_DATOS_SILOP Leer un archivo de datos en formato silop, extension
% '.sl'
%
% Syntax: 
%   [medicion]= carga_datos_silop(file)
% 
% Input parameters:
%   file-> nombre del archivo
%
% Output parameters:
%   medicion<- Datos leidos. Es un cell array con cada elemento haciendo
%                            referencia a los datos de un sensor
%
% Examples:
%   medicion=cargar_datos_xsens('fede.sl')
%
% See also: cargar_datos_camara, carga_datos_xsens, carga_datos_shimmer

% History:
% Created by Diego on 2019/11/12 


function [medicion] = cargar_datos_silop(filename)

if (nargin<1)
	error('se debe incluir el nombre del fichero como parametro');
end
existe=dir(filename);
if (isempty(existe))
	error('no se encuentra el fichero');
end

unzip(filename);
warning off  %Cambios entre versiones de Matlab
tmp=load('config.mat');
warning on
delete('config.mat');
load('datos.log'); %#ok<LOAD>
delete('datos.log');
existe=dir('datos_alg.log');
datos_alg=[];
if (~isempty(existe))
    load('datos_alg.log'); %#ok<LOAD>
    delete('datos_alg.log');
end
captura=[datos,datos_alg];
[~,tam]=size(datos); %tam indica los datos de los sensores.
freq=tmp.SILOP_CONFIG.BUS.Xbus.freq;
tmp=tmp.SILOP_CONFIG.SENHALES;

sensores = fieldnames(tmp);
for k=2:numel(sensores)
   medicion{k-1}=struct();  %#ok<AGROW>
   sensor=tmp.(sensores{k});
   names=fieldnames(sensor);
   medicion{k-1}.nombre=sensores{k};
   medicion{k-1}.tiempo=captura(:,1)/freq; %#ok<AGROW>
   for kk=3:numel(names)
       if (sensor.(names{kk})<=tam)
           %Este if es para descartar los datos de algoritmos
           if (strcmp(names{kk},'Acc_X'))
               medicion{k-1}.Accel(:,1)=captura(:,sensor.(names{kk}));
           elseif (strcmp(names{kk},'Acc_Y'))
               medicion{k-1}.Accel(:,2)=captura(:,sensor.(names{kk}));
           elseif (strcmp(names{kk},'Acc_Z'))
               medicion{k-1}.Accel(:,3)=captura(:,sensor.(names{kk}));
           elseif (strcmp(names{kk},'G_X'))
               medicion{k-1}.Gyro(:,1)=captura(:,sensor.(names{kk}));
           elseif (strcmp(names{kk},'G_Y'))
               medicion{k-1}.Gyro(:,2)=captura(:,sensor.(names{kk}));
           elseif (strcmp(names{kk},'G_Z'))
               medicion{k-1}.Gyro(:,3)=captura(:,sensor.(names{kk}));
           elseif (strcmp(names{kk},'MG_X'))
               medicion{k-1}.Mag(:,1)=captura(:,sensor.(names{kk}));
           elseif (strcmp(names{kk},'MG_Y'))
               medicion{k-1}.Mag(:,2)=captura(:,sensor.(names{kk}));
           elseif (strcmp(names{kk},'MG_Z'))
               medicion{k-1}.Mag(:,3)=captura(:,sensor.(names{kk}));
           else
              warning('señal no detectada correctamente');
           end
       end
   end
end
%Nos queda eliminar del cell array los no sensores.
for k=length(medicion):-1:1
   if length(fieldnames(medicion{k}))==2 %Solo está el tiempo y el nombre
           medicion(k)=[];
   end
end

