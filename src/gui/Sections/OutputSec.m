classdef OutputSec < handle
    properties
        parent % Parent panel
        system System % System object
    end

    methods
        function this = OutputSec(panel)
            this.parent = panel;
        end
    end
end