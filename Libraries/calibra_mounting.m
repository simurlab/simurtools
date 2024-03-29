% CALIBRA_MOUNTING Calibracion estatica con accs y mags, metodo TRIAD.
%
% CALIBRA_MOUNTING El procedimiento se explica con m�s detalle en el doc. 
% Se coloca el sensor en (6) posiciones static, se selecciona una ventana 
% en la que la signal no varie, y se trabaja con los valores medios.
% Devuelve una matriz de rotacion o de calibracion.
%
% Example:
%   Mrot=calibra_mounting(AccXsens, MagXsens, num_posiciones, t_movimiento, vCALIBRA, k_inicial, f_s, t_espera_calibra);
%   accs_cal=(Mrot*AccXsens(1:end,:)')';
%
%    See also CALIBRA_EJEX.

% Historial de Modificaciones: 
%  Desarrollado por JC.
%  Modificado por: Diego, 24-ene-07 -> adaptacion del codigo a siloptoolbox
%  Modificad por : JC, 12-nov-19 -> adaptacion a v0.3
%  Modificad por : JC, 3-dic-19 -> adaptacion a v0.12


function [fROT] = calibra_mounting(AccXsens, MagXsens, num_posiciones, t_movimiento, vCALIBRA, k_inicial, f_s, t_espera_calibra)

% Inicializando variables:

% Poner a 1 para debugear:
pintamonos=0;

zona_util=30/100;   % fraccion del intervalo que NO se utilizara
k_espera_calibra=floor(f_s*t_espera_calibra); % lo mismo, pero en muestras
k_movimiento=floor(f_s*t_movimiento); % lo mismo, pero en muestras
rot_accs=AccXsens;
% Definicion de la zona util para calibrar, en muestras:
frac_bloque=floor((zona_util)*k_espera_calibra);
% Por si quisieramos cambiar los ejes de la posici?nm inicial del sensor:
vINIPOS(1,:)=[ 1  0  0   0  1  0   0  0  1];
%M0=vec2mat(vINIPOS(1,:),3);
M0=reshape(vINIPOS(1,:),3,[]);

%% Proceso en si mismo:
ini_cpos(1)=k_inicial;
for cpos=1:num_posiciones
    % Zona total de la posici?n i (ini_cpos, fin_cpos): 
    k_bloque(cpos)=k_movimiento(cpos)+k_espera_calibra;
    fin_cpos=ini_cpos(cpos)+k_bloque(cpos);
    
    % Subzona util para calibrar (ini, fin):
    ini=(ini_cpos(cpos)+k_movimiento(cpos))+frac_bloque;
    fin=fin_cpos-floor(frac_bloque/4);
    [cpos ini_cpos(cpos) ini fin fin_cpos];
    
    % valores medios de accs y mags:
    acc_pos=mean(AccXsens(ini:fin,:));
    mag_pos=mean(MagXsens(ini:fin,:));
    % vectores unitarios de accs y mags:
    vacc(cpos,:)=acc_pos/norm(acc_pos);
    vmag(cpos,:)=mag_pos/norm(mag_pos);
    
    % METODO TRIAD:    
    zlocal=vacc(cpos,:);
    ylocal=cross(vacc(cpos,:),vmag(cpos,:));
    xlocal=cross(ylocal,zlocal);
    % guardamos la matriz completa en forma de vector:
    vROTA(cpos,:)=[xlocal ylocal zlocal];
    % y en forma de matriz:
    mROTMini=[xlocal' ylocal' zlocal'];
    % mROTMini=vec2mat(vROTA(cpos,:),3)';
    mROTM=mROTMini*reshape(vCALIBRA(cpos,:),3,[])'*M0;
    ROTACOMPLETA(cpos,:)=reshape(mROTM',[],9);
    
    % dibujo de las accs originales vs las calibradas:
    rot_accs(ini_cpos(cpos):fin_cpos,:)=(mROTM'*AccXsens(ini_cpos(cpos):fin_cpos,:)')';
    % Para debugear se pintan las senyales y las ventanas utilies:
    if (pintamonos==1),
        figure(cpos); subplot(311);
        plot(AccXsens); axis([ini_cpos(cpos) fin_cpos -10 10]); grid; 
        line([ini_cpos(cpos)+k_movimiento(cpos) ini_cpos(cpos)+k_movimiento(cpos)],[-10 10]);
        line([ini ini],[-10 10]);
        line([fin fin],[-10 10]);
        subplot(312);
        plot(MagXsens); axis([ini_cpos(cpos) fin_cpos -10 10]); grid; 
        line([ini_cpos(cpos)+k_movimiento(cpos) ini_cpos(cpos)+k_movimiento(cpos)],[-10 10]);
        line([ini ini],[-10 10]);
        line([fin fin],[-10 10]);
        subplot(313);
        plot(rot_accs); axis([ini_cpos(cpos) fin_cpos -10 10]); grid; 
        %input('PAUSA... dale al RETURN para seguir...');
    end
    ini_cpos(cpos+1)=ini_cpos(cpos)+(k_bloque(cpos));
end

fin_cpos=fin_cpos+800;
fROT=mROTM';
% Uso: accs_cal=(mROTM'*AccXsens(1:end,:)')';

end

