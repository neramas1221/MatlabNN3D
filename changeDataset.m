function [traningData,X] = changeDataset(loopCounter)
fprintf("\nchanging data set\n");
if loopCounter == 1 
    traningData = importdata('data\2012_hourly.csv',',');
    [X,Y] = size(traningData);
elseif loopCounter ==2
    traningData = importdata('data\2013_hourly.csv',',');
    [X,Y] = size(traningData);
elseif loopCounter ==3
    traningData = importdata('data\2014_hourly.csv',',');
    [X,Y] = size(traningData);
elseif loopCounter ==4
    traningData = importdata('data\2015_hourly.csv',',');
    [X,Y] = size(traningData);
end

