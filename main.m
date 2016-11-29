

now = datestr(datetime);
wordArray = {'arm', 'hand';
    'leg', 'knee';
    'fertte', 'klimca'};
kick = [9 10 11 23];
throw = [18 20 21 22 ];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Movies:       %%%%%%%%%%   Words:
% Throw = [18 20 21 22 ]    % 1 = Arm related
% Kick = [9 10 11 23]       % 2 = Leg related
% 1 = Throw-movie           % 3 = Non-word
% 2 = Kick-movie
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%1st column: movie number; 2nd column: word number; 3rd column: Word (1) or
%NonWord(2)
conditions = [
    1 1 1 1;    % Condition 1: Throw - arm
    1 2 1 2;    % Condition 2: Throw - leg
    1 3 0 3;    % Condition 3: Throw - non-word
    2 1 1 4;    % Condition 4: Kick - arm
    2 2 1 5;    % Condition 5: Kick - leg
    2 3 0 6;    % Condition 6: Kick - nonword
    ];
[nCond, c] = size(conditions);

%numTrialsPerCondition * nCond = numTrials
numTrialsPerCondition = 1;

trials = repmat(conditions, numTrialsPerCondition, 1);
[nTrials, c] = size(trials);

%Shuffle the rows of trials:
trials = trials(randperm(nTrials), :);

words = cell(nTrials, 1);
armCounter = 1; legCounter = 1; nonCounter = 1;

movieArray = zeros(nTrials, 1);
for i=1:nTrials
    if trials(i,1) == 1 %Throw-movie
        movieArray(i) = throw(randi(length(throw)));
    elseif trials(i, 1) == 2    %Kick-movie
        movieArray(i) = kick(randi(length(kick)));
    end
    if trials(i, 2) == 1 %Arm-word
        words{i} = wordArray{1, armCounter};    %Add next arm-word in array
        armCounter = armCounter + 1;
    elseif trials(i, 2) == 2 %Leg-word
        words{i} = wordArray{2, legCounter};    
        legCounter = legCounter + 1;
    elseif trials(i, 2) == 3 %Non-word
        words{i} = wordArray{3, nonCounter};
        nonCounter = nonCounter + 1;   
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Get subject information %
%%%%%%%%%%%%%%%%%%%%%%%%%%%

subjectID = input('Subject ID: ');

handedness = 'n';
while ~(lower(handedness) == 'r' || lower(handedness) == 'l')
    handedness = input('Is the subject left or right-handed? l = left, r = right', 's');
    if ~(lower(handedness) == 'r' || lower(handedness) == 'l')
        fprintf('Invalid response. Press l or r.\n');
    end
    
end

%%%%%%%%%%%%%%%
% Gather data %
%%%%%%%%%%%%%%%
data = gatherdata(words, movieArray);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate and save results %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
accuracy = (data.response & trials(:, 3)') | (~data.response & ~trials(:, 3)');
result = struct('subjectID', subjectID,, 'time', now, 'hand', handedness, 'data', struct('conditions', trials(:, 4)', 'accuracy', accuracy, 'RT', data.RT));
filename = sprintf ('test%d', subjectID);
save(filename, 'result');



