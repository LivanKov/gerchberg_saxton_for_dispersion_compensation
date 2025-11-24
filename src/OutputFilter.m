classdef OutputFilter < handle
    properties
        inputBandLimited boolean 
        totalPowerFilter double
    end

    methods
        function outputFilterObj = OutputFilter()
            outputFilterObj.inputBandLimited = false;
            outputFilterObj.totalPowerFilter = 0.99;
        end
    end
end