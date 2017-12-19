%testingData = importdata('',',');
trainingData = importdata('dataset.csv',',');
sigma = 0.3;
[X,Y] = size(trainingData);
nodes = zeros(X,5);
inputs = zeros(3,1);
center = zeros(3,1);
for i =1:X
    nodes(i,1) =9999;
    nodes(i,2) = 9999;
    nodes(i,3) = 9999;
    nodes(i,4) = 0;
    nodes(i,5) = 1;
end
loopCount =5;
netOutputArray = zeros(X,1);
nodeRecruted =0;

error = zeros(loopCount,1);

for epoc=1:loopCount
    
    for i=1:X
        
        inputs(1,1) = trainingData(i,1);
        inputs(2,1) = trainingData(i,2);
        inputs(3,1) = trainingData(i,3);
        target = trainingData(i,4);
        
        [netoutPut,nodes] = calculateNetwork(nodes,inputs,sigma);
        
        netOutputArray(i,1) = netoutPut;
        
        for j =1:X
            center(1,1) = nodes(j,1);
            center(2,1) = nodes(j,2);
            center(3,1) = nodes(j,3);
            if center == inputs
                nodes = updateWeights(netoutPut,nodes,target);
                nodeRecruted = 1;
            end
        end
        
        if nodeRecruted == 0
            for k=1:X
                if nodes(k,1) == 9999
                    nodes(k,1) = inputs(1,1);
                    nodes(k,2) = inputs(2,1);
                    nodes(k,3) = inputs(3,1);
                    nodes(k,5) = target;
                    break;
                    % k-means nearest neighbers
                end
            end
        end
    end
    error(epoc,1) = errorCalculation(trainingData,netOutputArray);
    fprintf("epoc number : %d complete\n",epoc);
end
figure(1)
hold on 
plot(error,'b-');
hold off

figure(2)
hold on
plot(trainingData(:,1)*364,trainingData(:,4));
plot(trainingData(:,1)*364,netOutputArray(:,1),'g');
hold off