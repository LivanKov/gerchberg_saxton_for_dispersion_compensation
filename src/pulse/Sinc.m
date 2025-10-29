function out = Sinc(x, toPlot)
arguments
    x double
    toPlot string = 'false'
end
    out = sin(pi*x)./(pi*x);

    if toPlot == 't' | toPlot == "true"
        plot(x, out, 'Color', 'y', 'LineWidth', 1.5);
        ylim([min(out) * 2 max(out)*2])
        Global();
    end 
end