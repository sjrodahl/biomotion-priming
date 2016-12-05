function showbiomotion(w, wRect, movieNo)
% AP Saygin - Simple script for showing biomotion
% Adapted from bioimage, 2008
% Adapted for MatlabFun Spring 2010
% Adapted 2016 AP Saygin

% misc initialization
rand('state', sum(100*clock));
KbName('UnifyKeyNames');
fg = 255;
bg = 0;
InterAnimTime = 0.5; % how long to wait between animations

% select which movies to present
% biovect contains 1:25 movies; 26:50 are mirror images
% to see subset, e.g. 1:5
movies = movieNo;
% to see select movies
% movies = [4 14 7] ;
% for all movies
% movies = [1:25];
% if you want mirror image of each, uncomment
% movies = [movies movies + 25];

nchosenmovies = size(movies,2);

% load dot position data and tidy up
load biovect;
cleanup;
% you should have startxc startyc, which contain the start positions of all
% the dots, and vectxc and vectyx, which contain the position of the dots 
% over time

[numframes, numdots, nummovies] = size(vectxc); % 20, 12, 50
dotsize = 7;
dottype = 2;

% ==== This part is moved to gatherdata.m ===
% initialize screen
%Screen('CloseAll')
%screenID=max(Screen('Screens'));

% not whole screen debug mode
%[w,wRect]=Screen(screenID,'OpenWindow',0,[0 0 800 600],[],2);
% full screen
% [w,wRect]=Screen(screenID,'OpenWindow',0,[],[],2); 
%=== ===
[centerx, centery] = RectCenter(wRect);
textx = wRect(3)-wRect(3)*0.1;
texty = wRect(4)-wRect(4)*0.1;
WaitSecs(1);
Screen('FillRect', w, bg);
Screen('TextColor', w, fg);

%for(i=1:2)
%    Screen('FillRect', w, bg);
%    DrawFormattedText(w,'Will now play animations','center','center',fg);
%    Screen('Flip', w);
%end;
%WaitSecs(2);


for movie = 1:nchosenmovies % for each movie
    Screen('FillRect', w, bg);
    for i= 1:numframes % each frame
        for dot = 1:numdots % each dot
            % calculate dot position x and y
            myvectx = vectxc(:,dot,movies);
            myvecty = vectyc(:,dot,movies);
            dotposition = [centerx + startxc(dot,movies) + myvectx(i), centery + startyc(dot,movies) + myvecty(i)];
            % save this dot in alldots to draw
            alldots(:,dot)=dotposition';
        end;
        Screen('DrawDots', w, alldots, dotsize, fg, [0 0], dottype);
        %Screen('DrawText', w, num2str(movies), textx, texty, fg);
        Screen('Flip', w);
        Screen('FillRect', w, bg);
        Screen('Flip', w);
    end;
    WaitSecs(InterAnimTime);

end;
%WaitSecs(2);
%Screen('CloseAll');


