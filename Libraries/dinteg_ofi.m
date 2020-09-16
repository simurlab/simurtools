% dinteg_ofi   Realiza la doble integral de una aceleracion mediante el metodo de OFI, 
%                     para obtener una velocidad suponiendo:
%   1) que la aceleración tiene media cero. (velocidad final igual a la
%      inicial)
%   2) que los valores inicial y final de aceleración son aproximadamente
%      cero para no incluir una distorsión por el filtro paso alto. 
% 
% Syntax: pos=dinteg_ofi(acc,freq)
% 
% Input parameters:
%   acc-> signal de aceleracion
%   freq-> frecuencia de muestreo
%
% Output parameters:
%   pos<- señal de posición
%
% Examples: 
%
% See also: dinteg_lri, dinteg_msi, dinteg_cms, dinteg_ddi

% Author:   Diego
% History:  renaming, JC 30-11-2019


function pos=dinteg_ofi(acc,freq)

%%Este método supone: 
%%1) que la aceleración tiene media cero. (velocidad final igual a la
%%inicial)
%%2) que los valores inicial y final de aceleración son aproximadamente
%%cero para no incluir una distorsión por el filtro paso alto. 

%y operamos sobre cada uno de ellos

    %Se calcula la velocidad mediante el método OFRDI 
    %Determinamos el rango de frecuencias para el filtro. 
    % Filtro desde 0.01 hasta 0.15Hz en intervalos de 0.01. 
    
  
    %Cálculo de la frecuencia óptima de filtrado.
    rango=0.01:0.01:0.15;
    error=Inf;
    for f=1:length(rango)
        [b,a]=butter(2,rango(f)/(freq/2),'high');
        acc_filt=filter(b,a,acc);
        vel_filt=cumcamsimp(acc_filt/freq);
        %Buscamos velocidades finales menores de 5e-3.
        if (abs(vel_filt(end))<0.1)%Con 5e-3 no pasa ninguna
            pos_filt=cumcamsimp(vel_filt/freq);
            error_filt=abs(pos_filt(end));
            if (error_filt<error) 
                error=error_filt;
                f_ok=rango(f);
                vel_ok=vel_filt;
                pos_ok=pos_filt;
            end
        end    
    end
    %La frecuencia óptima según el método es f_ok
    %Obtención de las velocidades directa e inversa
    [b,a]=butter(2,f_ok/(freq/2),'high');
    acc_filt=filter(b,a,acc);
    vel_d=cumcamsimp(acc_filt/freq);
    vel_r=0*vel_d;
    vel_r(end:-1:1)=cumcamsimp(-acc_filt(end:-1:1)/freq);
    %Calculamos la función de peso
    l=length(vel_r);%=length(vel_l);
    tiempo=1:l;
    Beta=0.1; 
    s=atan(1/Beta*(2*tiempo'-l)/(2*l));
    w=(s-s(1))/(s(end)-s(1));
    %Y la aplicamos
    vel_dri=vel_r.*w+vel_d.*(1-w);
    
    %y finalmente integramos para obtener la posición. Aquí no se hace
    %directa e inversa, ya que el valor final no tiene que ser cero. 
    pos=cumcamsimp(vel_dri/freq);
    

