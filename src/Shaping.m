% Take vector of  time discrete impulses
% Convolve them with a pulse shape
% Output a vector containing the result of the convolution
% TODO: Output a plot showcasing the input signal and the output
% TODO: Different colors for specific each input
% TODO: FFT convolution
% Current goal: minimize dependency on external toolboxes

function output = Shaping(input, shape)
arguments
    input double
    shape (1,1) PulseShape
end
    pulse = [];
    switch shape 
        case PulseShape.RECT
            pulse = RectPulse(input);
        case COS_SQR
            pulse = CosSqr(input);
        case RCOS
            pulse = RCos(input);
        case RRCOS
            pulse = RRCos(input);
        otherwise 
            pulse = null;
    end
    output = conv(pulse, input);
end

