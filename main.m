%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Biomotion-action priming                                          %    
%                                                                   %
%%%% main.m:                                                        %
%%%%%%%% Set up the words and corresponding movie in a random order %
%%%%%%%% Gather subject information                                 %
%%%%%%%% Calculate the accuracy                                     %
%%%%%%%% Save the results in a mat and txt file                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

now = datestr(datetime);
%wordArray: 4x(#words per category)
%To ensure that #real-words = #nonreal-words, row 1 and 2 are real words, 3
%and 4 are nonreal.
wordArray = {% Arm-related words
    'applaud', 'catch', 'clap', 'grasp', 'knock', 'peel', 'punch',...
    'shoot', 'slap', 'stitch', 'wave', 'write'; 
    % Leg-related words
    'kneel', 'limp', 'lunge', 'march', 'skate', 'sprint', 'squat', ...
    'stand', 'step', 'stomp', 'stride', 'walk'
    % Non-words
    'bounge', 'clight', 'glimb', 'joost', 'jurns', 'kneak', ...
    'malter', 'marpe', 'nunge', 'prane', 'sceep', ' truat';
    'brune', 'compy', 'hepel', 'pivine', 'sedun', 'skaver', ...
    'sline', 'sproll', 'bounge', 'clight', 'glimb', 'joost'};
        %Replace four last words with new ones if possible, they are
        %repeated.
[r, nWords] = size(wordArray);

%Shuffle the words:
wordArray= wordArray(:, randperm(nWords));

kick = [9 10 11 23];
throw = [18 20 21 22 ];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Movies:       %%%%%%%%%%   Words:
% Throw = [18 20 21 22 ]    % 1 = Arm related
% Kick = [9 10 11 23]       % 2 = Leg related
% 1 = Throw-movie           % 3 = Non-word
% 2 = Kick-movie            % 4 = Non-word
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%1st column: movie number; 2nd column: word number; 3rd column: Word (1) or
%NonWord(2)
conditions = [
    1 1 1 1;    % Condition 1: Throw - arm
    1 2 1 2;    % Condition 2: Throw - leg
    1 3 0 3;    % Condition 3: Throw - non-word
    1 4 0 3;    % Repeat cond 3 to get #words = #non-words
    2 1 1 4;    % Condition 4: Kick - arm
    2 2 1 5;    % Condition 5: Kick - leg
    2 3 0 6;    % Condition 6: Kick - nonword
    2 4 0 6;    % Repeat cond 6 to get #words = #non-words
    ];
[nCond, c] = size(conditions);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Change this to change trial size          %
% numTrialsPerCondition * nCond = numTrials %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numTrialsPerCondition = 1;

trials = repmat(conditions, numTrialsPerCondition, 1);
[nTrials, c] = size(trials);

%Shuffle the rows of trials:
trials = trials(randperm(nTrials), :);

words = cell(nTrials, 1);

movieArray = zeros(nTrials, 1);

%The integers in wordPointers are pointing to the next word to use in the
%corresponding row in wordArray. 
%wordPointer = [armCounter, legCounter, nonCounter, nonCounter2]
wordPointer = ones(1, r);

for i=1:nTrials
    if trials(i,1) == 1 %Throw-movie
        movieArray(i) = throw(randi(length(throw)));
    elseif trials(i, 1) == 2    %Kick-movie
        movieArray(i) = kick(randi(length(kick)));
    end
    wordNumber = trials(i, 2);
    words{i} = wordArray{wordNumber, wordPointer(wordNumber)};
    wordPointer(wordNumber) = wordPointer(wordNumber) +1;
    if wordPointer(wordNumber)==nWords
        %Reset the pointer and shuffle the words
        wordPointer(wordNumber) = 1;
        wordArray(wordNumber, :) = wordArray(wordNumber, randperm(nWords));
        
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Get subject information %
%%%%%%%%%%%%%%%%%%%%%%%%%%%

subjectID = input('Subject ID: ');

handedness = 'n';
while ~(lower(handedness) == 'r' || lower(handedness) == 'l')
    handedness = input('Is the subject left or right-handed? l = left, r = right. ', 's');
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

result = struct('subjectID', subjectID, 'time', now, 'hand', handedness, 'data', struct('conditions', trials(:, 4)', 'accuracy', accuracy, 'RT', data.RT));

groupData(result); % group data based on condition and save

filename = sprintf ('test%d', subjectID);
save(filename, 'result');
textfilename = sprintf('%s.txt', filename);
[fid, msg] = fopen(textfilename, 'w');
if fid == -1
   fprintf('Error opening file %s\n%s.', textfilename, msg);
end
fprintf(fid, 'SubjectID: %d\nTime: %s\nHandedness: %s\n', subjectID, now, handedness);
fprintf(fid, 'Condition\tAccuracy\tReaction time\t\n');
for i = 1:length(accuracy)
    fprintf(fid, '%d\t%d\t%1.4f\n',trials(i, 4), accuracy(i), data.RT(i));
    
end
fclose(fid);

