classdef InputSec < handle
    properties (Access = private)
        parent % Parent panel
        system System % System object reference
        mode_label % Access the data mode label
        size_label % Access the data size label
    end

    methods
        function this = InputSec(panel, s)
            this.parent = panel;
            this.system = s;
            g_i = uigridlayout(this.parent, [3 1]);
            g_i.RowHeight = {180, '1x', '1x'};
            g_i1 = uigridlayout(g_i);
            g_i1.ColumnWidth = {110, '1x', 250};
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
                "ValueChangedFcn",@(src,event) this.updatePulse(src,event, s, t_pulse, x));
            pulse_dd.Placeholder = 'Pulse Shape';
            pulse_dd.Items = this.getPulseShapes();
            pulse_dd.Position(1:3) = [5 100 80];
            pulse_dd.FontSize = 10;
        
            t_pulse.Layout.Row = 1;
            t_pulse.Layout.Column = 2;
            ylim(t_pulse, [-1 2]);
        
            f_pulse.Layout.Row = 1;
            f_pulse.Layout.Column = 3;
        
            plot(t_pulse,x,y);
            
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
                "ButtonPushedFcn", @(src, event) this.readInputText(src, event, input_txt_area, s));
            upload_txt_btn.Position(1:4) = [200 90 80 20];
        
            upload_txt_switch = uiswitch(input_panel);
            upload_txt_switch.Items = ["Raw" "Binary"];
            upload_txt_switch.Position(1:2) = [230 60];
            upload_txt_switch.ValueChangedFcn = @(src, event) this.updateTextInputMode( ...
                src, event, s);
        
            upload_btn = uibutton(input_panel, ...
                "Text", "Upload File", ...
                "ButtonPushedFcn", @(src, event)this.openFileUpload(src, event, s));
            upload_btn.Enable = 'off';
            upload_btn.Position(1:4) = [200 30 80 20];
            
            input_mode_panel = uipanel(g_i2);
            input_mode_panel.Layout.Row = 1;
            input_mode_panel.Layout.Column = 1;
        
            bg = uibuttongroup(input_mode_panel, "SelectionChangedFcn", @(bg, event) this.uploadSelectionChange(bg, event, ...
                upload_btn, input_txt_area, upload_txt_btn, upload_txt_switch));
            bg.BorderType = 'none';
            opt_1 = uiradiobutton(bg,"Text","Enter message", ...
                "Position",[10 50 100 22]);
            opt_1.Tag = 'msg';
            opt_2 = uiradiobutton(bg,"Text","Upload file", ...
                "Position",[10 28 100 22]);
            opt_2.Tag = 'file';
            bg.Position(1:4) = [5 25 100 80];
            opt_1.FontSize = 10;
            opt_2.FontSize = 10;
        
            this.mode_label = uilabel(input_mode_panel);
            this.mode_label.Text = "Mode: ";
            this.mode_label.Position(1:3) = [15 25 50];
            this.mode_label.FontSize = 10;
        
            this.size_label = uilabel(input_mode_panel);
            this.size_label.Text = "Size: ";
            this.size_label.Position(1:3) = [15 5 50];
            this.size_label.FontSize = 10;
        
            input_analysis_panel = uipanel(g_i);
            input_analysis_panel.Layout.Column = 1;
            input_analysis_panel.Layout.Row = 3;
        
            input_analysis_graph = uiaxes(input_analysis_panel);
            input_analysis_graph.Position(4) = 250;
        end

        function names_str = getPulseShapes(~)
           names = enumeration(PulseShape.RECT);
           names_str = string(names);
        end

        function updatePulse(~, src, ~, sys, pulse_plot, x)
            new_pulse = src.Value;
            sys.updatePulse(new_pulse);
            p_s = sys.inputFilter.pulseShape;
            y = GeneratePulse(x, p_s);
            plot(pulse_plot,x, y);
        end

        function readInputText(this ,~ , ~, input_txt_area, sys)
            text = input_txt_area.Value{1};
            if (~~isempty(text))
                fprintf(2, "Error: Empty message string\n");
            else 
                sys.input.readInput(text);
                if ~isempty(bin_stream)
                    this.updateDataLabels();
                end
            end
        end

        function updateTextInputMode(~, src, ~, sys)
            val = src.Value;
            switch val
                case "Raw"
                    sys.input.mode = InputMode.TEXT_RAW;
                case "Binary"
                    sys.input.mode = InputMode.TEXT_BINARY;
            end
        end

        function openFileUpload(~, ~, ~, sys)
            [file, path] = uigetfile('*.*', 'Select a File');
            if isequal(file,0)
                return;
            end
        
            fullpath = fullfile(path, file);
            sys.input.updateFileContents(fullpath);
        end

        function uploadSelectionChange(~, ~, event, upload_btn, ...
            input_txt_area, upload_txt_btn, upload_txt_switch)
           opt = event.NewValue.Tag;
           if opt == "file"
               upload_btn.Enable = 'on';
               input_txt_area.Enable = 'off';
               upload_txt_btn.Enable = 'off';
               upload_txt_switch.Enable = 'off';
           else
               upload_btn.Enable = 'off';
               input_txt_area.Enable = 'on';
               upload_txt_btn.Enable = 'on';
               upload_txt_switch.Enable = 'on';
           end
        end

        function updateDataLabels(this)
            this.size_label.Text = "Check";
            this.mode_label.Text = "Check 2";
        end
    end
end