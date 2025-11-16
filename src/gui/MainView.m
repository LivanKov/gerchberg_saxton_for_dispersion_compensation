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
        
            n_i = uigridlayout(n_sec, [2 2]);
            x_noisy = -5:0.01:5;
            pulse_shape = s.inputFilter.pulseShape;
            y_noisy = GeneratePulse(x_noisy, pulse_shape);
            n_ii = uigridlayout(n_i, [5 1]);
            n_ii.Layout.Row = 1;
            n_ii.Layout.Column = 1;
            out_y = ApplyNoise(y_noisy, 0);
            noisy_pulse = uiaxes(n_i);
            mode_dd = uidropdown(n_ii);
            mode_dd.Items = {'Additive White Noise'};
            mode_dd.Layout.Row = 1;
            mode_dd.Layout.Column = 1;
            noise_sld = uislider(n_ii, "ValueChangedFcn",@(src,event) this.updateSlider(src,event, noisy_pulse, x_noisy, s));
            noise_sld.Limits = [-10 10];
            noise_sld.Value = 0;
            noise_sld.Layout.Row = 5;
            noise_sld.Layout.Column = 1;
        
            noisy_pulse.Layout.Row = 1;
            noisy_pulse.Layout.Column = 2;
            plot(noisy_pulse,x_noisy,out_y);
            ylim(noisy_pulse, [-7 7]);
            GlobalPlotSettings(noisy_pulse);
            % Receiver section
            
        
        
            % Output section
        end
        
        function updateSlider(~, ~, event, noisy_pulse, x, sys)
            disp("Updating slider");
            disp("Current Noise Level:" + event.Value + "dB");
            p_s = sys.inputFilter.pulseShape;
            y = GeneratePulse(x, p_s);
            new_out_y = ApplyNoise(y, event.Value); 
            plot(noisy_pulse, x, new_out_y);
        end
    end
end