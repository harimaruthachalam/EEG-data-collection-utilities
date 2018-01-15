function storyWithStress
% Rini Sharon, Hari Maruthachalam - Updated on 15, 2018
% This MATLAB file records EEG signals for pleasant, annoying sounds;
% statements with various stress, pause; and attention on voice
% Audio path should be trailing with a slash
% Code is of hard coded for audio files
%%%%----------ALL CODES FOR NETSTATION------%%%%%
% SBLS - Start BaseLine Start
% SBLE - Start BaseLine End
% RTST - Relax Tone StarT
% RTED - Relax Tone EnD
% CPSS - Cue Probe Sound Start
% CPSE - Cue Probe Sound End
% CLS - Click Start
% CLE - Click End
% PLXS - Pleasant Sound Start (X is integer)
% ANXS - Annoying Sound Start (X is integer)
% PEXS - Pleasant Sound with Explanation (X is integer)
% PXS - X'th sentence with some stress and pause (X is integer)
% PXXS - XX'th sentence with some other stress and pause (XX is a single digit integer)
% EBLS - End BaseLine Start
% EBLE - End BaseLine End
% NC - No click
% LC - Left Click
% RC - Right Click
% PC - Problematic Click

close all;
clear;
clc;

%% Configurations
isTestRun = 1;
baseLinePause = 20;
ipAddress = '10.10.10.42';
pauseTime = 2;
interStimuliPauseTime = 2;
promptTimeForClick = 3;
path = '';
recStartAudioFile = '';
cockTailAudioFile = '';

%% Gloabal Variables
global button;
global clickTime;
global ticTime;
ticTime = tic;
button = [];

%% Setup Check
disp('Check the followings');
pause;
disp('Net Station is ready');
pause;
disp('IP is pinging');
pause;
disp('Ear phone is connected properly');
pause;
disp('Subject is ready');
pause;
disp('Enter to Start!');
pause;

%% Audio files
try
    [recStartAudio, recStartAudioFs] = audioread([path recStartAudioFile]);
    [cockTailAudio, cockTailAudioFs] = audioread([path cockTailAudioFile]);
catch exception
    error('Audio files are not loaded! Check path and files.');
end


%% Beep producee
beepLength = 0 : 2047;
fs = 8192;
freq = 300;
beepSampleTime = 1 / fs ;
beepSound = cos(2 * pi * freq * beepLength * beepSampleTime);
beepDuration = beepLength / fs;

%% Instructions to subject
disp('Instruction to Subject is playing...');
soundsc(recStartAudio, recStartAudioFs);
pause(length(recStartAudio) / recStartAudioFs);
pause(pauseTime);

%% NetStation Connection
if isTestRun == 0
    NetStation('Connect', ipAddress);
    NetStation('StartRecording');
    NetStation('Synchronize');
end

%% Baseline
disp('Recording Starts...');
disp('Start Baseline...');
if isTestRun == 0
    NetStation('Event','SBLS');
end
pause(baseLinePause);
if isTestRun == 0
    NetStation('Event','SBLE');
end

%% Data Collection - Cue and Probe
% Instructions to subject on Cocktail Party
disp('Cocktail party experiment...');
soundsc(cockTailAudio, cockTailAudioFs);
pause(length(cockTailAudio) / cockTailAudioFs);
pause(pauseTime);

