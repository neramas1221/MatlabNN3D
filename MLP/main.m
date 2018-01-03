targetData = importdata('data\2012 Data set.csv',',');
trainingData = importdata('data\2013 Data set.csv',',');

[X,Y] = size(trainingData);
learningRate =0.3;

hiddenNodeSize =X;

inputWeights = rand(4,hiddenNodeSize);
inputWeights(4,:) = 1;

outputWeight = rand(hiddenNodeSize,1);
outputWeight(4,:) = 1;

inputs = zeros(4,1);
outputValues = zeros(X,1);



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
    fprintf("epoc count : %d\n",epocs);
end

figure(1)
hold on
plot(trainingData(:,1)*365,trainingData(:,4)*100000);
plot(trainingData(:,1)*365,outputValues(:,1)*100000,'g');
hold off

% for epocs =1:100
%    for i=1:X
%     inputs(1,1) = trainingData(i,1);
%     inputs(2,1) = trainingData(i,2);
%     inputs(3,1) = trainingData(i,3);
%     % off set for the bias node
%     inputs(4,1) = 1;
%     target = trainingData(i,4);
%     y = inputs .* inputWeights;
%     o = 1/1+exp(y);
%     output = sum(o);
%     outputValues(i,1) = output;
%     inputWeights = updateWeights(output,target,learningRate,inputWeights,inputs);
%    end 
%    fprintf("epoc count : %d\n",epocs);
% end
% 
% plot(trainingData(:,1)*365,trainingData(:,4)*100000);
% plot(trainingData(:,1)*365,outputValues(:,1)*100000,'g');