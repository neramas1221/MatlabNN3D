function [error] = errorCalculation(dataFile,networkOutput)
% gets the size of the data set
[X,Y] = size(networkOutput);
% sets error to be 0
error =0;
% loops over the data set
for i=1:X
    % calculates the error of the network based on the target - the
    % networks output
error = error + (dataFile(i,4) - networkOutput(i,1))^2;
end
% square roots the error
error = sqrt(error/X);
end

