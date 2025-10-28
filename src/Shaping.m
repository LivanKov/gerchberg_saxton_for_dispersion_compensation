% Take vector of  time discrete impulses
% Convolve them with a pulse shape
% Output a vector containing the result of the convolution
% TODO: Output a plot showcasing the input signal and the output
% TODO: Different colors for specific each input
% TODO: FFT convolution
% Current goal: minimize dependency on external toolboxes

function output = Shaping(input, shape)
    pulse = [1];
    switch shape 
        case PulseShape.RECT
            pulse = GenerateRect();
        case COS_SQR
            pulse = GenerateCosSqr();
        case RCOS
            pulse = GenerateRcos();
        case RRCOS
            pulse = GenerateRRCos();
        otherwise 
            pulse = null;
    end
    output = conv(pulse, input);
end
  
% rectangle impulse multiplied by factor x
% requires rectpuls from the signal processing toolbox
function pulse = GenerateRect(x)
    fprintf("Generating Rectangle");
    pulse = [1];
end

function pulse = GenerateCosSqr()
    fprintf("Generating Square Cosine");
    pulse = [1];
end

function pulse = GenerateRcos()
    fprintf("Generating RCOS");
    pulse = [1];
end

function pulse = GenerateRRCos()
    fprintf("Generating RRCOS");
    pulse = [1];
end

