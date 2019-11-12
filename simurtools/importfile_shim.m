function [Counter,Temperature,Acc_X,Acc_Y,Acc_Z,Gyr_X,Gyr_Y,Gyr_Z,Mag_X,Mag_Y,Mag_Z] = importfile_sh038(filename, startRow, endRow)
%IMPORTFILE1 Import numeric data from a text file as column vectors.
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

%% Initialize variables.
delimiter = '\t';
if nargin<=2
    startRow = 4;
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
%	column12: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%f%f%f%f%f%f%f%f%f%f%f%f%[^\n\r]';

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
% 
%% Allocate imported array to column variable names
% Shimmer_CE9F_Timestamp_Unix_CAL = dataArray{:, 1};
% Shimmer_CE9F_Accel_LN_X_CAL = dataArray{:, 2};
% Shimmer_CE9F_Accel_LN_Y_CAL = dataArray{:, 3};
% Shimmer_CE9F_Accel_LN_Z_CAL = dataArray{:, 4};
% Shimmer_CE9F_Gyro_X_CAL = dataArray{:, 5};
% Shimmer_CE9F_Gyro_Y_CAL = dataArray{:, 6};
% Shimmer_CE9F_Gyro_Z_CAL = dataArray{:, 7};
% Shimmer_CE9F_Mag_X_CAL = dataArray{:, 8};
% Shimmer_CE9F_Mag_Y_CAL = dataArray{:, 9};
% Shimmer_CE9F_Mag_Z_CAL = dataArray{:, 10};
% Shimmer_CE9F_Pressure_BMP180_CAL = dataArray{:, 11};
% Shimmer_CE9F_Temperature_BMP180_CAL = dataArray{:, 12};

%% Allocate imported array to column variable names: los accs LN
Counter = dataArray{:, 1};
Temperature = dataArray{:, 12};
Acc_X = dataArray{:, 2};
Acc_Y = dataArray{:, 3};
Acc_Z = dataArray{:, 4};
Gyr_X = dataArray{:, 5};
Gyr_Y = dataArray{:, 6};
Gyr_Z = dataArray{:, 7};
Mag_X = dataArray{:, 8};
Mag_Y = dataArray{:, 9};
Mag_Z = dataArray{:, 10};


