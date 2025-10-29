function out = RCos(x,rolloff, a, mid, width, toPlot)
arguments
    x double
    rolloff (1,1) double = 1
    a double = 1
    mid (1,1) double = 0
    width (1,1) double = 1
    toPlot string = 'false'
end
    out = sin(pi*x)/pi*x * cos(roloff*pi*x)/(1-4*rolloff^2*x^2)

    if toPlot == 't' | toPlot == "true"
        plot(x, out, 'Color', 'y', 'LineWidth', 1.5);
        ylim([min(out) * 2 max(out)*2])
        Global();
    end 
end