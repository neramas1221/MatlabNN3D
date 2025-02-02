% loads in test data
testData = importdata('data\2016 Data set.csv',',');
% loads in training data
trainingData = importdata('data\2012 Data set.csv',',');
% loads in valadtion data
valadationData = importdata('data\2017 data set.csv',',');
% gets the size of all data sets
[X,Y] = size(trainingData);
[testX,testY] = size(testData);
[vX,Vy] = size(valadationData);
% sets the optimal learning rate
learningRate =0.01;
% sets the optimal size of the hidden layer
hiddenNodeSize =31;
% sets the input layer weights to be random values between 0.1 - 1 
inputLayer = rand(4,hiddenNodeSize);
% sets the BIAS node to be 1
inputLayer(4,:) = 1;
% sets the output layer weights to be random values between 0.1-1
outputLayer = rand(hiddenNodeSize,1);
% sets the BIAS node to be 1
outputLayer(4,:) = 1;
%creates input vector
inputs = zeros(4,1);
%creates matrix to store the output of the network
outputValues = zeros(X,1);
% creates matrix to store the output of the network when using testing data
outputTestValues = zeros(testX,1);
% creates a matrix to store the output of the network when using valadation
% data
netOutputValadation = zeros(vX,1);
% creates matrix to store all error values for each data set
error = zeros(100,1);
errorTest = zeros(100,1);
errorValadation = zeros(100,1);
% loops over all data sets and updates the output vector to be able to
% store all data for that data set.
for loopCount=1:4
    [trainingData,X] = changeDataset(loopCount);
    outputValues = zeros(X,1);
    % runs 100 epocs on the data set
for epocs =1:100
    % loops over the data set
    for i=1:X
        % loads the inputs from the traing data
        inputs(1,1) = trainingData(i,1);
        inputs(2,1) = trainingData(i,2);
        inputs(3,1) = trainingData(i,3);
        % off set
        inputs(4,1) = 1;
        % sets the target value that is in the data set
        target = trainingData(i,4);
        % calculates the network output and calculates the output and input
        % layer weights update amount
        [inputLayerUpdate,outputLayerUpdate,output] = calculateOutput...
        (inputLayer,inputs,outputLayer,target);
        % stores the output of the network
        outputValues(i,1) = output;
        % updates the input layer weights
        inputLayer = inputLayer - learningRate * inputLayerUpdate;
        % updates the output layer wights
        outputLayer = outputLayer - learningRate * outputLayerUpdate;
    end
    % loops over the test data
    for i=1:testX
        % loads the inputs from the traing data
        inputs(1,1) = testData(i,1);
        inputs(2,1) = testData(i,2);
        inputs(3,1) = testData(i,3);
        % off set
        inputs(4,1) = 1;
        % gets the target from the data set
        target = testData(i,4);
        % gets the network output and the weight update differances but 
        % they are never used
        [inputLayerUpdate,outputLayerUpdate,output] = calculateOutput...
        (inputLayer,inputs,outputLayer,target);
        % stores the test output
        outputTestValues(i,1) = output;
    end
    % loops over the valadation data set 
     for i=1:vX
        % loads in the valadation data 
        inputs(1,1) = valadationData(i,1);
        inputs(2,1) = valadationData(i,2);
        inputs(3,1) = valadationData(i,3);
        % off set
        inputs(4,1) = 1;
        % gets the target value
        target = valadationData(i,4);
        % calculates the network output
        [inputLayerUpdate,outputLayerUpdate,output] = calculateOutput...
        (inputLayer,inputs,outputLayer,target);
        % stores the network output
        netOutputValadation(i,1) = output;
    end
    % calculates the error of the network
    error(epocs,1) = calculateError(trainingData,outputValues);
    errorTest(epocs,1) = calculateError(testData,outputTestValues);
    errorValadation(epocs,1) = calculateError(valadationData,netOutputValadation);
    fprintf("epoc count : %d\n",epocs);
end
end
% plot the network function
figure(1)
hold on
plot(trainingData(:,1)*365,trainingData(:,4)*100000);
plot(trainingData(:,1)*365,outputValues(:,1)*100000,'g');
legend('Training Data','Network Output')
hold off
% plots the networks prediction
figure(2)
hold on
plot(valadationData(:,1)*365,valadationData(:,4)*100000);
plot(valadationData(:,1)*365,netOutputValadation(:,1)*100000,'g');
legend('Valadation Target','Network Output')
hold off
% plots the error of the network
figure(3)
hold on
plot(error,'b-');
plot(errorTest,'r-');
plot(errorValadation,'g-');
legend('Train error','Test error','Valadation error')
hold off