function [networkOutput,nodes] = calculateNetwork(nodes,input,sigma)
% gets the size of the node matrix
[X,Y] = size(nodes);
% sets the weight sum to 0
weightSum =0;
% sets the activation sum to 0
actiationSum =0;
% loops all of the nodes
for i=1:X
    % calculates the inputs - the centers
    diff = ((input(1,1) - nodes(i,1))^2 ...
       + (input(2,1) - nodes(i,2))^2 + (input(3,1) - nodes(i,3))^2);
   % gets the activation of the node
    activation = exp(-1/(2*sigma^2)*diff );
    % stores the activation of the node
    nodes(i,4) = activation;
    % addes the weight * by the activation to the weight sum
    weightSum = weightSum + nodes(i,5)*activation;
    % addes the ativation to the wactivation sum
    actiationSum = actiationSum + activation;
end
% avoids divide by zero error
if weightSum ~= 0 && actiationSum ~=0
    networkOutput = weightSum/actiationSum; 
else
    networkOutput =0;
end
end