function GlobalPlotSettings(ax)
    if nargin == 1
        ax.Color = 'k';  
        ax.XGrid = 'on';
        ax.YGrid = 'on';
        ax.XMinorGrid = 'on';
        ax.YMinorGrid = 'on';
        
        ax.GridColor       = [0.5 0.5 0.5];
        ax.GridAlpha       = 0.3;
        ax.MinorGridColor  = [0.3 0.3 0.3];
        ax.MinorGridAlpha  = 0.2;
        
        ax.XColor = 'w';                 
        ax.YColor = 'w';
        ax.TickDir = 'out';
        ax.Box = 'off';
    else
        set(gcf, 'Color', 'k');        
        set(gca, 'Color', 'k');       
        
        grid on;
        set(gca, 'GridColor', [0.5 0.5 0.5]);   
        set(gca, 'GridAlpha', 0.3);    
        set(gca, 'MinorGridColor', [0.3 0.3 0.3]);
        set(gca, 'MinorGridAlpha', 0.2);
        grid minor;
    
        set(gca, 'XColor', 'w', 'YColor', 'w');  % axis labels/ticks white
        set(gca, 'TickDir', 'out');
        set(gca, 'Box', 'off');
    end
end