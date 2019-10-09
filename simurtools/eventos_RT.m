% EVENTOSRT Deteccion de Initial Contact y End Contact en Tiempo Real con acelerometro en
% el COG
%
% EVENTOSRT Esta funcion permite ser llamada de forma consecutiva para obtener los instantes de eventos de Contacto
% Inicial. Es IMPRESCINDIBLE que la se�al est� siendo capturada a 100HZ. Es necesario reinicializar las variables
% persistentes para cada experimento nuevo. 
% 
% Syntax:  [retardo_hs,retardo_to] = eventos_RT(ah,av,reset)
%
% Input parameters:
%    ah        - Valor de la ultima muestra de aceleracion antero-posterior
%    av        - Valor de la ultima muestra de aceleracion vertical
%    reset     - Si se usa un tercer par�metro, reinicia el proceso de captura y procesamiento.
%
% Output parameters:
%    retardo_hs   - 0 si no se ha detectado evento de Initial Contact. N > 0 si se ha detectado
%                   evento. En este caso N indica el retardo o distancia en muestras a la
%                   estimacion del evento respecto al instante actual.
%    retardo_to   - 0 si no se ha detectado evento de End Contact. N > 0 si se ha detectado
%                   evento. En este caso N indica el retardo o distancia en muestras a la
%                   estimacion del evento respecto al instante actual.
%
% Examples:
%
% See also: eventosCOGrecto

function[retardo_hs,retardo_to]=eventos_RT(ah,av,reset) %#ok<INUSD>

filtro=[0.0365 0.0374 0.0375 0.0382 0.0381 0.0385 0.0381 0.0382 0.0375 0.0374 0.0365]; %filtro de fase lineal con frecuancia de corte 2Hz
TROZO=200; %constante que indica el n�mero de muestras que se toman como m�ximo en RT
INTERVALO=11; %constante que indica el n� de muestras positivas que debe haber anteriormente al zero-crossing

%Paso 1: Tomar datos de individuo y paseo
persistent pers_datah; %se�al de aceleraci�n anteroposterior
persistent pers_data2; %se�al filtrada
persistent pers_datav; %se�al de aceleraci�n vertical
persistent pers_indice_ultimo_hs; %indice del ultimo hs

if (nargin>2)  %Implementacion del reset
	pers_datah=[];		
	pers_data2=[];
	pers_datav=[];
end

if(isempty(pers_indice_ultimo_hs))
   pers_indice_ultimo_hs=0; 
end
if(length(pers_datah)==TROZO)
    aux=2;
    pers_indice_ultimo_hs=pers_indice_ultimo_hs-1;
else
    aux=1;
end
pers_datah=[pers_datah(aux:end) ah]; %trozo de las ultimas 200 muestras de aceleracion antero-posterior
pers_datav=[pers_datav(aux:end) av]; %trozo de las ultimas 200 muestras de aceleracion vertical

%Calculo de la se�al filtrada
L=min([length(pers_datah),length(filtro)]); %longitud de la convolucion
valor=0; %variable en la que se guardar� la nueva muestra de se�al filtrada
for j=1:L
    valor=valor+filtro(j)*pers_datah(end-j+1); 
end
pers_data2=[pers_data2(aux:end) valor]; %trozo de las ultimas 200 muestras de la se�al filtrada

