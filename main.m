testingData = importdata('data\2016_hourly.csv',',');
trainingData = importdata('data\2015_hourly.csv',',');

[X,Y] = size(trainingData);
[testX, testY] = size(testingData);
num = floor(X);
[id,centers] = kmeans(trainingData(:,1:end-1),num);

[centerX, centerY] = size(centers);

sigma = 0.8;

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
for epoc=1:loopCount
    
    for i=1:X
        
        inputs(1,1) = trainingData(i,1);
        inputs(2,1) = trainingData(i,2);
        inputs(3,1) = trainingData(i,3);
        target = trainingData(i,4);
        
        [netoutPut,nodes] = calculateNetwork(nodes,inputs,sigma);
        
        netOutputArray(i,1) = netoutPut;
        
%         for j =1:centerX %X
%             center(1,1) = nodes(j,1);
%             center(2,1) = nodes(j,2);
%             center(3,1) = nodes(j,3);
            %if center == inputs
                nodes = updateWeights(netoutPut,nodes,target);
               % nodeRecruted = 1;
            %end
        %end
        
%         if nodeRecruted == 0
%             for k=1:X
%                 if nodes(k,1) == 9999
%                     nodes(k,1) = inputs(1,1);
%                     nodes(k,2) = inputs(2,1);
%                     nodes(k,3) = inputs(3,1);
%                     nodes(k,5) = target;
%                     break;
%                     % k-means nearest neighbers
%                 end
%             end
%         end
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

figure(1)
hold on 
plot(error,'b-');
plot(errorTest,'r-');
hold off

figure(2)
hold on
plot(trainingData(:,1)*364,trainingData(:,4));
plot(trainingData(:,1)*364,netOutputArray(:,1),'g');
hold off