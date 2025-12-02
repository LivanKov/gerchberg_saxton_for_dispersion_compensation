% A simple Wrapper for matlab's builtin
% FFT function
% Simplifies creating a fitting frequency domain and scaling
% Treats the signal as a truly continuous
function [f, s] = FFT(t, x, toPlot)
    if nargin < 3
        toPlot = false;
    end


    if toPlot == 't' || toPlot == "true"
        plot(f, s, 'Color', 'y', 'LineWidth', 1.5);
        ylim([min(s) * 2 max(s)*2]);
        GlobalPlotSettings();
    end

end