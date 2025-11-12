function y = Noise(input, a, mode)
arguments
    a double % Noise intensity
    mode int 
end
    s = size(input);
    noise = wgn(s(1), s(2), a);
    y = input + noise;
end