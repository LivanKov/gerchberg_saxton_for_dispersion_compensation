% The main window, containing the core of the visual application
% TODOs: 
%   Input overview
%   Noise overview
%   Receiver
%   Output overview

% Display Signalleistung???

function MainView
    s = System;
    f = uifigure('Name','ComViewUI');
    f.Position(3:4) = [600 600];
    f.Resize = "off";
    g = uigridlayout(f,[1 1]);
    tabs = uitabgroup(g);
    in_sec = uitab(tabs,'Title','Input');
    n_sec = uitab(tabs,'Title','Noise');
    uitab(tabs,'Title','Receiver');
    uitab(tabs,'Title','Output');
    uitab(tabs, 'Title', 'Statistic');
    
    % Input section
    g_i = uigridlayout(in_sec, [3 1]);
    g_i.RowHeight = {180, '1x', 100};
    g_i1 = uigridlayout(g_i);
    g_i1.ColumnWidth = {100, '1x', '1x'};
    g_i1.RowHeight = {160};
    g_i1.Layout.Column = 1;
    g_i1.Layout.Row = 1;

    x = -5:0.01:5;
    p_s = s.inputFilter.pulseShape;
    y = GeneratePulse(x, p_s);
    t_pulse = uiaxes(g_i1);
    f_pulse = uiaxes(g_i1);

    dd_panel = uipanel(g_i1);
    dd_panel.Layout.Row = 1;
    dd_panel.Layout.Column = 1;
    dd_panel.BorderType = 'none';

    dd_label = uilabel(dd_panel);
    dd_label.Text = "Pulse Shape";
    dd_label.FontSize = 12;
    dd_label.Position(1:3) = [10 120 80];


    pulse_dd = uidropdown(dd_panel, ...
        "ValueChangedFcn",@(src,event) updatePulse(src,event, s, t_pulse, x));
    pulse_dd.Placeholder = 'Pulse Shape';
    pulse_dd.Items = getPulseShapes();
    pulse_dd.Position(1:3) = [5 100 80];
    pulse_dd.FontSize = 10;

    t_pulse.Layout.Row = 1;
    t_pulse.Layout.Column = 2;
    ylim(t_pulse, [-1 2]);

    f_pulse.Layout.Row = 1;
    f_pulse.Layout.Column = 3;

    plot(t_pulse,x,y);
    % GlobalPlotSettings(t_pulse);
    
    g_i2 = uigridlayout(g_i);
    g_i2.ColumnWidth = {120, '1x'};
    g_i2.RowHeight = {110};
    g_i2.Layout.Column = 1;
    g_i2.Layout.Row = 2;


    input_panel = uipanel(g_i2);
    input_panel.Layout.Row = 1;
    input_panel.Layout.Column = 2;
    input_panel.BorderType = 'none';

    input_txt_area = uitextarea(input_panel, "Placeholder", "Enter message");
    input_txt_area.Position(1:4) = [5 1 180 110];

    upload_txt_btn = uibutton(input_panel, ...
        "Text", "Upload Text", ...
        "ButtonPushedFcn", @(src, event) readInputText(src, event, input_txt_area));
    upload_txt_btn.Position(1:4) = [200 90 80 20];

    upload_txt_switch = uiswitch(input_panel);
    upload_txt_switch.Items = ["Raw" "Binary"];
    upload_txt_switch.Position(1:2) = [230 60];
    upload_txt_switch.ValueChangedFcn = @(src, event) updateTextInputMode( ...
        src, event, s);

    upload_btn = uibutton(input_panel, ...
        "Text", "Upload File", ...
        "ButtonPushedFcn", @(src, event)openFileUpload);
    upload_btn.Enable = 'off';
    upload_btn.Position(1:4) = [200 30 80 20];

    bg = uibuttongroup(g_i2, "SelectionChangedFcn", @(bg, event) uploadSelectionChange(bg, event, ...
        upload_btn, input_txt_area, upload_txt_btn));
    opt_1 = uiradiobutton(bg,"Text","Enter message", ...
        "Position",[10 50 100 22]);
    opt_1.Tag = 'msg';
    opt_2 = uiradiobutton(bg,"Text","Upload file", ...
        "Position",[10 28 100 22]);
    opt_2.Tag = 'file';
    bg.Layout.Row = 1;
    bg.Layout.Column = 1;
    opt_1.FontSize = 10;
    opt_2.FontSize = 10;

    % Noise section

    n_i = uigridlayout(n_sec, [2 2]);
    x_noisy = -5:0.01:5;
    pulse_shape = s.inputFilter.pulseShape;
    y_noisy = GeneratePulse(x_noisy, pulse_shape);
    n_ii = uigridlayout(n_i, [5 1]);
    n_ii.Layout.Row = 1;
    n_ii.Layout.Column = 1;
    out_y = ApplyNoise(y_noisy, 0);
    noisy_pulse = uiaxes(n_i);
    mode_dd = uidropdown(n_ii);
    mode_dd.Items = {'Additive White Noise'};
    mode_dd.Layout.Row = 1;
    mode_dd.Layout.Column = 1;
    noise_sld = uislider(n_ii, "ValueChangedFcn",@(src,event)updateSlider(src,event, noisy_pulse, x_noisy, s));
    noise_sld.Limits = [-10 10];
    noise_sld.Value = 0;
    noise_sld.Layout.Row = 5;
    noise_sld.Layout.Column = 1;

    noisy_pulse.Layout.Row = 1;
    noisy_pulse.Layout.Column = 2;
    plot(noisy_pulse,x_noisy,out_y);
    ylim(noisy_pulse, [-7 7]);
    GlobalPlotSettings(noisy_pulse);
    % Receiver section
    


    % Output section
