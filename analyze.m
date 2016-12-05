% Script to analyze conditions given data collected

load trialData.mat  % load matlab file with all subject/trial data

% Calculate average reaction times for each condition (all trials)
avg_throwArmRT = mean([analysis.throwArmRT]);
avg_throwLegRT = mean([analysis.throwLegRT]);
avg_throwNonRT = mean([analysis.throwNonRT]);
avg_kickArmRT = mean([analysis.kickArmRT]);
avg_kickLegRT = mean([analysis.kickLegRT]);
avg_kickNonRT = mean([analysis.kickNonRT]);

% trackers for data arrays for each condition
mt = 0; % tracker for matching, accurate response trial data
nmt = 0; % tracker for non-matching, accurate response trial data
nwt = 0; % tracker for non-word, accurate response trial data

mtWrong = 0;
nmtWrong = 0;
nwtWrong = 0;

% create arrays with data from  accurate matching, 
% mis-matching, and non word trials
for j = 1:length(analysis)
    % create matching condition, accurate trial data array 
    for tA = 1:length(analysis(1).throwArmRT)
        if analysis(j).throwArmAcc(tA) == 1
            mt = mt + 1;
            matchAcc(mt) = analysis(j).throwArmRT(tA);
        else
            mtWrong = mtWrong + 1;
        end
    end
    for kL = 1:length(analysis(1).kickLegRT)
        if analysis(j).kickLegAcc(kL) == 1
            mt = mt + 1;
            matchAcc(mt) = analysis(j).kickLegRT(kL);
        else
            mtWrong = mtWrong + 1;
        end
    end
    
    % create mis-matching condition, accurate trial data array
    for tL = 1:length(analysis(1).throwLegRT)
        if analysis(j).throwLegAcc(tL) == 1
            nmt = nmt + 1;
            nonMatchAcc(nmt) = analysis(j).throwLegRT(tL);
        else
            nmtWrong = nmtWrong + 1;
        end      
    end
    for kA = 1:length(analysis(1).kickArmRT)
        if analysis(j).kickArmAcc(kA) == 1
            nmt = nmt + 1;
            nonMatchAcc(nmt) = analysis(j).kickArmRT(kA);
        else
            nmtWrong = nmtWrong + 1;
        end
    end
    
    % create non-word condition, accurate trial data array
    for tN = 1:length(analysis(1).throwNonRT)
        if analysis(j).throwNonAcc(tN) == 1
            nwt = nwt + 1;
            nonWordAcc(nwt) = analysis(j).throwNonRT(tN);
        else
            nwtWrong = nwtWrong + 1;
        end
    end
    for kN = 1: length(analysis(1).kickNonRT)
        if analysis(j).kickNonAcc(kN) == 1
            nwt = nwt + 1;
            nonWordAcc(nwt) = analysis(j).kickNonRT(kN);
        else
            nwtWrong = nwtWrong + 1;
        end
    end
end
            
% Calculate mean RT for each overall condition: match, non matching,
% and non-word (accurate trials only)
avg_matchRT = mean(matchAcc);
avg_nonMatchRT = mean(nonMatchAcc);
avg_nonWordRT = mean(nonWordAcc);
             
if((mtWrong > nmtWrong) && (mtWrong > nwtWrong))
    disp('Matching trials had the most inaccurate responses');
elseif((nmtWrong > mtWrong) && (nmtWrong > nwtWrong))
    disp('Mis-matching trials had the most inaccurate responses');
else
    disp('Non-word trials had the most inaccurate responses');
end

% Display average reaction times for each condition
disp(['Average RT for matching (accurate response) trials is ' ...
    num2str(avg_matchRT) ' seconds']);
disp(['Average RT for mismatching (accurate response) trials is ' ...
    num2str(avg_nonMatchRT) ' seconds']);
disp(['Average RT for non-word (accurate response) trials is ' ...
    num2str(avg_nonWordRT) ' seconds']);


% create array with RT for each condition
RTarray = [avg_throwArmRT, avg_throwLegRT, ...
    avg_throwNonRT, avg_kickArmRT, avg_kickLegRT, ...
    avg_kickNonRT];

% create a bar graph illustrating RT for each condition
avgRt = bar(RTarray);
set(gca,'XTickLabel',{'Throw-Arm', 'Throw-Leg', 'Throw-Non', ...
    'Kick-Arm', 'Kick-Leg', 'Kick-Non'});
xlabel('Condition');
ylabel('Reaction Time (seconds)');

% create array with RT for each overall condition (acc. trials only)
accRTarray = [avg_matchRT, avg_nonMatchRT, avg_nonWordRT ];

% create a bar graph RT for each overall conditiona (acc. trials only)
barOverall = bar(accRTarray);
set(gca, 'XTickLabel',{'Matching', 'Mis-Matching', 'Non-Word'});
xlabel('Condition');
ylabel('Reaction Time (seconds');
ylim([0.35 0.75]);
