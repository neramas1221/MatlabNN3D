testingData = importdata('',',');
trainingData = importdata('',',');

nodes = zeros(80,5);

[X,Y] = size(trainingData);

for i =1:80
    nodes(i,1) =9999;
    nodes(i,2) = 9999;
    nodes(i,3) = 9999;
    nodes(i,4) = 0;
    nodes(i,5) = 1;
end

for epoc=1:100
    for i=1:X
        
        inputX = trainingData(i,1);
        inputY = trainingData(i,2);
        inputZ = trainingData(i,3);
    end
end