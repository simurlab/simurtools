% CARGAR_DATOS_XSENS Leer un archivo del shimmer tipo .txt
%
% Syntax: 
%   [medicion]= cargar_datos_xsens(file,idname)
% 
% Input parameters:
%   file-> nombre del archivo
%   idname-> identificador del sensor
%
% Output parameters:
%   medicion<- Datos leidos
%
% Examples:
%   medicion=cargar_datos_xsens('Sensor_BAD7.txt','walkCOG')
%
% See also: cargar_datos_camara, cargar_datos_xsens

% Author:   Leticia
%           JC incorpora a tb 12-12-2019


%   [COUNTER,TEMPERATURE,ACC_X,ACC_Y,ACC_Z,GYR_X,GYR_Y,GYR_Z,MAG_X,MAG_Y,MAG_Z]
%   = IMPORTFILE1(FILENAME) Reads data from text file FILENAME for the
%   default selection.
%
%   [COUNTER,TEMPERATURE,ACC_X,ACC_Y,ACC_Z,GYR_X,GYR_Y,GYR_Z,MAG_X,MAG_Y,MAG_Z]
%   = IMPORTFILE1(FILENAME, STARTROW, ENDROW) Reads data from rows STARTROW
%   through ENDROW of text file FILENAME.
%
% Example:
%   [Counter,Temperature,Acc_X,Acc_Y,Acc_Z,Gyr_X,Gyr_Y,Gyr_Z,Mag_X,Mag_Y,Mag_Z] = importfile1('00500686-022.txt',6, 76128);
%
%    See also TEXTSCAN.

% Auto-generated by MATLAB on 2017/11/21 20:06:41
% Modified by JC-simur on 2019/11/12 


function [medicion] = importfile_xsens(filename, idname, startRow, endRow)

%% Initialize variables.
delimiter = '\t';
if nargin<=3
    startRow = 6;
    endRow = inf;
end

%% Format for each line of text:
%   column1: double (%f)
%	column2: double (%f)
%   column3: double (%f)
%	column4: double (%f)
%   column5: double (%f)
%	column6: double (%f)
%   column7: double (%f)
%	column8: double (%f)
%   column9: double (%f)
%	column10: double (%f)
%   column11: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%f%f%f%f%f%f%f%f%f%f%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to the format.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'EmptyValue' ,NaN,'HeaderLines', startRow(1)-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
for block=2:length(startRow)
    frewind(fileID);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'EmptyValue' ,NaN,'HeaderLines', startRow(block)-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
    for col=1:length(dataArray)
        dataArray{col} = [dataArray{col};dataArrayBlock{col}];
    end
end

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Allocate imported array to column variable names
medicion.tiempo = dataArray{:, 1};
medicion.Accel(:,1) = dataArray{:, 3};
medicion.Accel(:,2) = dataArray{:, 4};
medicion.Accel(:,3) = dataArray{:, 5};
medicion.Gyro(:,1) = dataArray{:, 6};
medicion.Gyro(:,2) = dataArray{:, 7};
medicion.Gyro(:,3) = dataArray{:, 8};
medicion.Mag(:,1) = dataArray{:, 9};
medicion.Mag(:,2) = dataArray{:, 10};
medicion.Mag(:,3) = dataArray{:, 11};
medicion.temperature = dataArray{:, 2};





