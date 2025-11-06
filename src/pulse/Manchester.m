% Naive implementation of the Manchester impulse
% No external toolbox dependencies

function y = Manchster(x)
    T = 1;
    y = zeros(size(x));
    low = abs(x) > T/4 & abs(x) < T/2;
    y(low) = -1;
    high = abs(x) < T/4;
    y(high) = 1;
end