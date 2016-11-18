function [ output_args ] = gatherdata()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

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
        %Get some input 
    end
    %Do something with input
    
    Screen('Close', w);
end

