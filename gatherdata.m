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

    words = {'arm', 'leg', 'gesf'};
    movieArray = [1, 2, 3];
    for i =1:length(words)
        showbiomotion(w, wRect,  movieArray(i));
        %Screen('OpenWindow', w, [0, 0 ,0], wRect);
        Screen('DrawText', w, words{i}, wRect(1), wRect(2), [255, 255, 255]);
        Screen('Flip', w);
        WaitSecs(2);
        %Get some input (KbCheck)
    end
    %Do something with input
    
    Screen('Close', w);
end

