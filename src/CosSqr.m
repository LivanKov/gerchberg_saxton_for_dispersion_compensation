function out = CosSqr(x, a, mid, width, plot)
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
        out(in) = cos(pi*x_vals(i)/width)^2
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
