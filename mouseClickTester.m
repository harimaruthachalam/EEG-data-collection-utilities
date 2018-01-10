function mouseClickTester(varargin)
% Hari Maruthachalam - Updated on Jan 10, 2018
% Usage: mouseClickTester
% Preprocessing as follows
% 1. Initialize button gloabally in the callee function and assign nothing.
% Nullify the button every time you make a call to mouseClickTester
% 2. Initialize clickTime gloabally in the callee function and assign
% nothing. Nullify the clickTime every time you make a call to mouseClickTester
% 3. Initialize ticTime globally with tic (i.e. ticTime = tic;)
% Postprocessing as follows
% 1. button may have three values
%   a) empty - No click happened
%   b) cell containing 'normal' - Left click
%   c) cell containing 'alt' - Right click
% 2. clickTime contain time duraction from initializing ticTime to time to
% click (in seconds)

global button;
global ticTime;
global clickTime;
if nargin == 0
    fig = figure;
    set(gcf, 'Toolbar', 'none', 'Menubar', 'none');
    screenSize = get(0, 'ScreenSize');
    screenSize(1, 2) = 30;
    set(gcf, 'Units', 'pixels', 'Position', screenSize);
    set(fig, 'buttondownfcn', 'mouseClickTester( get (gcf, ''selectiontype'') )');
else
    if nargin == 1
        button = varargin(1);
        clickTime = toc(ticTime);
        close;
    end
end
end