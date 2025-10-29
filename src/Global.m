function Global()
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