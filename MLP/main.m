testData = importdata('data\2016 Data set.csv',',');
trainingData = importdata('data\2012 Data set.csv',',');
valadationData = importdata('data\2017 data set.csv',',');
[X,Y] = size(trainingData);
[testX,testY] = size(testData);
[vX,Vy] = size(valadationData);
learningRate =0.01;

hiddenNodeSize =62;%floor(X/240);

inputWeights = rand(4,hiddenNodeSize);
inputWeights(4,:) = 1;

outputWeight = rand(hiddenNodeSize,1);
outputWeight(4,:) = 1;

inputs = zeros(4,1);
outputValues = zeros(X,1);
outputTestValues = zeros(testX,1);
netOutputValadation = zeros(vX,1);
error = zeros(100,1);
errorTest = zeros(100,1);
errorValadation = zeros(100,1);

for loopCount=1:4
    [trainingData,X] = changeDataset(loopCount);
    outputValues = zeros(X,1);
for epocs =1:100
    for i=1:X
        inputs(1,1) = trainingData(i,1);
        inputs(2,1) = trainingData(i,2);
        inputs(3,1) = trainingData(i,3);
        % off set for the bias node
        inputs(4,1) = 1;
        target = trainingData(i,4);
        
        [d,da,output] = calculateOutput(inputWeights,inputs,outputWeight,target);

        outputValues(i,1) = output;
        inputWeights = inputWeights - learningRate * d;
        outputWeight = outputWeight - learningRate * da;
    end
    
    for i=1:testX
        inputs(1,1) = testData(i,1);
        inputs(2,1) = testData(i,2);
        inputs(3,1) = testData(i,3);
        % off set for the bias node
        inputs(4,1) = 1;
        target = testData(i,4);
        
        aTwo = 1/(1+exp(- inputWeights' * inputs));
        aTwo = aTwo';
        output = 1/(1+exp(- outputWeight' * aTwo));
        output = sum(output);
        outputTestValues(i,1) = output;
    end
    
     for i=1:vX
        inputs(1,1) = valadationData(i,1);
        inputs(2,1) = valadationData(i,2);
        inputs(3,1) = valadationData(i,3);
        % off set for the bias node
        inputs(4,1) = 1;
        target = valadationData(i,4);
        
        aTwo = 1/(1+exp(- inputWeights' * inputs));
        aTwo = aTwo';
        output = 1/(1+exp(- outputWeight' * aTwo));
        output = sum(output);
        netOutputValadation(i,1) = output;
    end
    
    error(epocs,1) = calculateError(trainingData,outputValues);
    errorTest(epocs,1) = calculateError(testData,outputTestValues);
    errorValadation(epocs,1) = calculateError(valadationData,netOutputValadation);
    fprintf("epoc count : %d\n",epocs);
end
end

figure(1)
hold on
plot(trainingData(:,1)*365,trainingData(:,4)*100000);
plot(trainingData(:,1)*365,outputValues(:,1)*100000,'g');
legend('Training Data','Network Output')
hold off
figure(2)
hold on
plot(valadationData(:,1)*365,valadationData(:,4)*100000);
plot(valadationData(:,1)*365,netOutputValadation(:,1)*100000,'g');
legend('Valadation Target','Network Output')
hold off
figure(3)
hold on
plot(error,'b-');
plot(errorTest,'r-');
plot(errorValadation,'g-');
legend('Train error','Test error','Valadation error')
hold off