% Example 1
disp('Example 1 on Cocktail party experiment...');
[y,Fs] = audioread([path 'ex1.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);

if isTestRun == 0
    NetStation('Event','CPSS');
end
[y,Fs] = audioread([path 'be1.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);
if isTestRun == 0
    NetStation('Event','CPSE');
end
pause(interStimuliPauseTime);

soundsc(beepSound);
pause(beepDuration);
if isTestRun == 0
    NetStation('Event','CLS');
end
button=[];
mouseClickTester;
pause(promptTimeForClick);
close;
if isTestRun == 0
    if isempty(button)
        NetStation('Event','NC');
    elseif sum(button{1} == 'n') == 1
        NetStation('Event','LC');
    elseif sum(button{1} == 'a') == 1
        NetStation('Event','RC');
    else
        NetStation('Event','PC');
    end
    NetStation('Event','CLE');
end

soundsc(beepSound);
pause(beepDuration);

% Example 2 on CPSS
disp('Example 2 on Cocktail party experiment...');
[y,Fs] = audioread([path 'ex2.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);
if isTestRun == 0
    NetStation('Event','CPSS');
end
[y,Fs] = audioread([path 'be2.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);
if isTestRun == 0
    NetStation('Event','CPSE');
end
pause(interStimuliPauseTime);

soundsc(beepSound);
pause(beepDuration);
if isTestRun == 0
    NetStation('Event','CLS');
end
button=[];
mouseClickTester;
pause(promptTimeForClick);
close;
if isTestRun == 0
    if isempty(button)
        NetStation('Event','NC');
    elseif sum(button{1} == 'n') == 1
        NetStation('Event','LC');
    elseif sum(button{1} == 'a') == 1
        NetStation('Event','RC');
    else
        NetStation('Event','PC');
    end
    NetStation('Event','CLE');
end


soundsc(beepSound);
pause(beepDuration);

% Example 3 on CPSS
disp('Example 3 on Cocktail party experiment...');
[y,Fs] = audioread([path 'ex3.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);
if isTestRun == 0
    NetStation('Event','CPSS');
end
[y,Fs] = audioread([path 'vibrato.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);
if isTestRun == 0
    NetStation('Event','CPSE');
end
pause(interStimuliPauseTime);

soundsc(beepSound);
pause(beepDuration);
if isTestRun == 0
    NetStation('Event','CLS');
end
button=[];
mouseClickTester;
pause(promptTimeForClick);
close;
if isTestRun == 0
    if isempty(button)
        NetStation('Event','NC');
    elseif sum(button{1} == 'n') == 1
        NetStation('Event','LC');
    elseif sum(button{1} == 'a') == 1
        NetStation('Event','RC');
    else
        NetStation('Event','PC');
    end
    NetStation('Event','CLE');
end


soundsc(beepSound);
pause(beepDuration);


% Example 4 on CPSS
disp('Example 4 on Cocktail party experiment...');
[y,Fs] = audioread([path 'ex4.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);
if isTestRun == 0
    NetStation('Event','CPSS');
end
[y,Fs] = audioread([path 'low_min_dist.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);
if isTestRun == 0
    NetStation('Event','CPSE');
end
pause(interStimuliPauseTime);

soundsc(beepSound);
pause(beepDuration);
if isTestRun == 0
    NetStation('Event','CLS');
end
button=[];
mouseClickTester;
pause(promptTimeForClick);
close;
if isTestRun == 0
    if isempty(button)
        NetStation('Event','NC');
    elseif sum(button{1} == 'n') == 1
        NetStation('Event','LC');
    elseif sum(button{1} == 'a') == 1
        NetStation('Event','RC');
    else
        NetStation('Event','PC');
    end
    NetStation('Event','CLE');
end


soundsc(beepSound);
pause(beepDuration);

% Example 5 on CPSS
disp('Example 5 on Cocktail party experiment...');
[y,Fs] = audioread([path 'ex5.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);
if isTestRun == 0
    NetStation('Event','CPSS');
end
[y,Fs] = audioread([path 'high_min_dist.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);
if isTestRun == 0
    NetStation('Event','CPSE');
end
pause(interStimuliPauseTime);

soundsc(beepSound);
pause(beepDuration);
if isTestRun == 0
    NetStation('Event','CLS');
end
button=[];
mouseClickTester;
pause(promptTimeForClick);
close;
if isTestRun == 0
    if isempty(button)
        NetStation('Event','NC');
    elseif sum(button{1} == 'n') == 1
        NetStation('Event','LC');
    elseif sum(button{1} == 'a') == 1
        NetStation('Event','RC');
    else
        NetStation('Event','PC');
    end
    NetStation('Event','CLE');
end


soundsc(beepSound);
pause(beepDuration);


% Example 6 on CPSS
disp('Example 6 on Cocktail party experiment...');
[y,Fs] = audioread([path 'ex6.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);
if isTestRun == 0
    NetStation('Event','CPSS');
end
[y,Fs] = audioread([path 's8m.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);
if isTestRun == 0
    NetStation('Event','CPSE');
end
pause(interStimuliPauseTime);

soundsc(beepSound);
pause(beepDuration);
if isTestRun == 0
    NetStation('Event','CLS');
end
button=[];
mouseClickTester;
pause(promptTimeForClick);
close;
if isTestRun == 0
    if isempty(button)
        NetStation('Event','NC');
    elseif sum(button{1} == 'n') == 1
        NetStation('Event','LC');
    elseif sum(button{1} == 'a') == 1
        NetStation('Event','RC');
    else
        NetStation('Event','PC');
    end
    NetStation('Event','CLE');
end


soundsc(beepSound);
pause(beepDuration);


% Example 7 on CPSS
disp('Example 7 on Cocktail party experiment...');
[y,Fs] = audioread([path 'ex7.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);
if isTestRun == 0
    NetStation('Event','CPSS');
end
[y,Fs] = audioread([path 's4m.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);
if isTestRun == 0
    NetStation('Event','CPSE');
end
pause(interStimuliPauseTime);

soundsc(beepSound);
pause(beepDuration);
if isTestRun == 0
    NetStation('Event','CLS');
end
button=[];
mouseClickTester;
pause(promptTimeForClick);
close;
if isTestRun == 0
    if isempty(button)
        NetStation('Event','NC');
    elseif sum(button{1} == 'n') == 1
        NetStation('Event','LC');
    elseif sum(button{1} == 'a') == 1
        NetStation('Event','RC');
    else
        NetStation('Event','PC');
    end
    NetStation('Event','CLE');
end


soundsc(beepSound);
pause(beepDuration);

% Example 8 on CPSS
disp('Example 8 on Cocktail party experiment...');
[y,Fs] = audioread([path 'ex8.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);
if isTestRun == 0
    NetStation('Event','CPSS');
end
[y,Fs] = audioread([path 's2m.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);
if isTestRun == 0
    NetStation('Event','CPSE');
end
pause(interStimuliPauseTime);

soundsc(beepSound);
pause(beepDuration);
if isTestRun == 0
    NetStation('Event','CLS');
end
button=[];
mouseClickTester;
pause(promptTimeForClick);
close;
if isTestRun == 0
    if isempty(button)
        NetStation('Event','NC');
    elseif sum(button{1} == 'n') == 1
        NetStation('Event','LC');
    elseif sum(button{1} == 'a') == 1
        NetStation('Event','RC');
    else
        NetStation('Event','PC');
    end
    NetStation('Event','CLE');
end


soundsc(beepSound);
pause(beepDuration);


%% Data Collection - Pleasant and Annoying
% Instruction to the subject
clc;
disp('Instruction to Subject on Pleasant and Annoying...');
[y,Fs] = audioread([path 'ann_pl.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);

pause(pauseTime);

disp('Pleasant and Annoying Starts...');
if isTestRun == 0
    NetStation('Event','PL1S');
end
[y,Fs] = audioread([path 'pl1.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);
if isTestRun == 0
    NetStation('Event','PL1E');
end
pause(interStimuliPauseTime);

soundsc(beepSound);
pause(beepDuration);
if isTestRun == 0
    NetStation('Event','CLS');
end
button=[];
mouseClickTester;
pause(promptTimeForClick);
close;
if isTestRun == 0
    if isempty(button)
        NetStation('Event','NC');
    elseif sum(button{1} == 'n') == 1
        NetStation('Event','LC');
    elseif sum(button{1} == 'a') == 1
        NetStation('Event','RC');
    else
        NetStation('Event','PC');
    end
    NetStation('Event','CLE');
end


soundsc(beepSound);
pause(beepDuration);

if isTestRun == 0
    NetStation('Event','AN1S');
end
[y,Fs] = audioread([path 'an1.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);
if isTestRun == 0
    NetStation('Event','AN1E');
end

soundsc(beepSound);
pause(beepDuration);


if isTestRun == 0
    NetStation('Event','PL2S');
end
[y,Fs] = audioread([path 'pl2.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);
if isTestRun == 0
    NetStation('Event','PL2E');
end
pause(interStimuliPauseTime);

soundsc(beepSound);
pause(beepDuration);
if isTestRun == 0
    NetStation('Event','CLS');
end
button=[];
mouseClickTester;
pause(promptTimeForClick);
close;
if isTestRun == 0
    if isempty(button)
        NetStation('Event','NC');
    elseif sum(button{1} == 'n') == 1
        NetStation('Event','LC');
    elseif sum(button{1} == 'a') == 1
        NetStation('Event','RC');
    else
        NetStation('Event','PC');
    end
    NetStation('Event','CLE');
end


soundsc(beepSound);
pause(beepDuration);

if isTestRun == 0
    NetStation('Event','AN2S');
end
[y,Fs] = audioread([path 'an2.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);
if isTestRun == 0
    NetStation('Event','AN2E');
end

soundsc(beepSound);
pause(beepDuration);

if isTestRun == 0
    NetStation('Event','PL3S');
end
[y,Fs] = audioread([path 'pl3.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);
if isTestRun == 0
    NetStation('Event','PL3E');
end
pause(interStimuliPauseTime);

soundsc(beepSound);
pause(beepDuration);
if isTestRun == 0
    NetStation('Event','CLS');
end
button=[];
mouseClickTester;
pause(promptTimeForClick);
close;
if isTestRun == 0
    if isempty(button)
        NetStation('Event','NC');
    elseif sum(button{1} == 'n') == 1
        NetStation('Event','LC');
    elseif sum(button{1} == 'a') == 1
        NetStation('Event','RC');
    else
        NetStation('Event','PC');
    end
    NetStation('Event','CLE');
end


soundsc(beepSound);
pause(beepDuration);

if isTestRun == 0
    NetStation('Event','AN3S');
end
[y,Fs] = audioread([path 'an3.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);
if isTestRun == 0
    NetStation('Event','AN3E');
end

soundsc(beepSound);
pause(beepDuration);


if isTestRun == 0
    NetStation('Event','PL4S');
end
[y,Fs] = audioread([path 'pl4.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);
if isTestRun == 0
    NetStation('Event','PL4E');
end
pause(interStimuliPauseTime);

soundsc(beepSound);
pause(beepDuration);
if isTestRun == 0
    NetStation('Event','CLS');
end
button=[];
mouseClickTester;
pause(promptTimeForClick);
close;
if isTestRun == 0
    if isempty(button)
        NetStation('Event','NC');
    elseif sum(button{1} == 'n') == 1
        NetStation('Event','LC');
    elseif sum(button{1} == 'a') == 1
        NetStation('Event','RC');
    else
        NetStation('Event','PC');
    end
    NetStation('Event','CLE');
end


soundsc(beepSound);
pause(beepDuration);

if isTestRun == 0
    NetStation('Event','AN4S');
end
[y,Fs] = audioread([path 'an4.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);
if isTestRun == 0
    NetStation('Event','AN4E');
end

soundsc(beepSound);
pause(beepDuration);

%% Data Collection - Pleasant and Annoying sounds with explainations
% Instruction to the subject
clc;
disp('Instruction on Pleasant and Annoying with explainations...');
[y,Fs] = audioread([path 'explll.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);

disp('Pleasant and Annoying with explainations starts...');
[y,Fs] = audioread([path 'ann_pl.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);

pause(pauseTime);

% Example 1
disp('Example 1 on Pleasant and Annoying with explainations...');
[y,Fs] = audioread([path 'char.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);


if isTestRun == 0
    NetStation('Event','PE1S');
end
[y,Fs] = audioread([path 'pl1.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);
if isTestRun == 0
    NetStation('Event','PE1E');
end

pause(interStimuliPauseTime);

soundsc(beepSound);
pause(beepDuration);
if isTestRun == 0
    NetStation('Event','CLS');
end
button=[];
mouseClickTester;
pause(promptTimeForClick);
close;
if isTestRun == 0
    if isempty(button)
        NetStation('Event','NC');
    elseif sum(button{1} == 'n') == 1
        NetStation('Event','LC');
    elseif sum(button{1} == 'a') == 1
        NetStation('Event','RC');
    else
        NetStation('Event','PC');
    end
    NetStation('Event','CLE');
end


soundsc(beepSound);
pause(beepDuration);

% Example 2
disp('Example 2 on Pleasant and Annoying with explainations...');
[y,Fs] = audioread([path 'mac.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);


if isTestRun == 0
    NetStation('Event','AE1S');
end
[y,Fs] = audioread([path 'an1.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);
if isTestRun == 0
    NetStation('Event','AE1E');
end

pause(interStimuliPauseTime);

soundsc(beepSound);
pause(beepDuration);
if isTestRun == 0
    NetStation('Event','CLS');
end
button=[];
mouseClickTester;
pause(promptTimeForClick);
close;
if isTestRun == 0
    if isempty(button)
        NetStation('Event','NC');
    elseif sum(button{1} == 'n') == 1
        NetStation('Event','LC');
    elseif sum(button{1} == 'a') == 1
        NetStation('Event','RC');
    else
        NetStation('Event','PC');
    end
    NetStation('Event','CLE');
end


soundsc(beepSound);
pause(beepDuration);

% Example 3
disp('Example 3 on Pleasant and Annoying with explainations...');
[y,Fs] = audioread([path 'rain.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);


if isTestRun == 0
    NetStation('Event','PE2S');
end
[y,Fs] = audioread([path 'pl2.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);
if isTestRun == 0
    NetStation('Event','PE2E');
end

pause(interStimuliPauseTime);

soundsc(beepSound);
pause(beepDuration);
if isTestRun == 0
    NetStation('Event','CLS');
end
button=[];
mouseClickTester;
pause(promptTimeForClick);
close;
if isTestRun == 0
    if isempty(button)
        NetStation('Event','NC');
    elseif sum(button{1} == 'n') == 1
        NetStation('Event','LC');
    elseif sum(button{1} == 'a') == 1
        NetStation('Event','RC');
    else
        NetStation('Event','PC');
    end
    NetStation('Event','CLE');
end


soundsc(beepSound);
pause(beepDuration);

% Example 4
disp('Example 4 on Pleasant and Annoying with explainations...');
[y,Fs] = audioread([path 'cb.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);


if isTestRun == 0
    NetStation('Event','AE2S');
end
[y,Fs] = audioread([path 'an2.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);
if isTestRun == 0
    NetStation('Event','AE2E');
end

pause(interStimuliPauseTime);

soundsc(beepSound);
pause(beepDuration);
if isTestRun == 0
    NetStation('Event','CLS');
end
button=[];
mouseClickTester;
pause(promptTimeForClick);
close;
if isTestRun == 0
    if isempty(button)
        NetStation('Event','NC');
    elseif sum(button{1} == 'n') == 1
        NetStation('Event','LC');
    elseif sum(button{1} == 'a') == 1
        NetStation('Event','RC');
    else
        NetStation('Event','PC');
    end
    NetStation('Event','CLE');
end


soundsc(beepSound);
pause(beepDuration);


% Example 5
disp('Example 5 on Pleasant and Annoying with explainations...');
[y,Fs] = audioread([path 'sc.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);


if isTestRun == 0
    NetStation('Event','PE3S');
end
[y,Fs] = audioread([path 'pl3.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);
if isTestRun == 0
    NetStation('Event','PE3E');
end

pause(interStimuliPauseTime);

soundsc(beepSound);
pause(beepDuration);
if isTestRun == 0
    NetStation('Event','CLS');
end
button=[];
mouseClickTester;
pause(promptTimeForClick);
close;
if isTestRun == 0
    if isempty(button)
        NetStation('Event','NC');
    elseif sum(button{1} == 'n') == 1
        NetStation('Event','LC');
    elseif sum(button{1} == 'a') == 1
        NetStation('Event','RC');
    else
        NetStation('Event','PC');
    end
    NetStation('Event','CLE');
end


soundsc(beepSound);
pause(beepDuration);

% Example 6
disp('Example 6 on Pleasant and Annoying with explainations...');
[y,Fs] = audioread([path 'gr.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);


if isTestRun == 0
    NetStation('Event','AE3S');
end
[y,Fs] = audioread([path 'an3.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);
if isTestRun == 0
    NetStation('Event','AE3E');
end

pause(interStimuliPauseTime);

soundsc(beepSound);
pause(beepDuration);
if isTestRun == 0
    NetStation('Event','CLS');
end
button=[];
mouseClickTester;
pause(promptTimeForClick);
close;
if isTestRun == 0
    if isempty(button)
        NetStation('Event','NC');
    elseif sum(button{1} == 'n') == 1
        NetStation('Event','LC');
    elseif sum(button{1} == 'a') == 1
        NetStation('Event','RC');
    else
        NetStation('Event','PC');
    end
    NetStation('Event','CLE');
end


soundsc(beepSound);
pause(beepDuration);


% Example 7
disp('Example 7 on Pleasant and Annoying with explainations...');
[y,Fs] = audioread([path 'ffff.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);


if isTestRun == 0
    NetStation('Event','PE4S');
end
[y,Fs] = audioread([path 'pl4.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);
if isTestRun == 0
    NetStation('Event','PE4E');
end

pause(interStimuliPauseTime);

soundsc(beepSound);
pause(beepDuration);
if isTestRun == 0
    NetStation('Event','CLS');
end
button=[];
mouseClickTester;
pause(promptTimeForClick);
close;
if isTestRun == 0
    if isempty(button)
        NetStation('Event','NC');
    elseif sum(button{1} == 'n') == 1
        NetStation('Event','LC');
    elseif sum(button{1} == 'a') == 1
        NetStation('Event','RC');
    else
        NetStation('Event','PC');
    end
    NetStation('Event','CLE');
end


soundsc(beepSound);
pause(beepDuration);

% Example 8
disp('Example 8 on Pleasant and Annoying with explainations...');
[y,Fs] = audioread([path 'nails.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);


if isTestRun == 0
    NetStation('Event','AE4S');
end
[y,Fs] = audioread([path 'an4.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);
if isTestRun == 0
    NetStation('Event','AE4E');
end

pause(interStimuliPauseTime);

soundsc(beepSound);
pause(beepDuration);
if isTestRun == 0
    NetStation('Event','CLS');
end
button=[];
mouseClickTester;
pause(promptTimeForClick);
close;
if isTestRun == 0
    if isempty(button)
        NetStation('Event','NC');
    elseif sum(button{1} == 'n') == 1
        NetStation('Event','LC');
    elseif sum(button{1} == 'a') == 1
        NetStation('Event','RC');
    else
        NetStation('Event','PC');
    end
    NetStation('Event','CLE');
end


soundsc(beepSound);
pause(beepDuration);


%% Data Collection - Pause Intervals Expriements
% Instruction to the Subject
clc;
disp('Instruction to the Subject on Pause Intervals Expriements...');
[y,Fs] = audioread([path 'p_prompt.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);

pause(pauseTime);

% Example 1
disp('Example 1 on Pause Intervals Expriements...');
if isTestRun == 0
    NetStation('Event','P1S');
end
[y,Fs] = audioread([path 'p1.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);
if isTestRun == 0
    NetStation('Event','P1E');
end
pause(interStimuliPauseTime);
if isTestRun == 0
    NetStation('Event','P11S');
end
[y,Fs] = audioread([path 'p11.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);
if isTestRun == 0
    NetStation('Event','P11E');
end

soundsc(beepSound);
pause(beepDuration);
if isTestRun == 0
    NetStation('Event','CLS');
end
button=[];
mouseClickTester;
pause(promptTimeForClick);
close;
if isTestRun == 0
    if isempty(button)
        NetStation('Event','NC');
    elseif sum(button{1} == 'n') == 1
        NetStation('Event','LC');
    elseif sum(button{1} == 'a') == 1
        NetStation('Event','RC');
    else
        NetStation('Event','PC');
    end
    NetStation('Event','CLE');
end


soundsc(beepSound);
pause(beepDuration);

% Example 2
disp('Example 2 on Pause Intervals Expriements...');
if isTestRun == 0
    NetStation('Event','P2S');
end
[y,Fs] = audioread([path 'p2.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);
if isTestRun == 0
    NetStation('Event','P2E');
end
pause(interStimuliPauseTime);
if isTestRun == 0
    NetStation('Event','P22S');
end
[y,Fs] = audioread([path 'p22.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);
if isTestRun == 0
    NetStation('Event','P22E');
end

soundsc(beepSound);
pause(beepDuration);
if isTestRun == 0
    NetStation('Event','CLS');
end
button=[];
mouseClickTester;
pause(promptTimeForClick);
close;
if isTestRun == 0
    if isempty(button)
        NetStation('Event','NC');
    elseif sum(button{1} == 'n') == 1
        NetStation('Event','LC');
    elseif sum(button{1} == 'a') == 1
        NetStation('Event','RC');
    else
        NetStation('Event','PC');
    end
    NetStation('Event','CLE');
end


soundsc(beepSound);
pause(beepDuration);


% Example 3
disp('Example 3 on Pause Intervals Expriements...');
if isTestRun == 0
    NetStation('Event','P3S');
end
[y,Fs] = audioread([path 'p3.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);
if isTestRun == 0
    NetStation('Event','P3E');
end
pause(interStimuliPauseTime);
if isTestRun == 0
    NetStation('Event','P33S');
end
[y,Fs] = audioread([path 'p33.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);
if isTestRun == 0
    NetStation('Event','P33E');
end

soundsc(beepSound);
pause(beepDuration);
if isTestRun == 0
    NetStation('Event','CLS');
end
button=[];
mouseClickTester;
pause(promptTimeForClick);
close;
if isTestRun == 0
    if isempty(button)
        NetStation('Event','NC');
    elseif sum(button{1} == 'n') == 1
        NetStation('Event','LC');
    elseif sum(button{1} == 'a') == 1
        NetStation('Event','RC');
    else
        NetStation('Event','PC');
    end
    NetStation('Event','CLE');
end


soundsc(beepSound);
pause(beepDuration);


% Example 4
disp('Example 4 on Pause Intervals Expriements...');
if isTestRun == 0
    NetStation('Event','P4S');
end
[y,Fs] = audioread([path 'p4.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);
if isTestRun == 0
    NetStation('Event','P4E');
end
pause(interStimuliPauseTime);
if isTestRun == 0
    NetStation('Event','P44S');
end
[y,Fs] = audioread([path 'p44.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);
if isTestRun == 0
    NetStation('Event','P44E');
end

soundsc(beepSound);
pause(beepDuration);
if isTestRun == 0
    NetStation('Event','CLS');
end
button=[];
mouseClickTester;
pause(promptTimeForClick);
close;
if isTestRun == 0
    if isempty(button)
        NetStation('Event','NC');
    elseif sum(button{1} == 'n') == 1
        NetStation('Event','LC');
    elseif sum(button{1} == 'a') == 1
        NetStation('Event','RC');
    else
        NetStation('Event','PC');
    end
    NetStation('Event','CLE');
end


soundsc(beepSound);
pause(beepDuration);


% Example 5
disp('Example 5 on Pause Intervals Expriements...');
if isTestRun == 0
    NetStation('Event','P5S');
end
[y,Fs] = audioread([path 'p5.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);
if isTestRun == 0
    NetStation('Event','P5E');
end
pause(interStimuliPauseTime);
if isTestRun == 0
    NetStation('Event','P55S');
end
[y,Fs] = audioread([path 'p55.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);
if isTestRun == 0
    NetStation('Event','P55E');
end

soundsc(beepSound);
pause(beepDuration);
if isTestRun == 0
    NetStation('Event','CLS');
end
button=[];
mouseClickTester;
pause(promptTimeForClick);
close;
if isTestRun == 0
    if isempty(button)
        NetStation('Event','NC');
    elseif sum(button{1} == 'n') == 1
        NetStation('Event','LC');
    elseif sum(button{1} == 'a') == 1
        NetStation('Event','RC');
    else
        NetStation('Event','PC');
    end
    NetStation('Event','CLE');
end


soundsc(beepSound);
pause(beepDuration);


% Example 6
disp('Example 6 on Pause Intervals Expriements...');
if isTestRun == 0
    NetStation('Event','P6S');
end
[y,Fs] = audioread([path 'p6.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);
if isTestRun == 0
    NetStation('Event','P6E');
end
pause(interStimuliPauseTime);
if isTestRun == 0
    NetStation('Event','P66S');
end
[y,Fs] = audioread([path 'p66.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);
if isTestRun == 0
    NetStation('Event','P66E');
end

soundsc(beepSound);
pause(beepDuration);
if isTestRun == 0
    NetStation('Event','CLS');
end
button=[];
mouseClickTester;
pause(promptTimeForClick);
close;
if isTestRun == 0
    if isempty(button)
        NetStation('Event','NC');
    elseif sum(button{1} == 'n') == 1
        NetStation('Event','LC');
    elseif sum(button{1} == 'a') == 1
        NetStation('Event','RC');
    else
        NetStation('Event','PC');
    end
    NetStation('Event','CLE');
end


soundsc(beepSound);
pause(beepDuration);


% Example 7
disp('Example 7 on Pause Intervals Expriements...');
if isTestRun == 0
    NetStation('Event','P7S');
end
[y,Fs] = audioread([path 'p7.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);
if isTestRun == 0
    NetStation('Event','P7E');
end
pause(interStimuliPauseTime);
if isTestRun == 0
    NetStation('Event','P77S');
end
[y,Fs] = audioread([path 'p77.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);
if isTestRun == 0
    NetStation('Event','P77E');
end

soundsc(beepSound);
pause(beepDuration);
if isTestRun == 0
    NetStation('Event','CLS');
end
button=[];
mouseClickTester;
pause(promptTimeForClick);
close;
if isTestRun == 0
    if isempty(button)
        NetStation('Event','NC');
    elseif sum(button{1} == 'n') == 1
        NetStation('Event','LC');
    elseif sum(button{1} == 'a') == 1
        NetStation('Event','RC');
    else
        NetStation('Event','PC');
    end
    NetStation('Event','CLE');
end


soundsc(beepSound);
pause(beepDuration);


% Example 8
disp('Example 8 on Pause Intervals Expriements...');
if isTestRun == 0
    NetStation('Event','P8S');
end
[y,Fs] = audioread([path 'p8.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);
if isTestRun == 0
    NetStation('Event','P8E');
end
pause(interStimuliPauseTime);
if isTestRun == 0
    NetStation('Event','P88S');
end
[y,Fs] = audioread([path 'p88.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);
if isTestRun == 0
    NetStation('Event','P88E');
end

soundsc(beepSound);
pause(beepDuration);
if isTestRun == 0
    NetStation('Event','CLS');
end
button=[];
mouseClickTester;
pause(promptTimeForClick);
close;
if isTestRun == 0
    if isempty(button)
        NetStation('Event','NC');
    elseif sum(button{1} == 'n') == 1
        NetStation('Event','LC');
    elseif sum(button{1} == 'a') == 1
        NetStation('Event','RC');
    else
        NetStation('Event','PC');
    end
    NetStation('Event','CLE');
end


soundsc(beepSound);
pause(beepDuration);


%% Data Collection - Ralaxation Tone
clc;
disp('Playing Relaxation...')
[y,Fs] = audioread([path 'relax.wav']);
player = audioplayer(y,Fs);
player.play;
pause(size(y,1)/Fs);

%% End Baseline
disp('End Baseline Started...');
if isTestRun == 0
    NetStation('Event','EBLS');
end
pause(baseLinePause);
if isTestRun == 0
    NetStation('Event','EBLE');
    NetStation('StopRecording');
    NetStation('Disconnect');
end

end