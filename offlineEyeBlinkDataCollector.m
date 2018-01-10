function offlineEyeBlinkDataCollector
% Hari Maruthachalam - Updated on Jan 10, 2018
% Usage: offlineEyeBlinkDataCollector
% This program will collect data from EEG and annotates for various eye blinks
% The data collection machine is EGI Netstation
% Psychtoolbox is prerequisites
%%%%----------ALL CODES FOR NETSTATION------%%%%%
% SBLS - Start BaseLine Start
% SBLE - Start BaseLine End
% BPST - BeeP StarT
% BPED - BeeP EnD
% BESS - Both Eye Single Blink Start
% BESE - Both Eye Single Blink End
% BEDS - Both Eye Double Blink Start
% BEDE - Both Eye Double Blink End
% LEBS - Left Eye Blink Start
% LEBE - Left Eye Blink End
% REBS - Right Eye Blink Start
% REBE - Right Eye Blink End
% EBLS - End BaseLine Start
% EBLE - End BaseLine End

%% Check List
close all;
clear;
clc;
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

%% Beep producee
beepLength = 0 : 2047;
fs = 8192;
freq = 300;
beepSampleTime = 1 / fs ;
beepSound = cos(2 * pi * freq * beepLength * beepSampleTime);
beepDuration = beepLength / fs;

%% Needed files
[singleBlinkAudio, singleBlinkAudioFS] = audioread();
[doubleBlinkAudio, doubleBlinkAudioFS] = audioread();
[leftBlinkAudio, leftBlinkAudioFS] = audioread();
[rightBlinkAudio, rightBlinkAudioFS] = audioread();
if isempty(singleBlinkAudio) || isempty(doubleBlinkAudio) || isempty(leftBlinkAudio) || isempty(rightBlinkAudio)
    error('Audio files are not loaded!');
end

%% Configurations
isTestRun = 1;
baseLinePause = 20;
eyeBlinkPause = 1;
noOfTrials = 5;
ipAddress = '10.10.10.42';

%% NetStation Connection
if isTestRun == 0
    NetStation('Connect', ipAddress);
    NetStation('StartRecording');
    NetStation('Synchronize');
end
disp('Recording Starts');

%% Baseline
disp('Start Baseline');
if isTestRun == 0
    NetStation('Event','SBLS');
end
pause(baseLinePause);
if isTestRun == 0
    NetStation('Event','SBLE');
end

%% Data Collection
for trials = 1 : noOfTrials
    clc;
    disp(['Trial ' num2str(trials) ' starts']);
    disp('Single Blink Instruction Playing...');
    soundsc(singleBlinkAudio, singleBlinkAudioFS);
    pause(length(singleBlinkAudio) / singleBlinkAudioFS);
    pause(eyeBlinkPause);
    disp('Beep');
    if isTestRun == 0
        NetStation('Event','BPST');
    end
    soundsc(beepSound);
    pause(beepDuration);
    if isTestRun == 0
        NetStation('Event','BPED');
        NetStation('Event','BESS');
    end
    pause(eyeBlinkPause);
    if isTestRun == 0
        NetStation('Event','BESE');
    end
    pause(eyeBlinkPause * 2);
    
    disp('Double Blink Instruction Playing...');
    soundsc(doubleBlinkAudio, doubleBlinkAudioFS);
    pause(length(doubleBlinkAudio) / doubleBlinkAudioFS);
    pause(eyeBlinkPause);
    disp('Beep');
    if isTestRun == 0
        NetStation('Event','BPST');
    end
    soundsc(beepSound);
    pause(beepDuration);
    if isTestRun == 0
        NetStation('Event','BPED');
        NetStation('Event','BEDS');
    end
    pause(eyeBlinkPause);
    if isTestRun == 0
        NetStation('Event','BEDE');
    end
    pause(eyeBlinkPause * 2);
    
    disp('Left Blink Instruction Playing...');
    soundsc(leftBlinkAudio, leftBlinkAudioFS);
    pause(length(leftBlinkAudio) / leftBlinkAudioFS);
    pause(eyeBlinkPause);
    disp('Beep');
    if isTestRun == 0
        NetStation('Event','BPST');
    end
    soundsc(beepSound);
    pause(beepDuration);
    if isTestRun == 0
        NetStation('Event','BPED');
        NetStation('Event','LEBS');
    end
    pause(eyeBlinkPause);
    if isTestRun == 0
        NetStation('Event','LEBE');
    end
    pause(eyeBlinkPause * 2);
    
    disp('Right Blink Instruction Playing...');
    soundsc(rightBlinkAudio, rightBlinkAudioFS);
    pause(length(rightBlinkAudio) / rightBlinkAudioFS);
    pause(eyeBlinkPause);
    disp('Beep');
    if isTestRun == 0
        NetStation('Event','BPST');
    end
    soundsc(beepSound);
    pause(beepDuration);
    if isTestRun == 0
        NetStation('Event','BPED');
        NetStation('Event','LEBS');
    end
    pause(eyeBlinkPause);
    if isTestRun == 0
        NetStation('Event','LEBE');
    end
    pause(eyeBlinkPause * 2);
    
end

disp('Trials finished');

%% Baseline
disp('Start Baseline');
if isTestRun == 0
    NetStation('Event','EBLS');
end
pause(baseLinePause);
if isTestRun == 0
    NetStation('Event','EBLE');
end

end


