% The main window, containing the core of the visual application
% TODOs: 
%   Input overview
%   Noise overview
%   Receiver
%   Output overview

% Display Signalleistung???
classdef MainView < handle
    methods
        function this = MainView()
            s = System;
            f = uifigure('Name','ComViewUI');
            f.Position(3:4) = [600 600];
            f.Resize = "off";
            g = uigridlayout(f,[1 1]);
            tabs = uitabgroup(g);
            in_sec = uitab(tabs,'Title','Input');
            n_sec = uitab(tabs,'Title','Noise');
            uitab(tabs,'Title','Receiver');
            uitab(tabs,'Title','Output');
            uitab(tabs, 'Title', 'Statistic');
            
            % Input section
            InputSec(in_sec, s);
        
            % Noise section
            NoiseSec(n_sec, s);
        
            % Receiver section
            
            % Output section
        end
    end
end