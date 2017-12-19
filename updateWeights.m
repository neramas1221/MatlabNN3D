function [nodes] = updateWeights(netoutput,nodes,target)

[X,Y] =size(nodes);
learningRate =0.2;


for i=1:X
    nodes(i,5) = nodes(i,5) + learningRate*(target-netoutput)*nodes(i,4);
end



end

