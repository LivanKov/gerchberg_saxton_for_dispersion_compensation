function y = CosSqr(x, a, mid, width, toPlot)
arguments
    x double
    a double = 1
    mid (1,1) double = 0
    width (1,1) double = 1
    toPlot string = 'false'
end
    y = RectPulse(x, a, mid, width, 'f');
    cossqr = a * cos(pi*x/width).^2;

    y = y .* cossqr;

    if toPlot == 't' | toPlot == "true"
        plot(x, y, 'Color', 'y', 'LineWidth', 1.5);
        ylim([min(y) * 2 max(y)*2]);
        GlobalPlotSettings();
    end 
end
