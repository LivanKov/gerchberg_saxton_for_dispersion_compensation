classdef OutputSec < handle
    properties
        parent % Parent panel
    end

    methods
        function this = OutputSec(panel)
            this.parent = panel;
        end
    end
end