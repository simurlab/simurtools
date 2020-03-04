% ORIENTACIONKALMAN Calcula la orientación en base a los datos de un giróscopo y un compás situados en el COG
%
% ORIENTACIONKALMAN Realiza la integración de los datos provenientes de un compás y de un giróscopo mediante un filtro de Kalman
% Los datos del giróscopo se analizan para determinar su fiabilidad, y se asigna una fiabilidad a los mismos en base a:
% la desviación vertical del campo magnético y la diferencia con los datos proporcionados por el giróscopo.
% Si se emplea esta función orientacioncompas NO debe ser llamada de forma
% directa por el programador, o al menos no se le debe proporcionar un ángulo de referencia.
% 
% Syntax: 
%   function angulo=orientacionkalman(velgiro, campox,campoy,campoz, angulo0,freq)
%
%   Parámetros de entrada:
%                 velgiro    - vector con la velocidad de giro respecto al eje vertical en cada periodo
%                              de muestreo. Puede contener cualquier número
%                              de muestras
%                 campox     -
%                 campoy     -
%                 campoz     -
%                 angulo0    - valor del ángulo inicial. Si no se proporciona la función lo inicializa a cero
%                              El angulo se conserva final se conserva para
%                              la siguiente llamada
%                 freq       - frecuencia de muestreo. Si no se proporciona, en la primera llamada se inicializa a 100Hz
%                              Se conserva entre llamadas.
%                 reset      - si vale 1 reinicia el filtro de Kalman
%   Parámetros de salida:
%                 angulo     - vector con el angulo correspondiente a cada
%                              instante
%
%Modelo de Kalman:   (angulo  ) (1 T 0) (angulo ) (ruido_angulo)
%                    (velgiro )=(0 1 0)*(velgiro)+(ruido_veloc )
%                    (bias    ) (0 0 1) (bias   ) (ruido_bias  )
%                     
%                    (angulocompas) (1 0 0 ) (angulo ) (ruido_compas)
%                    (velgiroscopo)=(0 1 1 )*(velgiro)+(ruido_giroscopo)
%                                            (bias   )
%
% El ruido de compas varia entre 10º en condiciones normales y 1e10 cuando el compas no es fiable
% Se considera no fiable en dos circunstancias: Cuando OrientacionCompas así lo dice, o cuando 
% la diferencia entre el angulo teorico según kalman y segun el compas excede los 5º. 
% Se vuelve a considerar válido cuando esa diferencia baja de los 2º, en cuyo caso se reinicia el proceso
% de filtrado.
% Cuando el compas no es válido, el resultado se corresponde aprox con la integración de la señal del giroscopo.
% 
% Examples: 
%   
%
% See also: orientacionbrujula, orientacioncompas

% Author:   Diego Álvarez
% History:  ??.??.200? creado
%           13.12.2007 adaptado para trabajar on-line y documentado
%

function angulo=orientacionkalman(velgiro, campox,campoy,campoz, angulo0,freq,reset)

persistent SILOP_orientacionkalman
if (nargin<7)
    reset=0;
end
if ((isempty(SILOP_orientacionkalman))||(reset==1))
    SILOP_orientacionkalman.freq=100;
    %el valor inicial se asocia con 0 en el compas
    orientacioncompas(campox,campoy,campoz,orientacioncompas(campox,campoy,campoz));
    %N se ajustará sobre la marcha
    SILOP_orientacionkalman.P=1*eye(3);
    SILOP_orientacionkalman.X=[0;0;0]; %angulo, velocidad, bias
    SILOP_orientacionkalman.ruidocompas=10;
end

if (nargin>4)
    angulo=orientacioncompas(campox(1),campoy(1),campoz(1),0);
    orientacioncompas(campox(1),campoy(1),campoz(1),angulo-angulo0);
    SILOP_orientacionkalman.X=[angulo0;0;0]; %angulo, velocidad, bias
  if (nargin>5)
	SILOP_orientacionkalman.freq=freq;
  else 
	SILOP_orientacionkalman.freq=100;
  end
  %A depende de la frecuencia
  SILOP_orientacionkalman.A=[1 1/freq 0; 0 1 0; 0 0 1];
end


[angulocompas,fiablecompas]=orientacioncompas(campox,campoy,campoz);
angulok=0*angulocompas;

%Matrices de Kalman iniciales
A=[1 1/SILOP_orientacionkalman.freq 0; 0 1 0; 0 0 1];
%B=0;
C=[1,0,0; 0 1 1 ];
V=[0 0 0 ; 0 0.1 0 ; 0 0 1e-6];


%%%  Filtro
%dif_angulos_old=0;
for indice=1:length(angulok)
        %Deteccion de anomalias.
        if (fiablecompas(indice)==0)
            SILOP_orientacionkalman.ruidocompas=1e10;
        else
            dif_angulos=angulocompas(indice)-SILOP_orientacionkalman.X(1,1);
            if (abs(dif_angulos)>5) 
                SILOP_orientacionkalman.ruidocompas=1e10;
            end
            %Implementación del reset cuando la diferencia disminuye mucho
            if ((abs(dif_angulos)<2) && (SILOP_orientacionkalman.ruidocompas>1e9))
                SILOP_orientacionkalman.P=1e-3*eye(3);
                SILOP_orientacionkalman.ruidocompas=10;
            end
        end
        %Aplicacion del filtro
        N=[SILOP_orientacionkalman.ruidocompas 0;0 0.1];
	    Y=[angulocompas(indice);velgiro(indice)];
	    Xest=A*SILOP_orientacionkalman.X;
	    Q=A*SILOP_orientacionkalman.P*A'+V;
	    E=Y-C*Xest;
	    SILOP_orientacionkalman.X=Xest+Q*C'*inv(C*Q*C'+N)*E;
	    SILOP_orientacionkalman.P=inv(inv(Q)+C'*inv(N)*C);
	    angulok(indice)=SILOP_orientacionkalman.X(1,1);
end

angulo=angulok;



