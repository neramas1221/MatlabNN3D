function [inputUpdate,outputUpdate,output] = calculateOutput(inputWeights,inputs,outputWeight,target)
        % calculates the sigmod activation of the input layer
        alphaTwo = 1/(1+exp(- inputWeights' * inputs));
        % flips the matrix
        alphaTwo = alphaTwo';
        % calculates the sigmod activation of all of the output weights
        output = 1/(1+exp(- outputWeight' * alphaTwo));
        % sums the output activation values from the hidden layer
        output = sum(output);
        % calulates the diffrence in the output and the target value
        diffThree = -(target - output) .* output .* (1-output);
        % calculates the diffrence in the input weights and the differance 
        % in the network output 
        diffTwo = diffThree .* outputWeight .* alphaTwo .*(1-alphaTwo);
        % input update is the update values for the input weights
        inputUpdate = diffTwo' .* inputs;
        % output update is the update values for the output weights
        outputUpdate = diffThree .* alphaTwo;

end

