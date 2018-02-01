function surpriseOnWarm
% Rini Sharon, Hari Maruthachalam - Updated on Feb 1, 2018
% Usage: surpriseOnWarm
% This code will present audio stimuli to the subject. We present
% relaxation tone to the subject along with various surprise sounds.
% Use configuration to specify path and audio files.
% Path in configuration should have trailing slash and files shouldn't have
% preceding slash.
%%%%----------ALL CODES FOR NETSTATION------%%%%%
% SBLS - Start BaseLine Start
% SBLE - Start BaseLine End
% RTST - Relax Tone StarT
% RTED - Relax Tone EnD
% BAST - BAng StarT
% BAED - BAng EnD
% CBST - Cry Baby StarT
% CBED - Cry Baby EnD
% SIST - SIren StarT
% SIED - SIren EnD
% TWST - Train Whistle StarT
% TWED - Train Whistle EnD
% TOST - TOing StarT
% TOED - TOing EnD
% EBLS - End BaseLine Start
% EBLE - End BaseLine End

close all;
clear;
clc;

%% Configurations
isTestRun = 1;
baseLinePause = 20;
noOfTrials = 5;
ipAddress = '10.10.10.42';
noOfSurpriseTone = 5;
path = 'D:\scriptsEEGDataCollection\cog_surp_sounds_experiment_data_collection\'; % With trailing slash
relaxTone5SecFile = 'r5.wav';
relaxTone10SecFile = 'r10.wav';
relaxTone20SecFile = 'r20.wav';
relaxTone30SecFile = 'r30.wav';
relaxTone40SecFile = 'r40.wav';
relaxTone50SecFile = 'r50.wav';
babyCryAudioFile = 'cry_baby.wav';
sirenAudioFile = 'siren.wav';
bangAudioFile = 'bang.wav';
trainWhistleAudioFile = 'train_whistle.wav';
toingAudioFile = 'toing.wav';
numSurprise = [1, 2];

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

%% Beep producee - Commenting as we dont need...
% beepLength = 0 : 2047;
% fs = 8192;
% freq = 300;
% beepSampleTime = 1 / fs ;
% beepSound = cos(2 * pi * freq * beepLength * beepSampleTime);
% beepDuration = beepLength / fs;

%% Audio files
try
    [relaxTone5SecAudio, relaxTone5SecFs] = audioread([path relaxTone5SecFile]);
    [relaxTone10SecAudio, relaxTone10SecFs] = audioread([path relaxTone10SecFile]);
    [relaxTone20SecAudio, relaxTone20SecFs] = audioread([path relaxTone20SecFile]);
    [relaxTone30SecAudio, relaxTone30SecFs] = audioread([path relaxTone30SecFile]);
    [relaxTone40SecAudio, relaxTone40SecFs] = audioread([path relaxTone40SecFile]);
    [relaxTone50SecAudio, relaxTone50SecFs] = audioread([path relaxTone50SecFile]);
    [babyCryAudio, babyCryAudioFs] = audioread([path babyCryAudioFile]);
    [sirenAudio, sirenAudioFs] = audioread([path sirenAudioFile]);
    [trainWhistleAudio, trainWhistleAudioFs] = audioread([path trainWhistleAudioFile]);
    [toingAudio, toingAudioFs] = audioread([path toingAudioFile]);
    [bangAudio, bangAudioFs] = audioread([path bangAudioFile]);
catch exception
    error('Audio files are not loaded! Check path and files.');
end

%% NetStation Connection
if isTestRun == 0
    NetStation('Connect', ipAddress);
    NetStation('StartRecording');
    NetStation('Synchronize');
end
disp('Recording Starts');

%% Start Baseline
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
    disp(['Trial ' num2str(trials) ' starts...']);
    surprisePremutation = randperm(noOfSurpriseTone);
    
    for subTrial = 1 : noOfSurpriseTone
        randomSurprise = numSurprise(randperm(length(numSurprise)));
        disp(['Subtrail ' num2str(subTrial) ' starts...']);
        disp('Sample Relaxation Tone for 5 seconds...');
        if isTestRun == 0
            NetStation('Event','RTST');
        end
        soundsc(relaxTone5SecAudio, relaxTone5SecFs);
        pause(length(relaxTone5SecAudio) / relaxTone5SecFs);
        
        if isTestRun == 0
            NetStation('Event','RTED');
        end
        for iter = 1 : length(numSurprise)
            if randomSurprise(iter) == 1
                switch surprisePremutation(subTrial)
                    case 1
                        disp('Relaxation Tone for 10 seconds...');
                        audioFileChosen = relaxTone10SecAudio;
                        audioFileChosenFs = relaxTone10SecFs;
                    case 2
                        disp('Relaxation Tone for 20 seconds...');
                        audioFileChosen = relaxTone20SecAudio;
                        audioFileChosenFs = relaxTone20SecFs;
                    case 3
                        disp('Relaxation Tone for 30 seconds...');
                        audioFileChosen = relaxTone30SecAudio;
                        audioFileChosenFs = relaxTone30SecFs;
                    case 4
                        disp('Relaxation Tone for 40 seconds...');
                        audioFileChosen = relaxTone40SecAudio;
                        audioFileChosenFs = relaxTone40SecFs;
                    case 5
                        disp('Relaxation Tone for 50 seconds...');
                        audioFileChosen = relaxTone50SecAudio;
                        audioFileChosenFs = relaxTone50SecFs;
                end
                if isTestRun == 0
                    NetStation('Event','RTST');
                end
                soundsc(audioFileChosen, audioFileChosenFs);
                pause(length(audioFileChosen) / audioFileChosenFs);
                if isTestRun == 0
                    NetStation('Event','RTED');
                end
            else
                disp('Surprise Tone Playing...');
                switch surprisePremutation(subTrial)
                    case 1
                        if isTestRun == 0
                            NetStation('Event','CBST');
                        end
                        soundsc(babyCryAudio, babyCryAudioFs);
                        pause(length(babyCryAudio) / babyCryAudioFs);
                        if isTestRun == 0
                            NetStation('Event','CBED');
                        end
                    case 2
                        if isTestRun == 0
                            NetStation('Event','SIST');
                        end
                        soundsc(sirenAudio, sirenAudioFs);
                        pause(length(sirenAudio) / sirenAudioFs);
                        if isTestRun == 0
                            NetStation('Event','SIED');
                        end
                    case 3
                        if isTestRun == 0
                            NetStation('Event','BAST');
                        end
                        soundsc(bangAudio, bangAudioFs);
                        pause(length(bangAudio) / bangAudioFs);
                        if isTestRun == 0
                            NetStation('Event','BAED');
                        end
                    case 4
                        if isTestRun == 0
                            NetStation('Event','TWST');
                        end
                        soundsc(trainWhistleAudio, trainWhistleAudioFs);
                        pause(length(trainWhistleAudio) / trainWhistleAudioFs);
                        if isTestRun == 0
                            NetStation('Event','TWED');
                        end
                    case 5
                        if isTestRun == 0
                            NetStation('Event','TOST');
                        end
                        soundsc(toingAudio, toingAudioFs);
                        pause(length(toingAudio) / toingAudioFs);
                        if isTestRun == 0
                            NetStation('Event','TOED');
                        end
                end
            end
        end
        disp('SubTrial Finished...');
    end
end
disp('Trials are finished...');

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
