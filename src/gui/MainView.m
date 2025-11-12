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
    uitab(tabs,'Title','Noise');
    uitab(tabs,'Title','Receiver');
    uitab(tabs,'Title','Output');
    % Input section grid layout

    
    g_i = uigridlayout(in_sec);
    g_i.RowHeight = {22,22,'1x'};
    g_i.ColumnWidth = {180,'1x'};
    dd1 = uidropdown(g_i);
    dd1.Items = {'Select a device'};
    dd2 = uidropdown(g_i);
    dd2.Items = {'Select a range'};
    dd2.Layout.Row = 2;
    dd2.Layout.Column = 1;
    chanlist = uilistbox(g_i);
    chanlist.Items = {'Channel 1','Channel 2','Channel 3'};
    chanlist.Layout.Row = 3;
    chanlist.Layout.Column = 1;
    ax = uiaxes(g_i);
end


function displaySelection(src,event)
    t = event.NewValue;
    title = t.Title;
    disp("Viewing the " + title + " tab")
end
