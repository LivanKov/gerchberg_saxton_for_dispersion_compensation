% The main window, containing the core of the visual application
% TODOs: 
%   Input overview
%   Noise overview
%   Receiver
%   Output overview


function Main
    f = uifigure('Name','ComViewUI');
    f.Position(3:4) = [600 500];
    f.Resize = "off";
    gl = uigridlayout(f,[1 1]);
    tg = uitabgroup(gl);
    uitab(tg,'Title','Input');
    uitab(tg,'Title','Noise');
    uitab(tg,'Title','Receiver');
    uitab(tg,'Title','Output');
end
