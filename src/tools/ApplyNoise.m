function y = ApplyNoise(input, a)
arguments
    input double % input vector
    a double % Noise intensity
end
    s = length(input);
    noise = randn(1, s) * sqrt(a);
    y = input + noise;
end