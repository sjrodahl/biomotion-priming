function showbiomotion()
% AP Saygin - Simple script for showing biomotion
% Adapted from bioimage, 2008
% Adapted for MatlabFun Spring 2010
% Adapted 2016 AP Saygin

% misc initialization
rand('state', sum(100*clock));
KbName('UnifyKeyNames');
fg = 255;
bg = 0;
InterAnimTime = 1; % how long to wait between animations

% select which movies to present
% biovect contains 1:25 movies; 26:50 are mirror images
% to see subset, e.g. 1:5
movies = 1:25;
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

% initialize screen
Screen('CloseAll')
screenID=max(Screen('Screens'));

% not whole screen debug mode
[w,wRect]=Screen(screenID,'OpenWindow',0,[0 0 800 600],[],2);
% full screen
% [w,wRect]=Screen(screenID,'OpenWindow',0,[],[],2);

[centerx, centery] = RectCenter(wRect);
textx = wRect(3)-wRect(3)*0.1;
texty = wRect(4)-wRect(4)*0.1;
WaitSecs(1);
Screen('FillRect', w, bg);
Screen('TextColor', w, fg);

for(i=1:2)
    Screen('FillRect', w, bg);
    Screen('DrawText', w,'Will now play animations',10,30,fg);
    Screen('Flip', w);
end;
WaitSecs(2);

movieee = [9 10 11 23 18 20 21 22]; % movies selected
order = randperm(length(movieee));
shuffledmovie = movieee(order); % Eg. [11 20 9 10 23 18 22 21]

dotty = 1:numdots;
fororder = randperm(length(dotty));
shuffleddot = dotty(fororder); % Eg. [3 7 12 10 5 2 1 8 9 11 4 6]



for movie = 1:length(movieee)  %1:nchosenmovies % for each movie
    Screen('FillRect', w, bg);
    for h = 1:length(shuffledmovie)
        
        for i= 1:numframes % each frame
            for dot = 1:numdots % each dot
                %for h = 1: length(dot)
                % calculate dot position x and y
                myvectx = vectxc(:,dot,movieee(movie));
                myvecty = vectyc(:,dot,movieee(movie));
                
                dotposition = [centerx + startxc(shuffleddot(dot),shuffledmovie(h)) + myvectx(i), centery + startyc(shuffleddot(dot),shuffledmovie(h)) + myvecty(i)];
                
                % save this dot in alldots to draw
                alldots(:,dot) = dotposition';
                
                %end;
                
            end;
            Screen('DrawDots', w, alldots, dotsize, fg, [0 0], dottype);
            %Screen('DrawText', w, num2str(movieee(movie)), textx, texty, fg);
            Screen('DrawText', w, num2str(movieee(movie)), textx, texty, fg);
            Screen('DrawText', w, num2str(h), textx-50, texty, fg);
            Screen('Flip', w);
            Screen('FillRect', w, bg);
            Screen('Flip', w);
            
        end;
        fororder = randperm(length(dotty));
        shuffleddot = dotty(fororder);
        order = randperm(length(movieee));
        shuffledmovie = movieee(order);
        
        WaitSecs(0.5);
    end;
    WaitSecs(InterAnimTime);
end;

save('ShuffledResult_dot.mat', 'shuffleddot');
save('ShuffledResult_movie.mat', 'shuffledmovie');

WaitSecs(2);
Screen('CloseAll');
