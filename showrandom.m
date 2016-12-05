function [ output_args ] = showrandom(w, wRect)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

rand('state', sum(100*clock));
KbName('UnifyKeyNames');
fg = 255;
bg = 0;
InterAnimTime = 0.5; % how long to wait between animations

% load dot position data and tidy up
load biovect;
cleanup;
% you should have startxc startyc, which contain the start positions of all
% the dots, and vectxc and vectyx, which contain the position of the dots
% over time

[numframes, numdots, nummovies] = size(vectxc); % 20, 12, 50
dotsize = 7;
dottype = 2;

[centerx, centery] = RectCenter(wRect);
textx = wRect(3)-wRect(3)*0.1;
texty = wRect(4)-wRect(4)*0.1;
WaitSecs(1);
Screen('FillRect', w, bg);
Screen('TextColor', w, fg);

movieee = [9 10 11 23 18 20 21 22]; % movies selected
order = randperm(length(movieee));
shuffledmovie = movieee(order); % Eg. [11 20 9 10 23 18 22 21]

dotty = 1:numdots;
fororder = randperm(length(dotty));
shuffleddot = dotty(fororder); % Eg. [3 7 12 10 5 2 1 8 9 11 4 6]

waitTime = 3;
movie = 1;
h = 1;
startTime = GetSecs;
FlushEvents;
while KbCheck; end
keyPressed = 0;
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
    Screen('DrawText', w, num2str(movieee(movie)), textx, texty, fg);
    Screen('DrawText', w, num2str(h), textx-50, texty, fg);
    Screen('Flip', w);
    Screen('FillRect', w, bg);
    Screen('Flip', w);
    keyPressed = KbCheck;
    if keyPressed
        break;
    end
end;
while KbCheck; end
FlushEvents;
while (~keyPressed) || (GetSecs < startTime+waitTime)
    keyPressed = KbCheck;
    if keyPressed 
        break;
    end
end
if keyPressed 
   resp = 'Correct. Press any key to continue.';
else
   resp = 'You did not press a button. Press any key to continue.';
end
DrawFormattedText(w, resp, 'center', 'center', [255 255 255]);
Screen('Flip',w);
keyIsDown = 0;
while KbCheck; end
FlushEvents;
while true
    keyIsDown = KbCheck;
    if keyIsDown
        Screen('FillRect', w, bg);
        Screen('Flip', w);
        break;
    end
end
WaitSecs(InterAnimTime);

end

