function output = Shaping(input, shape)
    pulse;
    switch shape 
        case RECT
            pulse = GenerateRect();
        case COS_SQR
            pulse = GenerateCosSqr();
        case RCOS
            pulse = GenerateRcos();
        case RRCOS
            pulse = GenerateRRCOS();
        otherwise 
            pulse = null;
    end
     output = conv(pulse, input);
end
  

function pulse = GenerateRect()
    pulse = rectangularPulse(x);
end