% Script to analyze conditions given data collected

load trialData.mat

avg_throwArmRT = mean(analysis.throwArmRT);
avg_throwLegRT = mean(analysis.throwLegRT);
avg_throwNonRT = mean(analysis.throwNonRT);
avg_kickArmRT = mean(analysis.kickArmRT);
avg_kickLegRT = mean(analysis.kickLegRT);
avg_kickNonRT = mean(analysis.kickNonRT);

disp(['Average RT for throw-arm condition is ' ...
    num2str(avg_throwArmRT) ' seconds']);
disp(['Average RT for throw-leg condition is ' ...
    num2str(avg_throwLegRT) ' seconds']);
disp(['Average RT for throw non-word condition is ' ...
    num2str(avg_throwNonRT) ' seconds']);

disp(['Average RT for kick-arm condition is ' ...
    num2str(avg_kickArmRT) ' seconds']);
disp(['Average RT for kick-leg condition is ' ...
    num2str(avg_kickLegRT) ' seconds']);
disp(['Average RT for kick non-word condition is ' ...
    num2str(avg_kickNonRT) ' seconds']);

RTarray = [avg_throwArmRT, avg_throwLegRT, ...
    avg_throwNonRT, avg_kickArmRT, avg_kickLegRT, ...
    avg_kickNonRT];

bar(RTarray)
set(gca,'XTickLabel',{'Throw-Arm', 'Throw-Leg', 'Throw-Non', ...
    'Kick-Arm', 'Kick-Leg', 'Kick-Non'})






