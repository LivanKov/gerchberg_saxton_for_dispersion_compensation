function y = RRCos(x,rolloff, toPlot)
arguments
    x double
    rolloff (1,1) double = 1
    toPlot string = 'false'
end
    sinc = Sinc(x);

    y = sinc .* cos(rolloff * pi * x)./(1 - 4*rolloff^2 * x .^ 2)

    if toPlot == 't' | toPlot == "true"
        plot(x, y, 'Color', 'y', 'LineWidth', 1.5);
        ylim([min(y) * 2 max(y)*2])
        GlobalPlotSettings();
    end 
end