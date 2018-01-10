function [traningData,X] = changeDataset(loopCounter)
% updates the data set based on the loop counter
fprintf("\nchanging data set %d\n",loopCounter);
if loopCounter == 1 
    % loads in a diffrent data set
    traningData = importdata('data\2012 Data set.csv',',');
    % gets the size of the data set 
    [X,Y] = size(traningData);
elseif loopCounter ==2
    % loads the inputs from the traing data
    traningData = importdata('data\2013 Data set.csv',',');
    % gets the size of the data set 
    [X,Y] = size(traningData);
elseif loopCounter ==3
    % loads the inputs from the traing data
    traningData = importdata('data\2014 Data set.csv',',');
    % gets the size of the data set 
    [X,Y] = size(traningData);
elseif loopCounter ==4
    % loads the inputs from the traing data
    traningData = importdata('data\2015 Data set.csv',',');
    % gets the size of the data set 
    [X,Y] = size(traningData);
end

