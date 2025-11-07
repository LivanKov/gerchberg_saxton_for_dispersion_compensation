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

classdef System
    properties
        InputFilter
        OutputFilter
        Noise
        Input
        Output
        State
    end
end