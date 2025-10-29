function out = RCos(x,rolloff, toPlot)
arguments
    x double
    rolloff (1,1) double = 1
    toPlot string = 'false'
end
    sinc = Sinc(x);

    out = sinc .* cos(rolloff * pi * x)./(1 - 4*rolloff^2 * x .^ 2)

    if toPlot == 't' | toPlot == "true"
        plot(x, out, 'Color', 'y', 'LineWidth', 1.5);
        ylim([min(out) * 2 max(out)*2])
        Global();
    end 
end