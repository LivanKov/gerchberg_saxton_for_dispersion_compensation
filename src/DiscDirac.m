% Naive implementation of a discrete dirac impulse
% over a given vector x, multiplied by factor a
% No external dependencies i.e the symbolic math toolbox
% Plots a graph based on the arguments passed, that doesn not interfere
% with the return variables
function out = DiscDirac(x, a, rate, start, num, plot)
arguments
    x double 
    a double = 1
    rate (1,1) double = 1
    start (1,1) double = 0
    num (1,1) double = 1
    plot string = "no"
end
    out = zeros(1, length(x))
    x_vals = start:rate:rate*num;
    for i = 1:(length(x_vals) - 1)
        in = find(x == x_vals(i))
        out(in) = a
    end
end
