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
        t_vec
    end

    properties(Constant)
        PRECISION = 0.01 % vector granularity / Precision
        SAMPLING_INTERVAL = 1.0; % length of a single pulse
        START = 0; % Time vector start
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
            sysObj.currentVals = DiscPulse(sysObj.t_vec, in.stream, ...
                System.SAMPLING_INTERVAL, System.START);
        end

        function shapeInput(sysObj)
            sysObj.State = SystemState.PULSE_SHAPED;
            out = sysObj.inputFilter.passThrough(sysObj.currentVals);
            sysObj.currentVals = out;
        end

        function plot(sysObj)
            if isempty(sysObj.t_vec) || isempty(sysObj.currentVals)
                return
            end

            plot(sysObj.t_vec, sysObj.currentVals, 'Color', 'y', 'LineWidth', 1.5);
            ylim([min(sysObj.currentVals) * 2 max(sysObj.currentVals)*2]);
            GlobalPlotSettings();
        end
    end

    methods(Access = private)
        function rebuildTimeVec(sysObj)
            stream = sysObj.input.stream;
            len = System.SAMPLING_INTERVAL * length(stream);
            sysObj.t_vec = System.START:System.PRECISION:len;
        end
    end
end