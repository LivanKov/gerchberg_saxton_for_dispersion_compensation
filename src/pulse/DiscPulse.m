% Naive implementation of a discrete dirac impulse
% over a given vector x, multiplied by factor a
% No external dependencies i.e the symbolic math toolbox
% Plots a graph based on the arguments passed, that doesn not interfere
% with the return variables
function out = DiscPulse(x, a, rate, start, num, toPlot)
arguments
    x double
    a double = 1
    rate (1,1) double = 1
    start (1,1) double = 0
    num (1,1) double = 1
    toPlot string = 'false'
end
    out = zeros(1, length(x))
    x_vals = start:rate:rate*num;
    for i = 1:(length(x_vals) - 1)
        in = find(x == x_vals(i))
        out(in) = a
    end

    if toPlot == 't' | toPlot == "true"
        plot(x, out, 'Color', 'y', 'LineWidth', 1.5);
        ylim([min(out) * 2 max(out)*2])
        Global();
    end 
end
