function [nodes] = updateWeights(netoutput,nodes,target)
% gets the size of the nodes
[X,Y] =size(nodes);
% sets the learning rate
learningRate =0.2;
% loops over the nodes
for i=1:X
    % updates the nodes based on there activation and the output of the
    % network - the target value
    nodes(i,5) = nodes(i,5) + learningRate*(target-netoutput)*nodes(i,4);
end
end

