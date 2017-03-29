
% Full file path of csv file
csv = 'C:\Users\Laura\Google Drive\Hough Lab\Nuclear Pore Team\Data\FG124 aggregation timecourses\170328_LKM_FG124TimeCourseAnalysis.csv';
M = csvread(csv);

%%
% remove messed-up points
M(1,14) = NaN;
M(1,15) = NaN;
M(1,16) = NaN;
M(1,17) = NaN;

M(1,26) = NaN;
M(1,27) = NaN;
M(1,28) = NaN;
M(1,29) = NaN;

%%
time = M(:,1).';
label = {'Buffer' 'GuHCl' '25% PEG' '20% PEG' '13% PEG' '5% PEG' '25% PVP' '20% PVP' '13% PVP' '5% PVP'};
data = zeros(10,4,size(M,1));
data(1,:,:) = M(:,2:5).';
data(2,:,:) = M(:,6:9).';
data(3,:,:) = M(:,10:13).';
data(4,:,:) = M(:,14:17).';
data(5,:,:) = M(:,18:21).';
data(6,:,:) = M(:,22:25).';
data(7,:,:) = M(:,26:29).';
data(8,:,:) = M(:,30:33).';
data(9,:,:) = M(:,34:37).';
data(10,:,:) = M(:,38:41).';

%% 5-pt moving average for all blanks
smoothBlanks = zeros(size(data,1),size(data,3));
for i=1:size(data,1)
    smoothBlanks(i,:) = smooth(data(i,1,:));
end

%% mean blanks after a cut-off time
cutoff = 25;
meanBlanks = zeros(1,size(data,1));
for i=1:size(data,1)
    meanBlanks(i) = mean(data(i,1,cutoff:end));
end

%%
A = zeros(size(data,1),size(data,2));
T = zeros(size(data,1),size(data,2));
k = zeros(size(data,1),size(data,2));
GOF = zeros(size(data,1),size(data,2),5);
%%
close all
for i=7%size(data,1) % number of conditions
    for j=2:size(data,2) % number of reps
        [fitresult, gof] = sigmoidFit(time(4:end), data(i,j,4:end)./smoothBlanks(i));
        A(i,j) = fitresult.A;
        T(i,j) = fitresult.T;
        k(i,j) = fitresult.k;
        GOF(i,j,1) = gof.sse;
        GOF(i,j,2) = gof.rsquare;
        GOF(i,j,3) = gof.dfe;
        GOF(i,j,4) = gof.adjrsquare;
        GOF(i,j,5) = gof.rmse;
    end
end
clear fitresult gof

%% individual fitting

[fitresult, gof] = sigmoidFit(time(1:49), data(5,4,1:49));

%%
for i=1:length(time)
    fit(i) = 1+A(5,4)/(1+exp(-1*k(5,4)*(time(i)-T(5,4))));
    expResult(i) = data(5,4,i)
end
plot(time,fit,'r','LineWidth',3);
hold on
plot(time, expResult,'ko')
title('LYS4 4/28 (bad fit)')
xlabel('Time (hr)');
ylabel('Normed intensity');

%%
%close all
%3,4 is bad in timecourse2

figure
%plot(GOF(1,:,5),'ko'); %PEG
hold all
for i=1:10
    plot(GOF(i,2:end,5));
end
% plot(GOF(2,2:end,5),'bo'); %PVP
% plot(GOF(3,:,5),'go'); %BSA
% plot(GOF(4,:,5),'ro'); %BUF
% legend( label{2:4}, 'Location', 'west' );

%% calculating lag time
lag = zeros(size(data,1),size(data,2));
for i=1:size(data,1) % number of conditions
    for j=2:size(data,2) % number of reps
        lag(i,j) = T(i,j) - 2/k(i,j);
    end
end

%%
close all
figure
meanAmp = nanmean(A([1 3 4 5 6 7 8 9 10],2:end),2);
errAmp = nanstd(A([1 3 4 5 6 7 8 9 10],2:end),0,2);
bar(meanAmp);
hold all
set(gca, 'XTick', 1:9, 'XTickLabel', label([1 3 4 5 6 7 8 9 10]));
errorbar(meanAmp,errAmp,'k.')
ylabel('Amplitude (AU)')
title('Amplitude')
   
figure
meanK = nanmean(k([1 3 4 5 6 7 8 9 10],2:end),2);
errK = nanstd(k([1 3 4 5 6 7 8 9 10],2:end),0,2);
bar(meanK);
hold all
set(gca, 'XTick', 1:9, 'XTickLabel', label([1 3 4 5 6 7 8 9 10]));
errorbar(meanK,errK,'k.')
title('k')
ylabel('k (1/hr)')
   
figure
meanT = nanmean(T([1 3 4 5 6 7 8 9 10],2:end),2);
errT = nanstd(T([1 3 4 5 6 7 8 9 10],2:end),0,2);
bar(meanT);
hold all
set(gca, 'XTick', 1:9, 'XTickLabel', label([1 3 4 5 6 7 8 9 10]));
errorbar(meanT,errT,'k.')
ylabel('T (hr)')
title('T')
  
figure
meanlag = nanmean(lag([1 3 4 5 6 7 8 9 10],2:end),2);
errlag = nanstd(lag([1 3 4 5 6 7 8 9 10],2:end),0,2);
bar(meanlag);
hold all
set(gca, 'XTick', 1:9, 'XTickLabel', label([1 3 4 5 6 7 8 9 10]));
errorbar(meanlag,errlag,'k.')
ylabel('Lag time (hr)')
title('Lag time')

%%

%%
% close all
% 
% figure
% meanAmp = nanmean(A(:,2:end),2);
% errAmp = nanstd(A(:,2:end),0,2);
% errorbar(meanAmp,errAmp,'ko')
% title('Amp');
% 
% figure
% meanK = nanmean(k(:,2:end),2);
% errK = nanstd(k(:,2:end),0,2);
% errorbar(meanK,errK,'bo')
% title('k');
% hold on
% %errorbar(mean(goodK,2),std(goodK,0,2), 'ro')
% hold off
% 
% figure
% meanT = nanmean(T(:,2:end),2);
% errT = nanstd(T(:,2:end),0,2);
% errorbar(meanT,errT,'ro')
% title('half-life');
% hold on
% %errorbar(mean(goodT,2),std(goodT,0,2), 'ro')
% hold off
% 
% figure
% meanLag = nanmean(lag(:,2:end),2);
% errLag = nanstd(lag(:,2:end),0,2);
% errorbar(meanLag,errLag,'ko')
% title('Lag time');
