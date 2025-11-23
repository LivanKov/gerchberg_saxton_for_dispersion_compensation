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
        input
        Output
        State SystemState
        currentVals; % current values output by the filter etc.
        t_vec
    end

    properties(Constant)
        SYMBOL_PRECISION = 0.01 % vector granularity / Precision
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

        function updatePulse(this, pulse)
            i_f = this.inputFilter;
            i_f.pulseShape = pulse;
            this.currentVals = DiscPulse(this.t_vec, this.input.stream, ...
                System.SAMPLING_INTERVAL, System.START);
        end

        function ingest(this, stream)
            in = this.input;
            in.readInput(stream);
            this.rebuildTimeVec();
            this.State = SystemState.INPUT_READ;
            this.currentVals = DiscPulse(this.t_vec, in.stream, ...
                System.SAMPLING_INTERVAL, System.START);
        end

        function shapeInput(this)
            this.State = SystemState.PULSE_SHAPED;
            out = this.inputFilter.passThrough(this.currentVals);
            this.currentVals = out;
        end

        function addNoise(this, a)
            this.State = SystemState.NOISE_ADDED;
            noisy_vals = ApplyNoise(this.currentVals, a);
            this.currentVals = noisy_vals;
        end

        function plot(this)
            if isempty(this.t_vec) || isempty(this.currentVals)
                return
            end

            plot(this.t_vec, this.currentVals, 'Color', 'y', 'LineWidth', 1.5);
            ylim([min(this.currentVals) * 2 max(this.currentVals)*2]);
            GlobalPlotSettings();
        end
    end

    methods(Access = private)
        function rebuildTimeVec(this)
            stream = this.input.stream;
            len = System.SAMPLING_INTERVAL * length(stream);
            this.t_vec = System.START:System.SYMBOL_PRECISION:len;
        end
    end
end