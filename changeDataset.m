function [traningData,X] = changeDataset(loopCounter)
fprintf("\nchanging data set %d\n",loopCounter);
if loopCounter == 1 
    traningData = importdata('data\2012 Data set.csv',',');
    [X,Y] = size(traningData);
elseif loopCounter ==2
    traningData = importdata('data\2013 Data set.csv',',');
    [X,Y] = size(traningData);
elseif loopCounter ==3
    traningData = importdata('data\2014 Data set.csv',',');
    [X,Y] = size(traningData);
elseif loopCounter ==4
    traningData = importdata('data\2015 Data set.csv',',');
    [X,Y] = size(traningData);
end

