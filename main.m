%testingData = importdata('',',');
trainingData = importdata('dataset.csv',',');
sigma =0.3;
nodes = zeros(80,5);

[X,Y] = size(trainingData);
inputs = zeros(3,1);
center = zeros(3,1);
for i =1:80
    nodes(i,1) =9999;
    nodes(i,2) = 9999;
    nodes(i,3) = 9999;
    nodes(i,4) = 0;
    nodes(i,5) = 1;
end
netOutput = zeros(Y,1);
nodeRecruted =0;
for epoc=1:100
    for i=1:Y
        
        inputs(1,1) = trainingData(i,1);
        inputs(2,1) = trainingData(i,2);
        inputs(3,1) = trainingData(i,3);
        target = trainingData(i,4);
        
        [netoutPut,nodes] = calculateNetwork(nodes,inputs,sigma);
        
        netOutput(i,1) = netoutPut;
        
        for j =1:80
            center(1,1) = nodes(j,1);
            center(2,1) = nodes(j,2);
            center(3,1) = nodes(j,3);
            if center == inputs
                nodes = updateWeights(netOutput,nodes,target,inputs);
                nodeRecruted = 1;
            end
        end
        
        if nodeRecruted == 0
            for k=1:80
                if nodes(k,1) == 9999
                    nodes(k,1) = inputs(1,1);
                    nodes(k,2) = inputs(2,1);
                    nodes(k,3) = inputs(3,1);
                    nodes(k,5) = target;
                    % k-means nearest neighbers
                end
            end
        end
    end
end


hold on
plot(trainingData(:,4));
hold off