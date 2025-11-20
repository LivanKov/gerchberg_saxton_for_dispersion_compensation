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
        State SystemState
        currentVals; % current values output by the filter etc.
    end

    properties(Access = private)
        t_vec % time vector used within the simulation
    end

    properties(Constant)
        PRECISION = 0.01 % vector granularity / Precision
        SAMPLING_INTERVAL = 1; % length of a single pulse
    end

    methods
        function sysObj = System(input)
            if nargin == 1
                sysObj.input = input;
            else
                i = Input;
                sysObj.input = i;
            end
            sysObj.State = SystemState.START;
            i_f = InputFilter;
            sysObj.inputFilter = i_f;
        end

        function updatePulse(sysObj, pulse)
            i_f = sysObj.inputFilter;
            i_f.pulseShape = pulse;
        end

        function ingest(sysObj, stream)
            in = sysObj.input;
            in.readInput(stream);
            sysObj.rebuildTimeVec();
            sysObj.State = SystemState.INPUT_READ;
            sysObj.currentVals = sysObj.input.stream;
        end

        function shapeInput(sysObj)
            sysObj.State = SystemState.PULSE_SHAPED;

        end
    end

    methods(Access = private)
        function rebuildTimeVec(sysObj)
            stream = sysObj.input.stream;
            len = System.SAMPLING_INTERVAL * length(stream);
            sysObj.t_vec = 0:System.PRECISION:len;
        end
    end
end