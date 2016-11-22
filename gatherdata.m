function [ DataStruct ] = gatherdata( words, movieArray )
%Start the data gethering process. Take the imput of words, and movieArray 
%from the main function. Returning the output of DataStruct. 
%   Detailed explanation goes her

    %preparing screen
    % initialize screen
    %Screen('CloseAll')
    screenID=max(Screen('Screens'));

    % not whole screen debug mode
    [w,wRect]=Screen(screenID,'OpenWindow',0,[0 0 800 600],[],2);
    % full screen
    % [w,wRect]=Screen(screenID,'OpenWindow',0,[],[],2); 

    KbName('UnifyKeyNames'); % set keyboard type
    %clear all;
    FlushEvents;
    while KbCheck;
    end
    toWait = 3; % length of time to wait for response
    
    words = {'arm', 'leg', 'gesf'};
    movieArray = [1, 2, 3];
    for i =1:length(words)
        showbiomotion(w, wRect,  movieArray(i));
        %Screen('OpenWindow', w, [0, 0 ,0], wRect);
        Screen('DrawText', w, words{i}, wRect(1), wRect(2), [255, 255, 255]);
        Screen('Flip', w);
        WaitSecs(2);
        %Get some input (KbCheck)
        %clear all;
        TrialStart = GetSecs;
        keyIsDown = 0;
        FlushEvents;
        while KbCheck;
        end
        
        while GetSecs < TrialStart + toWait
            [keyIsDown, secs, keycode] = KbCheck;
            
            if keyIsDown
                DataStruct.response(i) = KbName(keycode);
                DataStruct.time(i) = secs - TrialStart;
                keyIsDown = 0;
                FlushEvents;
                break
            else % if no key is pressed  --> still need to discuss
                DataStruct.response(i) = '';
                DataStruct.time(i) = ?;
                FlushEvevnts;
            end
            keyIsDown = 0;
            FlushEvents;
        end
        while KbCheck;
        end
        
        if response == no response --> still need to discuss
        end
    end
    %Do something with input
    
    Screen('Close', w);
end

