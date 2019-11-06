%% Estimations with inertial sensors
% Simurtools Toolbox(TM) include tools analyze IMUs signals for motion
% monitoring purposes.


%% Estimate 2D orientations from gyro signals
% Variables que se pueden estimar con giroscopios.

%%
%
% * <orientacioncompas.html orientacioncompas: estimacion de la orientacion mediante la
% brujula>
% * orientaciongiroscopo: estimacion por integracion directa el giroscopo
% * orientacionkalman: estimacion mediante un filtro de kalman (giroscopo+magnetico)


%% Estimate 3D orientations from acc, gyro or magnetic signals
% Variables que se pueden estimar .

%%
%
% * triad: estimacion de la orientacion 3D mediante acelerometros y giroscopos


%% Detect Gait Events 
% Diferentes funciones relacionadas con eventos del paso.

%%
%
% * <eventosRT.html eventosRT: detecci�n de eventos del paso de manera secuencial o en tiempo real>
% * eventosCOGrecto: deteccion de eventos del paso

%% Estimate Gait Variables 
% Diferentes funciones relacionadas con variables del paso.

%%
%
% * distancia_arco: estimacion de la longitud del paso mediante el modelo del arco
% * distancia_pendulo: estimacion de la longitud del paso mediante un pendulo invertido
% * distancia_penduloparcial: estimacion de la longitud del paso mediante modelo del pendulo+desplazamiento
% * distancia_raizcuarta: estimacion de la longitud del paso mediante la amplitud de la aceleracion