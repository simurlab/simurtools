# SimurTools

Utilidades  compartidas en Matlab

Lista de funciones:

Procesamiento de señal básico:
  buscamaximos-> busca todos los máximos de una señal
  buscamaximosth-> busca todos los máximos que superen un umbral
  cumcamsimp-> integración numérica de cavalieri-simpson
  datacrop->herramienta interactiva para recortar una señal

Análisis del paso:
  distancia_arco-> estimación de la longitud del paso mediante el modelo del arco
  distancia_pendulo-> estimaciónd de la longitud del paso mediante un péndulo invertido
  distancia_penduloparcial-> estimación de la longitud del paso mediante modelo del péndulo +desplazamiento
  distancia_raizcuarta-> estimación de la longitud del paso mediante la amplitud de la aceleración
  eventosCOGrecto-> detección de eventos del paso

Estimación de distancias a partir de aceleraciones:
  doble_cumsum-> doble integral desde la aceleración
  doble_cumsum_kose-> doble integral desde la aceleración (método de Kose)
  doble_cumsum_rampp->  doble integral desde la aceleración (método de Rampp)
  doble_cumsum_thong->  doble integral desde la aceleración (método de Thong)
  doble_cumsum_zijlstra->  doble integral desde la aceleración (método de zijlstra)

Alineación de sensores:
  ejes_anatomicos->alineación automática de un sensor en el COG a los ejes anatómicos.

Estimación de la orientación en 2D:
  orientacioncompas-> estimación de la orientación mediante la brújula
  orientaciongiroscopo-> estimación por integración directa el giróscopo
  orientacionkalman-> estimación mediante un filtro de kalman (giróscopo +magnético)
