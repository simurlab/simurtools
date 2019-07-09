SimurTools v2.0
===============

Herramientas del laboratorio SiMuR para la captacion y analisis del movimiento humano.


Lista de funciones:
----------------------------------

## Procesamiento de se馻l basico:
  
* `buscamaximos`: busca todos los m谩ximos de una se帽al
* `buscamaximosth`: busca todos los m谩ximos que superen un umbral
* `cumcamsimp`: integraci贸n num茅rica de cavalieri-simpson
* `datacrop`: herramienta interactiva para recortar una se帽al

## An谩lisis del paso:
  
* `distancia_arco`: estimaci贸n de la longitud del paso mediante el modelo del arco
* `distancia_pendulo`: estimaci贸nd de la longitud del paso mediante un p茅ndulo invertido
* `distancia_penduloparcial`: estimaci贸n de la longitud del paso mediante modelo del p茅ndulo +desplazamiento
* `distancia_raizcuarta`: estimaci贸n de la longitud del paso mediante la amplitud de la aceleraci贸n
* `eventosCOGrecto`: detecci贸n de eventos del paso

## Estimaci贸n de distancias a partir de aceleraciones:
  
* `doble_cumsum`: doble integral desde la aceleraci贸n
* `doble_cumsum_kose`: doble integral desde la aceleraci贸n (m茅todo de Kose)
* `doble_cumsum_rampp`: doble integral desde la aceleraci贸n (m茅todo de Rampp)
* `doble_cumsum_thong`: doble integral desde la aceleraci贸n (m茅todo de Thong)
* `doble_cumsum_zijlstra`: doble integral desde la aceleraci贸n (m茅todo de zijlstra)

## Alineaci贸n de sensores:
  
* `ejes_anatomicos`: alineaci贸n autom谩tica de un sensor en el COG a los ejes anat贸micos.

## Estimaci贸n de la orientaci贸n en 2D:
  
* `orientacioncompas`: estimaci贸n de la orientaci贸n mediante la br煤jula
* `orientaciongiroscopo`: estimaci贸n por integraci贸n directa el gir贸scopo
* `orientacionkalman`: estimaci贸n mediante un filtro de kalman (gir贸scopo +magn茅tico)
