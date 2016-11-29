function [ dataStruct ] = gatherdata(words, movieArray)
%Start the data gethering process. Take the imput of words, and movieArray 
%from the main function. Returning the output of DataStruct. 
%   Detailed explanation goes her
    
    % While we figure out how to hanlde this, test data is here:
    words = {'arm', 'leg', 'gesf'};
    movieArray = [1, 2, 3];

    %preparing screen
    % initialize screen
    %Screen('CloseAll')
    screenID=max(Screen('Screens'));

    % not whole screen debug mode
    [w,wRect]=Screen(screenID,'OpenWindow',0,[0 0 800 600],[],2);
    Screen('TextSize', w, 16);
    % full screen
    % [w,wRect]=Screen(screenID,'OpenWindow',0,[],[],2); 

    KbName('UnifyKeyNames'); % set keyboard type
    %clear all;
    FlushEvents;
    while KbCheck;
    end
    %toWait = 3; % length of time to wait for response
    
    respToNumMap = containers.Map({'z', 'm'}, [1,2]);
    
    rtArray= zeros(1,length(words));
    respArray = zeros(1, length(words));
    intro = 'You will be presented to an animation followed by a word.\n\nYour task is to decide if the word is real or not.\n\nPress `z` if it is a real word, `m` if its a non-word.\n\nPress any key to start';
    DrawFormattedText(w, intro, 'center', 'center', [255 255 255]);
    Screen('Flip',w);
    keyIsDown = 0;
    while ~keyIsDown
        keyIsDown = KbCheck;
    end
    
    Screen('TextSize', w, 20);
    for i =1:length(words)
        showbiomotion(w, wRect,  movieArray(i));
        %Screen('OpenWindow', w, [0, 0 ,0], wRect);
        DrawFormattedText(w, words{i}, 'center', 'center', [255, 255, 255]);
        Screen('Flip', w);
        
        start_time = GetSecs;
        FlushEvents; % release all events in the event queue
        while KbCheck; end
        keyIsDown = 0;
        while ~keyIsDown
            [keyIsDown, secs, keycode] = KbCheck;
            if keyIsDown % if a key is pressed figure out what it was and when it was
                response = KbName(keycode);
                rt = secs - start_time; %Calculate RT from TrialStartTime
                FlushEvents;
                if ~respToNumMap.isKey(response)
                    DrawFormattedText(w, 'Invalid response. Please try again', 'center', 'center', [255, 255, 255]);s
                    Screen('Flip', w);
                    
                    keyIsDown = 0;
                end
            end
            
        end                
        while KbCheck; end 
        rtArray(i) = rt;
        responseArray(i) = respToNumMap(response);
    end
    dataStruct = struct('response', responseArray, 'RT', rtArray);
    %Do something with input
    %return struct with: RT, response, condition
    
    
    
    
    Screen('Close', w);
end

