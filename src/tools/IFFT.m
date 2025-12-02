% A simple Wrapper for matlab's builtin
% IFFT function
% Simplifies creating a fitting frequency domain and scaling
% Treats the signal as truly continouous
function [t, x] = IFFT(f, s, toPlot)
    if nargin < 3
        toPlot = false;
    end


    if toPlot == 't' || toPlot == "true"
        plot(t, x, 'Color', 'y', 'LineWidth', 1.5);
        ylim([min(x) * 2 max(x)*2]);
        GlobalPlotSettings();
    end

end