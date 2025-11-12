% The main window, containing the core of the visual application
% TODOs: 
%   Input overview
%   Noise overview
%   Receiver
%   Output overview

% Display Signalleistung???

function MainView
    f = uifigure('Name','ComViewUI');
    f.Position(3:4) = [600 500];
    f.Resize = "off";
    g = uigridlayout(f,[1 1]);
    tabs = uitabgroup(g, "SelectionChangedFcn",@displaySelection);
    in_sec = uitab(tabs,'Title','Input');
    n_sec = uitab(tabs,'Title','Noise');
    uitab(tabs,'Title','Receiver');
    uitab(tabs,'Title','Output');
    
    
    % Input section grid layout
    g_i = uigridlayout(in_sec, [3 1]);
    %g_ii = uigridlayout(g_i, [1 2]);
    pulse_dd = uidropdown(g_i);
    pulse_dd.Placeholder = 'Pulse Shape';
    pulse_dd.Items = getPulseShapes();
    pulse_dd.Layout.Row = 1;
    pulse_dd.Layout.Column = 1;
    
    bg = uibuttongroup(g_i);
    b1 = uiradiobutton(bg,"Text","Enter message","Position",[10 50 100 22]);
    b2 = uiradiobutton(bg,"Text","Upload file","Position",[10 28 100 22]);
    bg.Layout.Row = 2;
    bg.Layout.Column = 1;

    ax = uiaxes(g_i);

    input_txt_area = uitextarea(g_i, "Placeholder", "Enter message");
    input_txt_area.Layout.Row = 3;
    input_txt_area.Layout.Column = 1;

    n_i = uigridlayout(n_sec, [2 2]);
    x = -pi:0.01:pi;
    y = 5*sin(x);
    n_ii = uigridlayout(n_i, [5 1]);
    n_ii.Layout.Row = 1;
    n_ii.Layout.Column = 1;
    out_y = ApplyNoise(y, 0);
    noisy_pulse = uiaxes(n_i);
    mode_dd = uidropdown(n_ii);
    mode_dd.Items = {'Additive White Noise'};
    mode_dd.Layout.Row = 1;
    mode_dd.Layout.Column = 1;
    % Noise section grid layout
    noise_sld = uislider(n_ii, "ValueChangedFcn",@(src,event)updateSlider(src,event, y, out_y, noisy_pulse, x));
    noise_sld.Limits = [-100 100];
    noise_sld.Value = 0;
    noise_sld.Layout.Row = 5;
    noise_sld.Layout.Column = 1;

    noisy_pulse.Layout.Row = 1;
    noisy_pulse.Layout.Column = 2;
    plot(noisy_pulse,x,out_y);
    ylim(noisy_pulse, [-7 7]);
    noisy_pulse.XGrid = 'on';
    noisy_pulse.YGrid = 'on';

    noise_sld_2 = uislider(n_i, "ValueChangedFcn",@(src,event)updateSlider(src,event));
    noise_sld_2.Limits = [-100 100];
    noise_sld_2.Value = 0;
    noise_sld_2.Layout.Row = 2;
    noise_sld_2.Layout.Column = 1;

    noise_sld_3 = uislider(n_i, "ValueChangedFcn",@(src,event)updateSlider(src,event));
    noise_sld_3.Limits = [-100 100];
    noise_sld_3.Value = 0;
    noise_sld_3.Layout.Row = 2;
    noise_sld_3.Layout.Column = 2;
end


function displaySelection(src,event)
    t = event.NewValue;
    title = t.Title;
    disp("Viewing the " + title + " tab")
end

function updateSlider(src, event,y, out_y, noisy_pulse, x)
    disp("Updating slider");
    disp("Current Noise Level:" + event.Value + "dB");
    new_out_y = ApplyNoise(y, event.Value); 
    plot(noisy_pulse, x, new_out_y);
end


function names_str = getPulseShapes
   names = enumeration(PulseShape.RECT);
   for i = 1:length(names)
       names_str(i) = string(names(i));
   end
end
