% EVENTOSCOGRECTO Detecta 5 eventos a partir de las acelerariones verticales y horizontales del COG. Funci�n Off-line
%
% EVENTOSCOGRECTO Tomando como base las aceleraciones horizontales y verticales del COG realiza un proceso de
% filtrado que le permite diferenciar cada paso. Una vez detectado un paso, realiza un proceso de detecci�n de
% m�nimos y m�ximos que permite identificar los eventos IC, FF, HS, MS y PO. El algoritmo se basa en la descripci�n
% proporcionada por Auvinet. La principal diferencia, es que se ha comprobado que el punto identificado por Auvinet
% como PO se corresponde realmente con el MS. El punto identificado por Auvinet como MS es probablemente el PO, 
% pero esta sin confirmar.
%
% Sintax: tiempos=eventosCOGrecto(AccHor,AccVert,frecuencia)
%
% Par�metros de entrada:
%    AccHor        - vector con la aceleraci�n antero-posterior
%    AccVert       - vector con la aceleraci�n vertical
%    frecuencia    - entero indicando la frecuencia de muestreo. Por
%                    defecto 100Hz
%
% Par�metros de salida:
%    tiempos: vector del mismo tama�o que los datos, con unos en las posiciones 
%             de los eventos y ceros el resto:
%             tiempos(:,1)=AccVert;
%             tiempos(:,2)=AccHor;
%             tiempos(:,3)=deteccion de foot flat, FF;
%             tiempos(:,4)=deteccion de heel strike, HS;
%             tiempos(:,5)=deteccion de toe off, TO;
%             tiempos(:,6)=deteccion de mid stance, MS; (PO de acuerdo con Auvinet)
%             tiempos(:,7)=deteccion evento NoIdentificado, NI; (era el "midstance en
%                          Auvinet-2002).
%             tiempos(:,8)=vacio con ceros, reservado para futuros eventos;
%
% Examples:
%



% Historial de Modificaciones: 
% v0.1 Diego: Versi�n original para el IMU-Pro
% v0.2 Diego: Version generica para IMU-Pro y XSens
% v0.3 Antonio: A�adidos eventos PO y MS
% v0.4 JC: Comentarios
% v0.5 Diego: Corregida detecci�n de eventos FF al principio y al final del tramo %%%%            de se�al. Afinados tiempos para deteccion FF y TO.
% v0.6 Diego: A�adido metodo de Antonio para detectar el Push-off.
%           A�adidos warnings para se�alar detecciones incorrectas(secuencias rotas)
% v1.0 Diego:Nuevo algoritmo de deteccion de hs y ff. Mucho m�s robusto.
%		Eliminadas todas las odiosas dependencias del factorf
% v1.1 Rafa y Diego: Corregidos dos bugs: 
%		1)Se puede trabajar a frecuencias no m�ltiplos de 50
%		2)Se eliminan los eventos HS extremadamente pr�ximos que corresponden
%			se corresponden a un �nico HS y desparejan los resultados.
% v1.2 JC,13/7/06: Redenominaci�n de los eventos detectados:
%      1)La columna 6 que llamabamos PO pasa a ser el MS
%      2)La columna 7 que llamabamos MS pasa a ser eventoNoIdentificado NI
%      La caracter�stica del evento y su detecci�n no cambia, solo los
%      nombres.
% v1.2.1 Diego. Corregido un bug. Al ajustar para multiples frecuencias la frecuencia del
%      filtro hab�a quedado en 1.25Hz en lugar de en 2.5Hz. 

function tiempos=eventosCOGrecto(AccHor,AccVert,frecuencia)

if (nargin<3)
    frecuencia=100;
end
%%Estan reescaladas para comparar mas f�cil con los eventos
tiempos(:,1)=AccVert;
tiempos(:,2)=AccHor;
tiempos(:,3)=0*AccVert;
tiempos(:,4)=0*AccVert;
tiempos(:,5)=0*AccVert;
tiempos(:,6)=0*AccVert;
tiempos(:,7)=0*AccVert;
tiempos(:,8)=0*AccVert;


%Deteccion de puntos de footflat.
%Primera aproximaci�n. m�ximos 1� arm�nico
Datos_filt=filtro0(AccVert,60,5/frecuencia);
ff=buscamaximosth(Datos_filt,10.5);
ff=find(ff==1);



%Deteccion de HS en la horizontal
m_inferior=-0.10;
m_superior=-0.00;
%Deteccion del primer HS. No es necesario y no tiene porque aparecer.
resto=1; %Desde que HS empiezo a buscar
if (ff(1)<=-1*m_inferior*frecuencia) 
	hs(1)=1;
	resto=2;
