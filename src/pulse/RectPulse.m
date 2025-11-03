% Naive implementation of a discrete symmetrical rectangular impulse
% over a given vector x, multiplied by factor a
% No external dependencies, i.e the communication toolbox
% Plots a graph based on the arguments passed, that doesn not interfere
% with the return variables
% TODO: check for communications toolbox and fallback onto rectpuls function
% if available
function out = RectPulse(x, a, mid, width, toPlot)
arguments
    x double
    a double = 1
    mid (1,1) double = 0
    width (1,1) double = 1
    toPlot string = 'false'
end
    out = zeros(1, length(x))
    samp_rate = (abs(x(1)) + abs(x(length(x))))/(length(x) - 1)
    x_vals = (mid-width/2):samp_rate:(mid+width/2)
    x_vals_it = 1
    for i = 1:length(x)
        if (x_vals_it <= length(x_vals) && ...
                abs(x_vals(x_vals_it) - x(i)) < 1e-12)  
            fprintf("%d %d", x(i), x_vals(x_vals_it))
            out(i) = a
            x_vals_it = x_vals_it + 1
        end
    end

    if toPlot == 't' | toPlot == "true"
        plot(x, out, 'Color', 'y', 'LineWidth', 1.5);
        ylim([min(out) * 2 max(out)*2])
        Global();
    end 
end
