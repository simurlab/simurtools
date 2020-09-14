% Funcion para leer un archivo .csv

    %ENTRADA
        %Path del archivo.csv
    %SALIDA
        %Matriz con los datos
       % Para usar
       % --> lectura_archivo_csv('FILENAME')
function  [Datos]= lectura_archivo_csv(Path)

    [Datos]=csvread(Path);
end