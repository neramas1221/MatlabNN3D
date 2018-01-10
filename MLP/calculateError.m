function [error] = calculateError(dataFile, netOutput)
% gets the size of the data set
[X,Y] = size(dataFile);
error = 0;
% loops over the data set
for i=1:X
    % calculates the error of the network on the traning data
    error = error + (dataFile(i,4) - netOutput(i,1))^2;
end
% squar roots the error
error = sqrt(error/X);
end

