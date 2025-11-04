% Naive implementation of a discrete dirac impulse
% over a given vector x, multiplied by factor a
% No external dependencies i.e the symbolic math toolbox
% Plots a graph based on the arguments passed, that doesn not interfere
% with the return variables
function y = DiscPulse(x, a, rate, start, num, toPlot)
arguments
    x double
    a double = 1
    rate (1,1) double = 1
    start (1,1) double = 0
    num (1,1) double = 1
    toPlot string = 'false'
end
    y = zeros(1, length(x))
    x_vals = start:rate:rate*num
    x_vals_it = 1;
    for i = 1:length(x)
        if (x_vals_it < length(x_vals) && abs(x(i) - x_vals(x_vals_it)) < 1e-12)
            y(i) = a
            x_vals_it = x_vals_it + 1
        end
    end

    if toPlot == 't' | toPlot == "true"
        plot(x, y, 'Color', 'y', 'LineWidth', 1.5);
        ylim([min(y) * 2 max(y)*2])
        GlobalPlotSettings();
    end 
end
