classdef OutputFilter < handle
    properties
        inputBandLimited 
        areaCovered
        lowPassFreq
        nyquistLimit
    end

    methods
        function outputFilterObj =  OutputFilter()
            outputFilterObj.inputBandLimited = false; 
            outputFilterObj.nyquistLimit = false;
            outputFilterObj.areaCovered = 99;

        end

        % returns a perfect lowpass, retaining 99% of the spectral energy
        % of the impulse
        function out = construct(this, input, percentage)
            if nargin == 3
                this.areaCovered = percentage;
            end

            if this.inputBandLimited
                out = x ~= 0;
            else 

                A = trapz(input);
                esd = abs(input) .^ 2;
                int_esd = cumtrapz(esd);
                area = int_esd <= percentage / 100;
                n_z = nnz(~area);
                shifted_area = zeros(size(area));
                if n_z == 0
                    printf("The provided spectral density does not contain %d power\n", percentage);
                    out = ones(1,size(input));
                    return;
                end
                len = length(shifted_area(uint32((n_z + 1)/2):end));
                shifted_area(uint32((n_z + 1)/2):end) = area(1:len);
                out = shifted_area;
            end
        end

        function y =  apply(this, input)
        
        end
    end
end