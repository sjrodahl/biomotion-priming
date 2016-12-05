load 'trialData.mat';
analyze;

numSbj = 6;
numTrial = 150;

for i = 1:numSbj
klRT (i,:) = analysis(i).kickLegRT;
end
klRT = reshape(klRT,[1,numTrial]);

for i = 1:numSbj
tlRT (i,:) = analysis(i).throwLegRT;
end
tlRT = reshape(tlRT,[1,numTrial]);

[h1,p1] = ttest(klRT,tlRT);

for i = 1:numSbj
kaRT (i,:) = analysis(i).kickArmRT;
end
kaRT = reshape(kaRT,[1,numTrial]);

for i = 1:numSbj
taRT (i,:) = analysis(i).throwLegRT;
end
taRT = reshape(taRT,[1,numTrial]);

[h2,p2] = ttest(kaRT,taRT);

for i = 1:numSbj
knRT (i,:) = analysis(i).kickNonRT;
end
knRT = reshape(knRT,[1,numTrial*2]);

for i = 1:numSbj
tnRT (i,:) = analysis(i).throwNonRT;
end
tnRT = reshape(tnRT,[1,numTrial*2]);

[h3,p3] = ttest(knRT,tnRT);

disp(['t-test result between kick-leg and throw-leg is ' ...
num2str(h1)]);
disp(['p-value is ' num2str(p1)]);

disp(['t-test result between kick-arm and throw-arm is ' ...
    num2str(h2)]);
disp(['p-value is ' num2str(p2)]);
disp(['t-test result between kick-pseudo and throw-pseudo is ' ...
    num2str(h3) ]);
disp(['p-value is ' num2str(p3)]);