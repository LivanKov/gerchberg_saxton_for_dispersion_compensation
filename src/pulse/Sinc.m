function y = Sinc(x, toPlot)
arguments
    x double
    toPlot string = 'false'
end
    y = ones(size(x));
    nz = (x ~= 0);
    px = pi * x(nz);
    y(nz) = sin(px) ./ px; 

    if toPlot == 't' | toPlot == "true"
        plot(x, y, 'Color', 'y', 'LineWidth', 1.5);
        ylim([min(y) * 2 max(y)*2])
        GlobalPlotSettings();
    end 
end