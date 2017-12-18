function [networkOutput,nodes] = calculateNetwork(nodes,input,sigma)

[X,Y] = size(nodes);

weightSum =0;
actiationSum =0;

for i=1:X
    diff = ((input(1,1) - nodes(i,1))^2 ...
       + (input(2,1) - nodes(i,2))^2 + (input(3,1) - nodes(i,3))^2);
    activation = exp(-1/(2*sigma^2)*diff );
    nodes(i,4) = activation;
    weightSum = weightSum + nodes(i,5)*activation;
    actiationSum = actiationSum + activation;
end

if weightSum ~= 0 && actiationSum ~=0
    networkOutput = weightSum/actiationSum; 
else
    networkOutput =0;
end
end