retardo_hs=0; %en principio no hay evento
retardo_to=0;
if(length(pers_datah)>INTERVALO)
   T=0;
   if(pers_data2(end)<0 && pers_data2(end-1)>0)
      %se produjo un zero-crossing
      %calcular periodo de la se�al
      if(aux==2) %si tenemos un trozo de 200
       auto=xcorr(pers_datah,TROZO,'unbiased');
       auto=auto(TROZO+1:end);
       pmax=localmaxima(auto'.*(auto'>0),20);
        if(length(pmax)<2)
            T=0; %no tenemos informacion suficiente para calcular periodo
        else
           d=diff(pmax);
           [aux1,aux2]=sort(abs(mean(d)-d));
           T=d(aux2(1));
           T=T*(T>10);%Si T vale menos de 10 muestras el resultado es absurdo.
        end
      end
      flag=0;
      %hay cambio de signo. Tenemos que comprobar si se trata de un ZC real
      if(T==0)
          %no hay datos de periodo. Hay que comprobar si hay INTERVALO muestras
          %positivas por la izquierda o menos
          if(sum(sign(pers_data2(end-INTERVALO+1:end-1)))==INTERVALO-1)
              %se trata de un ZC
              flag=1;%lo indicamos con un flag
          end
      else
          %tenemos informacion de periodo
          ultimo=find(pers_data2<0);
          if (length(ultimo)>1) %By Diego
               distancia=ultimo(end)-ultimo(end-1)-1; %n� de muestras positivas
               norma=distancia/T;
               if(norma>0.2)
                  %se trata de un ZC
                  flag=1; %lo indicamos con un flag
               end
          end
      end
      if(flag==1) %hubo un ZC
          %Seleccionamos la ventana donde buscamos el pico
          %El retardo introducido por el filtro es de 5 muestras. Tomamos
          %una ventana de 15 para tener un buen margen
          minimo=max([1 length(pers_datah)-15]);
          maximo=length(pers_datah);
          %Buscamos picos dentro de esa ventana
          peaks=localmaxima(pers_datah,2);
          aux=max(pers_datah);
          aux=pers_datah(peaks)/aux;
          peaks=peaks.*(pers_datah(peaks)>0.95).*(pers_datav(peaks)>=9.8).*(aux>0.3); %nos quedamos con los positivos y aplicamos las reglas 
          % heuristicas encontradas (umbrales)
          peaks=peaks(find(peaks>=minimo & peaks<=maximo)); %#ok<FNDSB>
          if(~isempty(peaks))
              %Seleccionamos el pico
              %Criterio: primer pico seguido de ZC
              evento=peaks(end);
              for j=1:length(peaks)-1
                  if(~isempty(find(pers_datah(peaks(j):peaks(j+1))<0))) %#ok<EFIND>
                      %hay un paso por cero entre estos ds maximos
                      evento=peaks(j);
                  end
              end
              %Calculamos el retardo al evento detectado
              retardo_hs=length(pers_datah)-evento;
              pers_indice_ultimo_hs=evento;
          end
       end
   end
   
   %Comprobamos si tenemos el 25% de la se�al para buscar un TO
   flag_to=0;
   if(pers_indice_ultimo_hs>0)
      distancia=length(pers_datah)-pers_indice_ultimo_hs;
      %if(T~=0)
      %    if((distancia-2)/T>=0.25) %le restamos 2 a distancia para tener algo de margen para el calculo de minimos
      %       flag_to=1;
       %      buscamin=floor(0.10*T);
       %      buscamax=min([ceil(0.25*T),distancia]);
        %  end
      %else
         if(distancia>=25)
             flag_to=1;
             buscamax=22;
             buscaffneg=5;
             mpb=10;
         end
      %end
   end
   %Segun Zijlstra el TO es el minimo local de la aceleracion vertical que
   %se encuentra entre el 5% y el 15% del paso. 
   % Nota de Diego. Ni de Coña. Está entre el FF y el 25% despues del HS
   if(flag_to==1) %buscamos el to
          maximos=localmaxima(pers_datav(pers_indice_ultimo_hs-buscaffneg:pers_indice_ultimo_hs+buscamax/2),2);
          if(~isempty(maximos))
             ff=maximos(1)-buscaffneg; %foot flat
             minimos=localmaxima(-pers_datav(pers_indice_ultimo_hs+ff:pers_indice_ultimo_hs+buscamax),2);       
             if(~isempty(minimos))
                [val,ind]=min(abs(minimos-10));
                evento=minimos(ind)+pers_indice_ultimo_hs+ff-1;
                retardo_to=length(pers_datav)-evento;
             else
                 disp('No se ha encontrado el TO, valor aproximado'); %#ok<WNTAG>
                 retardo_to=mpb;
             end
          else
              disp('No se ha encontrado el FF, valor aproximado'); %#ok<WNTAG>
              retardo_to=mpb;
          end
          pers_indice_ultimo_hs=0;
    end
end
