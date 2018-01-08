testingData = importdata('data\2016 Data set.csv',',');
trainingData = importdata('data\2012 Data set.csv',',');

[X,Y] = size(trainingData);
[testX, testY] = size(testingData);
num = floor(X/8);
[id,centers] = kmeans(trainingData(:,1:end-1),num);

[centerX, centerY] = size(centers);

sigma = 1.0;

%nodes = zeros(X,5);

nodes = zeros(centerX,5);

inputs = zeros(3,1);

%center = zeros(3,1);


for i =1:centerX
    nodes(i,1) = centers(i,1);
    nodes(i,2) = centers(i,2);
    nodes(i,3) = centers(i,3);
    nodes(i,4) = 0;
    nodes(i,5) = 1; %rand(1);
end

loopCount = 100;

netOutputArray = zeros(X,1);
netOutputTest = zeros(testX,1);
nodeRecruted =0;

error = zeros(loopCount,1);
errorTest = zeros(loopCount,1);
for dataLoop=1:4
 [trainingData,X] = changeDataset(dataLoop);
  netOutputArray = zeros(X,1);
  for epoc=1:loopCount
    
    for i=1:X
        
        inputs(1,1) = trainingData(i,1);
        inputs(2,1) = trainingData(i,2);
        inputs(3,1) = trainingData(i,3);
        target = trainingData(i,4);
        
        [netoutPut,nodes] = calculateNetwork(nodes,inputs,sigma);
        
        netOutputArray(i,1) = netoutPut;
        
        
        nodes = updateWeights(netoutPut,nodes,target);
    end
    error(epoc,1) = errorCalculation(trainingData,netOutputArray);
    fprintf("epoc number : %d complete\n",epoc);
    
    for i=1:testX
        inputs(1,1) = testingData(i,1);
        inputs(2,1) = testingData(i,2);
        inputs(3,1) = testingData(i,3);
        target = testingData(i,4);
        
        [netoutPut,nodes] = calculateNetwork(nodes,inputs,sigma);
        
        netOutputTest(i,1) = netoutPut;
    end
    errorTest(epoc,1) = errorCalculation(testingData,netOutputTest);
  end
end

figure(1)
hold on 
plot(error,'b-');
plot(errorTest,'r-');
hold off
legend('Training error','Test error')

figure(2)
hold on
plot(trainingData(:,1)*365,trainingData(:,4)*100000);
plot(trainingData(:,1)*365,netOutputArray(:,1)*100000,'g');
hold off
legend('Training Target','Network Output')

figure(3)
hold on
plot(testingData(:,1)*365,testingData(:,4)*100000);
plot(testingData(:,1)*365,netOutputTest(:,1)*100000,'g');
hold off
legend('Testing Target','Network Testing Output')