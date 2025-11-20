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
            start = System.START - len / 2;
            sym_time_vec = start:System.PRECISION:(len/2);
            pulse = GeneratePulse(sym_time_vec, inputFilterObj.pulseShape);
            out = conv(input, pulse, 'same');
        end
    end
end