end

function updateSlider(~, event, noisy_pulse, x, sys)
    disp("Updating slider");
    disp("Current Noise Level:" + event.Value + "dB");
    p_s = sys.inputFilter.pulseShape;
    y = GeneratePulse(x, p_s);
    new_out_y = ApplyNoise(y, event.Value); 
    plot(noisy_pulse, x, new_out_y);
end


function names_str = getPulseShapes
   names = enumeration(PulseShape.RECT);
   for i = 1:length(names)
       names_str(i) = string(names(i));
   end
end

function uploadSelectionChange(~, event, upload_btn, ...
    input_txt_area, upload_txt_btn)
   opt = event.NewValue.Tag;
   if opt == "file"
       upload_btn.Enable = 'on';
       input_txt_area.Enable = 'off';
       upload_txt_btn.Enable = 'off';
   else
       upload_btn.Enable = 'off';
       input_txt_area.Enable = 'on';
       upload_txt_btn.Enable = 'on';
   end
end

function readInputText(~, ~, input_txt_area)
    text = input_txt_area.Value{1};
    if (~~isempty(text))
        fprintf(2, "Error: Empty message string\n");
    else 
        bin_stream = StrToBin(text);
    end
end

function openFileUpload(~, ~)
    [file, path] = uigetfile('*.*', 'Select a File');
    if isequal(file,0)
        disp("User cancelled.");
        return;
    end

    fullpath = fullfile(path, file);
    disp("Selected file: " + string(fullpath));
end

function updatePulse(src, ~, sys, pulse_plot, x)
    new_pulse = src.Value;
    sys.updatePulse(new_pulse);
    p_s = sys.inputFilter.pulseShape;
    y = GeneratePulse(x, p_s);
    plot(pulse_plot,x, y);
end

function updateTextInputMode(src, ~, sys)
    val = src.Value;
    switch val
        case "Raw"
            sys.Input.mode = InputMode.TEXT_RAW;
        case "Binary"
            sys.Input.mode = InputMode.TEXT_BINARY;
    end
end
end