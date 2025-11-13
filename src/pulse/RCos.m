% Naive Raised Cosine pulse implementation
% Based on Sinc function, with no external toolbox dependencies
% assume that T = 1 for now
% Impulse response:
%   h(t) = pi / 4T * sinc(1/2a) if t = |T/2a|
%   1/T * sinc(t/T) * cos(pi * a * t) / (1 - ((2*a*t)/T)^2) else

function y = RCos(x, a, toPlot)
arguments
    x double
    a (1,1) double = 1 % Rolloff
    toPlot string = 'false'
end
    % temporary value
    T = 1;

    sinc = Sinc(x/T, 'false');
    y = sinc;

    if a ~= 0
        denom = (1 - 4 * a^2 * (x/T).^2);
        s_t = cos(a * pi * x/T) ./ denom;
        y = y .* s_t;
        e = (abs(x) == T/(2*a));
        y(e) = pi / (4 * T) * Sinc(1/(2*a));
    end

    if toPlot == 't' | toPlot == "true"
        plot(x, y, 'Color', 'y', 'LineWidth', 1.5);
        ylim([min(y) * 2 max(y)*2]);
        GlobalPlotSettings();
    end 
end