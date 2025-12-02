classdef RecSec < handle
    properties
        parent % Parent panel
        system System % System object
    end

    methods
        function this = RecSec(panel, s)
            this.parent = panel;
            this.system = s;
            g = uigridlayout(this.parent, [1 1]);
            g.BackgroundColor = [0.12 0.12 0.15];
            sign_mag = uiaxes(g);

            % Dark mode settings
            sign_mag.Color = [0.18 0.18 0.21];
            sign_mag.XColor = [0.6 0.6 0.65];
            sign_mag.YColor = [0.6 0.6 0.65];
            sign_mag.GridColor = [0.3 0.3 0.35];
            sign_mag.MinorGridColor = [0.25 0.25 0.28];
        end
    end
end