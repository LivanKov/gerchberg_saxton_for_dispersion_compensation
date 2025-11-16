% This class encapsulates the communication system
% Core functionalities will be extended over 
% in order to simulate more conditions

% Properties:
%   InputFilter: used for pulse shaping via convolution 
%   OutputFilter: used for signal reconstruction; matched filter 
%   Noise: basic noise simulation. Add support for multiple modes
%   Input: input raw data and perform various operations
%   Output: output of the filter. Use to reconstruct the initially sent
%   State: monitor the state of the system
%   message

% Function definitions

classdef System < handle
    properties
        inputFilter InputFilter
        OutputFilter OutputFilter
        Noise
        input
        Output
        State
    end

    methods
        function sysObj = System(input)
            if nargin == 1
                sysObj.input = input;
            else
                i = Input;
                sysObj.input = i;
            end

            i_f = InputFilter;
            sysObj.inputFilter = i_f;
        end

        function updatePulse(inputObj, pulse)
            i_f = inputObj.inputFilter;
            i_f.pulseShape = pulse;
        end
    end
end