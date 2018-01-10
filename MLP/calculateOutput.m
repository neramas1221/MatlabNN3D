function [d,da,output] = calculateOutput(inputWeights,inputs,outputWeight,target)

        aTwo = 1/(1+exp(- inputWeights' * inputs));
        aTwo = aTwo';
        output = 1/(1+exp(- outputWeight' * aTwo));
        output = sum(output);
        
        dThree = -(target - output) .* output .* (1-output);
        dTwo = dThree .* outputWeight .* aTwo .*(1-aTwo);
        d = dTwo' .* inputs;
        da = dThree .* aTwo;

end

