% Naive implementation of a discrete symmetrical rectangular impulse
% over a given vector x, multiplied by factor a
% No external dependencies, i.e the communication toolbox
% Plots a graph based on the arguments passed, that doesn not interfere
% with the return variables
% TODO: check for communications toolbox and fallback onto rectpuls function
% if available
function out = RectPulse(x, a, mid, width, plot)
arguments
    x double
    a double = 1
    mid (1,1) double = 0
    width (1,1) double = 1
    plot string = "no"
end
    out = zeros(1, length(x))
    samp_rate = (abs(x(1)) + abs(x(length(x))))/(length(x) - 1)
    x_vals = (mid-width/2):samp_rate:(mid+width/2);
    for i = 1:length(x_vals)
        in = find(ismembertol(x, x_vals(i)))
        out(in) = a
    end

    %{
    if plot == "yes"
        plot(x_vals);
        title('Singular Dirac impulse')
        xlabel('Time')
        ylabel('Amplitude')
    end
    %}
end
