% Naive implementation of a discrete symmetrical rectangular impulse
% over a given vector x, multiplied by factor a
% No external dependencies, i.e the communication toolbox
% Plots a graph based on the arguments passed, that doesn not interfere
% with the return variables
% TODO: check for communications toolbox and fallback onto rectpuls function
% if available
function y = RectPulse(x, a, mid, width, toPlot)
arguments
    x double
    a double = 1
    mid (1,1) double = 0
    width (1,1) double = 1
    toPlot string = 'false'
end
    samp_rate = (abs(x(1)) + abs(x(length(x))))/(length(x) - 1);
    x_vals = (mid-width/2):samp_rate:(mid+width/2);
    y = abs(x) <= x_vals(end);

    if toPlot == 't' | toPlot == "true"
        plot(x, y, 'Color', 'y', 'LineWidth', 1.5);
        ylim([min(y) * 2 max(y)*2]);
        GlobalPlotSettings();
    end 
end
