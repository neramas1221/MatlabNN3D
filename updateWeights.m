function [nodes] = updateWeights(netoutput,nodes,target)

[X,Y] =size(nodes);
learningRate =0.2;

nodes(:,5) = nodes(:,5) + learningRate*(target-netoutput)*nodes(:,4);


end

