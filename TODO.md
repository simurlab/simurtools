# Lista de funciones a añadir


## GAIT ANALYSIS

- [ ] EvaluaSalto.   ->Estima la duración , altura y energia de un squatjump

- [ ] EvaluaSentadilla->Estima desplazamientos, velocidades, fuerzas y potencias de una sentadilla

- [ ] EventosPiernaG->Detecta los eventos del paso a partir de las velocidades de giro de la tibia

- [ ] EventosSentadillas-> Detecta el inicio de la sentadilla, el punto medio y el final de la sentadilla

- [ ] EventosPieRectOff-> Detecta los eventos del paso con un giro en el pie


## PIRAGUAS

- [ ] EventosPiraguas->Detecta el instante de empuje de la palada

- [ ] FrecuenciaPaladas-> Cálculo de la frecuencia de las paladas 

- [ ] distanciapalada_distancia y distanciapaldada_gps-> Calculo distancia de palada, no usada en publicación

- [ ] potenciapaldada -> Estimación de la potencia máxima durante la palada (sin verificacio)

- [ ] frecuencia_palada_acc_datos_2022  se puede usar a modo de demo

- [ ] oscilacion_embarcacion_datos_2022  se puede usar a modo de ejemplo

- [ ] frecuencia_corte_adaptada ->auxiliar.Estima frecuencias de filtrado a partir de la frec máxima. No se uso realmente


## UTILIDADES DSP

- [ ]  filtro0 -> Implementa un filtro fir1 paso bajo de fase 0

- [ ] ident_act          ->Estas dos funciones entrenan y usan una red neuronal para identificar actividades

- [ ] entrena_ident_act  ->    no se como de útiles son

- [ ] limpiaestatico-> Detecta fases estaticas (sin desplazamiento) a partir de las aceleraciones

- [ ] localmaxima   -> busca maximos locales en un entorno reduciodo

- [ ] loadsilop  -> permite cargar los archivos de datos que usamos durante el proyecto silop, así como todos los de los proyectos con fremap

- [ ] calibracion_shimmer -> Contiene datos de calibración de los sensores shimmer que tenemos. 

## CARRERA

- [ ] Calculo de la cadencia durante la carrera. 

- [ ] Detección de eventos de la carrera desde el brazo (3 métodos, 1 el publicado)

- [ ] Detección de eventos de la carrera desde el archivo de las camaras

- [ ] Detección de eventos de la carrera desde la espalda. (3 métodos, 1 el publicado)

- [ ] Detección de eventos de la carrera en el pie)

- [ ] selección_pie, eliminardupolicados    son funciones auxiliares

- [ ] calculos_special_issue se puede usar a modo de demo







