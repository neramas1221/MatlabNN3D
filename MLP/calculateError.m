function [error] = calculateError(dataFile, netOutput)

[X,Y] = size(dataFile);
error = 0;
for i=1:X
    error = error + (dataFile(i,4) - netOutput(i,1))^2;
end
error = sqrt(error/X);
end

