classdef OutputFilter < handle
    properties
        areaCovered
        lowPassFreq
        nyquistLimit
    end

    methods
        function outputFilterObj =  OutputFilter()
            outputFilterObj.nyquistLimit = false;
            outputFilterObj.areaCovered = 95;

        end

        % returns a perfect lowpass, retaining 99% of the spectral energy
        % of the impulse
        function out = construct(this, f, input, percentage)
            if nargin == 3
                this.areaCovered = percentage;
            end

            centre_freq = min(abs(f));
            esd = abs(input) .^ 2;
            total = trapz(f_vec, esd);
            desired = total * percentage / 100;
            ind = int_esd <= desired;
            pos_filter = zeros(1, 5);
            if n_z == 0
                printf("The provided spectral density does not contain %d power\n", percentage);
                out = ones(1,size(input));
                return;
            end
        end

        function y =  apply(this, input)
        end
    end
end