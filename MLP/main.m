testData = importdata('data\2016 Data set.csv',',');
trainingData = importdata('data\2015 Data set.csv',',');

[X,Y] = size(trainingData);
[testX,testY] = size(testData);
learningRate =0.2;

hiddenNodeSize =34;%floor(X/240);

inputWeights = rand(4,hiddenNodeSize);
inputWeights(4,:) = 1;

outputWeight = rand(hiddenNodeSize,1);
outputWeight(4,:) = 1;

inputs = zeros(4,1);
outputValues = zeros(X,1);
outputTestValues = zeros(X,1);
error = zeros(100,1);
errorTest = zeros(100,1);

for epocs =1:100
    for i=1:X
        inputs(1,1) = trainingData(i,1);
        inputs(2,1) = trainingData(i,2);
        inputs(3,1) = trainingData(i,3);
        % off set for the bias node
        inputs(4,1) = 1;
        target = trainingData(i,4);
        
        aTwo = 1/(1+exp(- inputWeights' * inputs));
        aTwo = aTwo';
        output = 1/(1+exp(- outputWeight' * aTwo));
        output = sum(output);
        outputValues(i,1) = output;
        dThree = -(target - output) .* output .* (1-output);
        dTwo = dThree .* outputWeight .* aTwo .*(1-aTwo);
        d = dTwo' .* inputs;
        da = dThree .* aTwo;
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
%         dThree = -(target - output) .* output .* (1-output);
%         dTwo = dThree .* outputWeight .* aTwo .*(1-aTwo);
%         d = dTwo' .* inputs;
%         da = dThree .* aTwo;
%         inputWeights = inputWeights - learningRate * d;
%         outputWeight = outputWeight - learningRate * da;
    end
    
    error(epocs,1) = calculateError(trainingData,outputValues);
    errorTest(epocs,1) = calculateError(testData,outputTestValues);
    fprintf("epoc count : %d\n",epocs);
end

figure(1)
hold on
plot(trainingData(:,1)*365,trainingData(:,4)*100000);
plot(trainingData(:,1)*365,outputValues(:,1)*100000,'g');
hold off
figure(2)
hold on
plot(error,'b-');
plot(errorTest,'r-');
hold off