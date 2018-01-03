function [nodes] = updateWeights(output,target,learningRate,nodes,inputs)

[X,Y] = size(nodes);

    nodes = nodes + learningRate -((target - output) * output * (1-output)) * inputs;

end

