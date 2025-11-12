function y = ApplyNoise(input, a)
arguments
    input double % input vector
    a double % Noise intensity
end
    s = size(input);
    noise = wgn(s(1), s(2), a);
    y = input + noise;
end