end
%Busqueda del resto de HS
for i=resto:length(ff)
    [maximo,punto]=max(AccHor(ff(i)+ceil(m_inferior*frecuencia):ff(i)+floor(m_superior*frecuencia)));
    hs(i)=ff(i)+ceil(m_inferior*frecuencia)+punto-1; %#ok<AGROW>
end

%Postprocesamiento de los HS, para eliminar posibles espurios m�ltiples
for i=(length(hs)-1):-1:1
	if (  abs(hs(i)-hs(i+1))<0.2*frecuencia)
		[maximo,indice]=max([AccHor(hs(i)),AccHor(hs(i+1))]);
		hs(i)=hs(i+indice-1);
		hs=hs([1:i,i+2:end]);
	end
end

for i=1:length(hs)
    tiempos(hs(i),4)=1;
end

%Inicializacion de todas una vez conocido el n�mero correcto de pasos
ff=0*hs;
to=0*ff;
ms=0*to;
%po=0*ms;


%Detecci�n del FF. M�ximo desplazamiento respecto al HS
m_inferior=0.01;
m_superior=0.06;
%Deteccion del ultimo FF. No es necesario y no tiene porque aparecer.
eliminado=0;
if (hs(end)+m_superior*frecuencia>length(AccVert))
	ff(end)=length(AccVert)-3;%Quedan otros tres eventos
	eliminado=1;
end

for i=1:length(hs)-eliminado
    [maximo,punto]=max(AccVert(max(hs(i)+ceil(m_inferior*frecuencia),1):min(hs(i)+floor(m_superior*frecuencia),end)));
    ff(i)=hs(i)+ceil(m_inferior*frecuencia)+punto-1;
end


for i=1:length(ff)
       	tiempos(ff(i),3)=1;
end





%Deteccion de TO en la vertical
%Busqueda del resto de TO
m_inferior_m=0.10;
m_superior_m=0.20;
m_inferior_t=0.02;
m_superior_t=-0.02;
%Deteccion del ultimo TO. No es necesario y no tiene porque aparecer.
eliminado=0;
if (ff(end)+m_superior_m*frecuencia>length(AccVert))
	to(end)=length(AccVert)-2;%quedan otros dos eventos
	eliminado=1;
end
for i=1:length(ff)-eliminado
    %Maximo siguiente al ff. No necesito que sea exacto.
    [maximo,punto]=max(AccVert(ff(i)+ceil(m_inferior_m*frecuencia):ff(i)+floor(m_superior_m*frecuencia)));
    to(i)=ff(i)+ceil(m_inferior_m*frecuencia)+punto-1;
    [minimo,punto]=min(AccVert(ff(i)+ceil(m_inferior_t*frecuencia):to(i)+floor(m_superior_t*frecuencia)));
    to(i)=ff(i)+ceil(m_inferior_t*frecuencia)+punto-1;
end

for i=1:length(to)
    tiempos(to(i),5)=1;
end




%Iniciamos b�squeda de MS.
%Para el MS busco los minimos absolutos en [TO, HS]
ipo=buscamaximos(-Datos_filt);
ipo=find(ipo==1);

%eliminamos un posible MS antes del 1� TO para mantener secuencia estandar
if ipo(1)<to(1)
	ipo=ipo(2:end);
end
%Si falta un MS para igualar a los demas, se pone en la �ltima muestra
if length(ipo)<length(to)
	ipo=[ipo;length(AccVert)];
end


%Tiempos
for i=1:length(ipo)
    tiempos(ipo(i),6)=1;
end

%Puede que a pesar de todo el n�mero de MSs no coincida con el 
%n�mero de TOs
if length(ipo)~=length(ff)
	warning('los eventos detectados son incongruentes.�todos los datos son caminando??');	 %#ok<WNTAG>
end
minimo_de_puntos=min(length(ipo),length(ff));


%%Detecci�n del evento NoIdentificado NI: M�ximo entre TO y MS
for k=1:minimo_de_puntos
    if(to(k)<ipo(k))
            [maxim, pos_maxim] = max(AccVert(to(k):ipo(k)));
            ms(k) = pos_maxim+to(k)-1;
        else 
	    warning('toe off < initial push off. Muestras %d %d',to(k),ipo(k)); %#ok<WNTAG>
	    to(k) = ipo(k)-2;
	    ms(k) = ipo(k)-1;
    end;
end;

for i=1:minimo_de_puntos
    tiempos(ms(i),7)=1;
end

