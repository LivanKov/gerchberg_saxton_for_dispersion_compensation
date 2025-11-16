classdef RecSec < handle
    properties
        parent % Parent panel
    end

    methods
        function this = RecSec(panel)
            this.parent = panel;
        end
    end
end