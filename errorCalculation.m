function [error] = errorCalculation(dataFile,networkOutput)

[X,Y] = size(networkOutput);

error =0;

for i=1:X
error = error + (dataFile(i,4) - networkOutput(i,1))^2;
end

error = sqrt(error/X);
end

