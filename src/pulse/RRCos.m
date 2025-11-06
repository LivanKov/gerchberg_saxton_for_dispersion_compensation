% Naive root raised cosine implementation
% No external dependencies
% Important: the zeros of the RRC pulse are not found at multiples of T
% For now, assume that T = 1

function y = RRCos(x, a , toPlot)
arguments
    x double
    a (1,1) double = 1
    toPlot string = 'false'
end
    T = 1;
    z = x == 0;
    q = abs(x) == T/(4 * a);

    y = 1 * T * numer(x, a, T) ./ denom(x, a, T);
    y(q) = a/(T * sqrt(2)) * ((1 + 2/pi) * sin(pi/(4*a)) + (1 - 2/pi) * cos(pi/(4*a)));
    y(z) = 1 / T * (1 + a*(4 / pi - 1));
    
    if toPlot == 't' | toPlot == "true"
        plot(x, y, 'Color', 'y', 'LineWidth', 1.5);
        ylim([min(y) * 2 max(y)*2])
        GlobalPlotSettings();
    end 
end

function y = numer(x, a, T) 
arguments
    x double
    a double
    T double
end
    y = sin(pi*x/T*(1-a)) + 4 * a * x/T .* cos(pi*x/T*(1 + a));
end

function y = denom(x, a, T)
arguments
    x double
    a double
    T double
end
    y = pi * x/T .* (1 - (4*a*x/T).^2); 
end