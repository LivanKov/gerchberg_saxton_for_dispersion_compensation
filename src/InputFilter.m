classdef InputFilter < handle
    properties
        pulseShape PulseShape
    end
    methods
        function inputFilterObj = InputFilter
            inputFilterObj.pulseShape = PulseShape.RECT;
        end

        function out = passThrough(inputFilterObj, input)
            len = System.SAMPLING_INTERVAL * length(input);
            time_vec = System.START:System.PRECISION:len;
            pulse = GeneratePulse(time_vec, inputFilterObj.pulseShape);
            out = conv(input, pulse, 'same');
        end
    end
end