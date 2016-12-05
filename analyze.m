% Script to analyze conditions given data collected

load trialData.mat  % load matlab file with all subject/trial data

% Calculate average reaction times for each condition (all trials)
avg_throwArmRT = mean([analysis.throwArmRT]);
avg_throwLegRT = mean([analysis.throwLegRT]);
avg_throwNonRT = mean([analysis.throwNonRT]);
avg_kickArmRT = mean([analysis.kickArmRT]);
avg_kickLegRT = mean([analysis.kickLegRT]);
avg_kickNonRT = mean([analysis.kickNonRT]);

% trackers for data arrays for accurate response, each condition
mt = 0; % tracker for matching, accurate response trial data
nmt = 0; % tracker for non-matching, accurate response trial data
nwt = 0; % tracker for non-word, accurate response trial data

% trackers for incorrect response for each condition
mtWrong = 0;
nmtWrong = 0;
nwtWrong = 0;

% create arrays with data from  accurate matching, 
% mis-matching, and non word trials
for j = 1:length(analysis)
    % create matching condition, accurate trial data array 
    for tA = 1:length(analysis(1).throwArmRT)
        if analysis(j).throwArmAcc(tA) == 1 % if accurate response
            mt = mt + 1; % count accurate match trial
            matchAcc(mt) = analysis(j).throwArmRT(tA);
        else
            mtWrong = mtWrong + 1; % count incorrect response matching
        end
    end
    for kL = 1:length(analysis(1).kickLegRT)
        if analysis(j).kickLegAcc(kL) == 1 % if accurate response
            mt = mt + 1; % count accurate match trial
            matchAcc(mt) = analysis(j).kickLegRT(kL);
        else
            mtWrong = mtWrong + 1; % coun incorrect response matching
        end
    end
    
    % create mis-matching condition, accurate trial data array
    for tL = 1:length(analysis(1).throwLegRT)
        if analysis(j).throwLegAcc(tL) == 1 % if accurate response
            nmt = nmt + 1; % count accurate non-match trial
            nonMatchAcc(nmt) = analysis(j).throwLegRT(tL);
        else
            nmtWrong = nmtWrong + 1; % coun incorrect response non-matching
        end      
    end
    for kA = 1:length(analysis(1).kickArmRT)
        if analysis(j).kickArmAcc(kA) == 1 % if accurate response
            nmt = nmt + 1; % count accurate non-match trial
            nonMatchAcc(nmt) = analysis(j).kickArmRT(kA);
        else
            nmtWrong = nmtWrong + 1; % count incorrect response non-matching
        end
    end
    
    % create non-word condition, accurate trial data array
    for tN = 1:length(analysis(1).throwNonRT)
        if analysis(j).throwNonAcc(tN) == 1 % if accurate response
            nwt = nwt + 1; % count accurate non-word trial
            nonWordAcc(nwt) = analysis(j).throwNonRT(tN);
        else
            nwtWrong = nwtWrong + 1; % count incorrect response non-word
        end
    end
    for kN = 1: length(analysis(1).kickNonRT)
        if analysis(j).kickNonAcc(kN) == 1 % if accurate response
            nwt = nwt + 1; % count accurate non-word trial
            nonWordAcc(nwt) = analysis(j).kickNonRT(kN);
        else
            nwtWrong = nwtWrong + 1; % count incorrect response non-word
        end
    end
end
            
% Calculate mean RT for each overall condition: match, non matching,
% and non-word (accurate trials only)
avg_matchRT = mean(matchAcc); 
avg_nonMatchRT = mean(nonMatchAcc);
avg_nonWordRT = mean(nonWordAcc);

% Calculate total trials for each overall condition
totalMatch = mt + mtWrong;
totalNonMatch = nmt + nmtWrong;
totalNonWord = nwt + nwtWrong;

% Calculate percent accurate for each overall condition
matchResp = (mt/totalMatch) * 100;
nonMatchResp = (nmt/totalNonMatch) * 100;
nonWordResp = (nwt/totalNonWord) * 100;

% Display percent accurate for each overall condition
disp(['Matching accuracy: ',num2str(matchResp), '%']);
disp(['Mismatching accuracy: ',num2str(nonMatchResp), '%']);
disp(['Non-word accuracy: ',num2str(nonWordResp), '%']);

% Display average reaction times for each condition
disp(['Average RT for matching (accurate response) trials is ' ...
    num2str(avg_matchRT) ' seconds']);
disp(['Average RT for mismatching (accurate response) trials is ' ...
    num2str(avg_nonMatchRT) ' seconds']);
disp(['Average RT for non-word (accurate response) trials is ' ...
    num2str(avg_nonWordRT) ' seconds']);


% create a bar graph illustrating RT for each condition
% avgRt = bar(RTarray);
% set(gca,'XTickLabel',{'Throw-Arm', 'Throw-Leg', 'Throw-Non', ...
    % 'Kick-Arm', 'Kick-Leg', 'Kick-Non'});
% xlabel('Condition');
% ylabel('Reaction Time (seconds)');

% create array with RT for each overall condition (acc. trials only)
accRTarray = [avg_matchRT, avg_nonMatchRT, avg_nonWordRT ];

% create a bar graph RT for each overall conditiona (acc. trials only)
barOverall = bar(accRTarray);
set(gca, 'XTickLabel',{'Matching', 'Mis-Matching', 'Non-Word'});
xlabel('Condition');
ylabel('Reaction Time (seconds');
ylim([0.35 0.75]);
