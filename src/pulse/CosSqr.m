function out = CosSqr(x, a, mid, width, toPlot)
arguments
    x double
    a double = 1
    mid (1,1) double = 0
    width (1,1) double = 1
    toPlot string = 'false'
end
    out = RectPulse(x, a, mid, width, 'f')
    cossqr = a * cos(pi*x/width).^2

    out = out .* cossqr

    if toPlot == 't' | toPlot == "true"
        plot(x, out, 'Color', 'y', 'LineWidth', 1.5);
        ylim([min(out) * 2 max(out)*2])
        Global();
    end 
end
