% loads in training, test and valadation data.
testingData = importdata('data\2016 Data set.csv',',');
trainingData = importdata('data\2012 Data set.csv',',');
valadationData = importdata('data\2017 data set.csv',',');
% gets the size of the data sets
[X,Y] = size(trainingData);
[testX, testY] = size(testingData);
[vX,Vy] = size(valadationData);
% gets an integer value for the size of the file
num = floor(X);
% creates the node centers based on the number of nodes wanted and the data
% set that the function is given =
[id,centers] = kmeans(trainingData(:,1:end-1),num);
% gets the size of the centers
[centerX, centerY] = size(centers);
% sets sigma to the optimal value
sigma = 0.1;
% sets the nodes to be the size of the centers created and to hold 5 peaces
% of data
nodes = zeros(centerX,5);
% sets up input matrix
inputs = zeros(3,1);

% loops over the nodes and sets there center, ouput weights and activations
for i =1:centerX
    nodes(i,1) = centers(i,1);
    nodes(i,2) = centers(i,2);
    nodes(i,3) = centers(i,3);
    nodes(i,4) = 0;
    nodes(i,5) = 1;
end
% sets the epoc count
loopCount = 100;
% creates matrix's to store the networks output on testing,traning and
% valadation data sets
netOutputArray = zeros(X,1);
netOutputTest = zeros(testX,1);
netOutputValadation = zeros(vX,1);
nodeRecruted =0;
% creates matrix's to store the error of the network
error = zeros(loopCount,1);
errorTest = zeros(loopCount,1);
errorValadation=zeros (loopCount,1);
% loops over all of the data sets
for dataLoop=1:4
    % changes the data set 
 [trainingData,X] = changeDataset(dataLoop);
 % creates the matrix to store the network out put based on the size of the
 % data set
  netOutputArray = zeros(X,1);
  % profomes 100 epocs on the data set
  for epoc=1:loopCount
    % loops over the data set
    for i=1:X
        % loads the inputs data from the traning file
        inputs(1,1) = trainingData(i,1);
        inputs(2,1) = trainingData(i,2);
        inputs(3,1) = trainingData(i,3);
        % loads in the target value from the training file
        target = trainingData(i,4);
        % calculates the output of the network and return the nodes with
        % there activation values
        [netoutPut,nodes] = calculateNetwork(nodes,inputs,sigma);
        % stores the network output
        netOutputArray(i,1) = netoutPut;
        % updates the nodes ouput weights
        nodes = updateWeights(netoutPut,nodes,target);
    end
    % stores the RMS error of the network
    error(epoc,1) = errorCalculation(trainingData,netOutputArray);
    fprintf("epoc number : %d complete\n",epoc);
    % runs over the testing data set
    for i=1:testX
        % loads in data to the inout matrix
        inputs(1,1) = testingData(i,1);
        inputs(2,1) = testingData(i,2);
        inputs(3,1) = testingData(i,3);
        % gets the target value from the data file
        target = testingData(i,4);
        % calculates the network out put and nodes activation
        [netoutPut,nodes] = calculateNetwork(nodes,inputs,sigma);
        % stores the network output
        netOutputTest(i,1) = netoutPut;
    end
    % stores the error of the network on the test data
    errorTest(epoc,1) = errorCalculation(testingData,netOutputTest);
    % loops over the valadation data
     for i=1:vX
         % loads in valvation data to input matrix
        inputs(1,1) = valadationData(i,1);
        inputs(2,1) = valadationData(i,2);
        inputs(3,1) = valadationData(i,3);
        % loads target value from the file
        target = valadationData(i,4);
        % calculates the network output
        [netoutPut,nodes] = calculateNetwork(nodes,inputs,sigma);
        % stores the network output
        netOutputValadation(i,1) = netoutPut;
     end
    % calculate the networks error on the valadation data
    errorValadation(epoc,1) = errorCalculation(valadationData,netOutputValadation);
    
  end
end
% plots the error of the network
figure(1)
hold on 
plot(error,'b-');
plot(errorTest,'r-');
plot(errorValadation,'g-');
hold off
legend('Training error','Test error')
% plots the network function 
figure(2)
hold on
plot(trainingData(:,1)*365,trainingData(:,4)*100000);
plot(trainingData(:,1)*365,netOutputArray(:,1)*100000,'g');
hold off
legend('Training Target','Network Output')
% plots the networks proformance on the testing data
figure(3)
hold on
plot(testingData(:,1)*365,testingData(:,4)*100000);
plot(testingData(:,1)*365,netOutputTest(:,1)*100000,'g');
hold off
legend('Testing Target','Network Testing Output')
% plots the networks proformance on the valadation data
figure(4)
hold on
plot(valadationData(:,1)*365,valadationData(:,4)*100000);
plot(valadationData(:,1)*365,netOutputValadation(:,1)*100000,'g');
hold off
legend('Valadation Target','Network valadation Output')
