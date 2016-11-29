function groupData(result)
% Analyze data, creating matrix file to store each subject data
% individually then analyzing data

% Check if the trial data file has already been created 
fileExist = exist('trialData.mat');
if fileExist == 2
    load trialData.mat; % load trial data from other subjects
end
    

id = result.subjectID;
cond = result.data.conditions;
numTrials = length(cond);

% trackers for data arrays for each condition
ta = 0; % throw-arm tracker
tl = 0; % throw-leg tracker
tn = 0; % throw non-word tracker

ka = 0; % kick-arm tracker
kl = 0; % kick-leg tracker
kn = 0; % kick non-word tracker

% Create data array for each condition (reaction time and accuracy)
for n = 1:numTrials 
    % throw-arm condition 
    if cond(n) == 1 
        ta = ta + 1;
        analysis(id).throwArmRT(ta) = result.data.RT(n);
        analysis(id).throwArmAcc(ta) = result.data.accuracy(n);
    % throw-leg condition
    elseif cond(n) == 2
        tl = tl + 1;
        analysis(id).throwLegRT(tl) = result.data.RT(n);
        analysis(id).throwLegRT(tl) = result.data.accuracy(n);
    % throw non-word condition
    elseif cond(n) == 3
        tn = tn + 1;
        analysis(id).throwNonRT(tn) = result.data.RT(n);
        analysis(id).throwNonAcc(tn) = result.data.accuracy(n);
    % kick-arm condition
    elseif cond(n) == 4
        ka = ka + 1;
        analysis(id).kickArmRT(ka) = result.data.RT(n);
        analysis(id).kickArmAcc(ka) = result.data.accuracy(n);
    % kick-leg condition  
    elseif cond(n) == 5
        kl = kl + 1;
        analysis(id).kickLegRT(kl) = result.data.RT(n);
        analysis(id).kickLegAcc(kl) = result.data.accuracy(n);
    % kick non-word condition  
    elseif cond(n) == 6
        kn = kn + 1;
        analysis(id).kickNon(kn) = result.data.RT(n);
        analysis(id).kickNon(kn) = result.data.accuracy(n);
    end
end

% Create data arrays for handedness
if strcmpi(result.hand, 'r')
    

    
save trialData.mat analysis


end
