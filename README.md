SimurTools v2.0
===============

Herramientas del laboratorio SiMuR para la captacion y analisis ambulatorio del movimiento humano.


Lista de funciones:
----------------------------------

## Carga de archivos de datos de diferentes tipos:

* `cargar_datos_shimmer`: leer un archivo de datos de los shimmer 


## Procesamiento de señal basico:
  
* `buscamaximos`: busca todos los maximos de una senyal
* `buscamaximosth`: busca todos los maximos que superen un umbral
* `cumcamsimp`: integracion numerica de cavalieri-simpson
* `datacrop`: herramienta interactiva para recortar una senyal

## Analisis del paso:
  
* `distancia_arco`: estimacion de la longitud del paso mediante el modelo del arco
* `distancia_pendulo`: estimacion de la longitud del paso mediante un pendulo invertido
* `distancia_penduloparcial`: estimacion de la longitud del paso mediante modelo del pendulo+desplazamiento
* `distancia_raizcuarta`: estimacion de la longitud del paso mediante la amplitud de la aceleracion
* `eventosCOGrecto`: deteccion de eventos del paso

## Estimacion de distancias a partir de aceleraciones:
  
* `doble_cumsum`: doble integral desde la aceleracion
* `doble_cumsum_kose`: doble integral desde la aceleracion (metodo de Kose)
* `doble_cumsum_rampp`: doble integral desde la aceleracion (metodo de Rampp)
* `doble_cumsum_thong`: doble integral desde la aceleracion (metodo de Thong)
* `doble_cumsum_zijlstra`: doble integral desde la aceleracion (metodo de zijlstra)

## Alineacion de sensores:
  
* `ejes_anatomicos`: alineacion automatica de un sensor en el COG a los ejes anatomicos.

## Estimacion de la orientacion en 2D:
  
* `orientacioncompas`: estimacion de la orientacion mediante la brujula
* `orientaciongiroscopo`: estimacion por integracion directa el giroscopo
* `orientacionkalman`: estimacion mediante un filtro de kalman (giroscopo+magnetico)
