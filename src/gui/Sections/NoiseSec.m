classdef NoiseSec < handle
    properties
        parent % Parent panel
        system System % System object
    end

    methods
        function this = NoiseSec(panel, s)
            this.parent = panel;
            this.system = s;
            n_i = uigridlayout(panel, [2 2]);
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
            noise_sld = uislider(n_ii, "ValueChangedFcn",@(src,event) this.updateSlider(src,event, noisy_pulse, x_noisy));
            noise_sld.Limits = [-10 10];
            noise_sld.Value = 0;
            noise_sld.Layout.Row = 5;
            noise_sld.Layout.Column = 1;
        
            noisy_pulse.Layout.Row = 1;
            noisy_pulse.Layout.Column = 2;
            plot(noisy_pulse,x_noisy,out_y);
            ylim(noisy_pulse, [-7 7]);
        end

        function updateSlider(this, ~, event, noisy_pulse, x)
            p_s = this.system.inputFilter.pulseShape;
            y = GeneratePulse(x, p_s);
            new_out_y = ApplyNoise(y, event.Value); 
            plot(noisy_pulse, x, new_out_y);
        end
    end
end