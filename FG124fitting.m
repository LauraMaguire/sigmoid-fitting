
% Full file path of csv file
csv = 'C:\Users\Laura\Google Drive\Team FRET Protocols\Data\FG124 aggregation timecourses\160525_timeCourse\160525_LKM_FG124TimeCourse.csv';
M = csvread(csv,1,0);

%%
% remove three points which significantly alter a fit (third time course)
M(10,22) = NaN;
M(11,22) = NaN;
M(47,28) = NaN;

% %points to remove for second time course
% M(23,24) = NaN;
% M(24,24) = NaN;
% M(25,24) = NaN;
% M(26,26) = NaN;
% M(24,27) = NaN;
% 
% % points maybe to to remove for second time course
% M(22,26) = NaN;
% M(23,26) = NaN;
% M(24,26) = NaN;

% % points to remove for the first time course
% M(17,27) = NaN;
% M(18,26) = NaN;
% M(19,26) = NaN;
% M(20,26) = NaN;
% 
% % points to maybe remove for the first time course
% M(16,26) = NaN;
% M(21,26) = NaN;

%%
time = M(:,1).';
label = {'PEG' 'PVP' 'BSA' 'BUF' 'LYS' 'GDH','PH5.7','PH7.5'};
data = zeros(6,6,size(M,1));
data(1,:,:) = M(:,3:8).';
data(2,:,:) = M(:,10:15).';
data(3,:,:) = M(:,17:22).';
data(4,:,:) = M(:,24:29).';
data(5,:,:) = M(:,31:36).';
data(6,:,:) = M(:,38:43).';
data(7,:,:) = M(:,45:50).';
data(8,:,:) = M(:,52:57).';

%%
A = zeros(size(data,1),size(data,2));
T = zeros(size(data,1),size(data,2));
k = zeros(size(data,1),size(data,2));
GOF = zeros(size(data,1),size(data,2),5);
%%
close all
for i=5:size(data,1)-1 % number of conditions
    for j=1:size(data,2) % number of reps
        [fitresult, gof] = sigmoidFit(time(1:49), data(i,j,1:49));
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
plot(GOF(2,:,5),'bo'); %PVP
plot(GOF(3,:,5),'go'); %BSA
plot(GOF(4,:,5),'ro'); %BUF
legend( label{2:4}, 'Location', 'west' );

%% calculating lag time
lag = zeros(4,6);
for i=2:size(data,1)-2 % number of conditions
    for j=1:size(data,2) % number of reps
        lag(i,j) = T(i,j) - 2/k(i,j);
    end
end

%% run for second time course only!
A(3,4) = NaN;
k(3,4) = NaN;
T(3,4) = NaN;
lag(3,4) = NaN;

%%
close all

figure
meanAmp = nanmean(A,2);
errAmp = nanstd(A,0,2);
errorbar(meanAmp(1:4),errAmp(1:4),'ko')
title('Amp');

figure
meanK = nanmean(k,2);
errK = nanstd(k,0,2);
errorbar(meanK(1:4),errK(1:4),'bo')
title('k');
hold on
%errorbar(mean(goodK,2),std(goodK,0,2), 'ro')
hold off

figure
meanT = nanmean(T,2);
errT = nanstd(T,0,2);
errorbar(meanT(1:4),errT(1:4),'ro')
title('half-life');
hold on
%errorbar(mean(goodT,2),std(goodT,0,2), 'ro')
hold off

figure
meanLag = nanmean(lag,2);
errLag = nanstd(lag,0,2);
errorbar(meanLag(1:4),errLag(1:4),'ko')
title('Lag time');

%%
plot(k(1,1:4))
hold all
plot(k(2,1:4))
plot(k(3,1:4))

%% take a moving average (mean filtering)

windowSize = 3;
b = (1/windowSize)*ones(1,windowSize);
a = 1;
smoothData = data;
for i=1:size(data,1) % number of conditions
    for j=1:size(data,2) % number of reps
        filtered = filter(b,a,data(i,j,:));
        smoothData(i,j,windowSize:end) = filtered(windowSize:end);
    end
end
clear windowSize b a filtered

%% median filtering
smoothData = data;
for i=1:size(data,1) % number of conditions
    for j=1:size(data,2) % number of reps
        filtered = medfilt1(data(i,j,:),3);
        smoothData(i,j,1:end) = filtered(1:end);
    end
end
clear filtered

%% params
params = [A k T];
csvwrite('C:\Users\Laura\Google Drive\Team FRET Protocols\Data\FG124 aggregation timecourses\160314_timeCourse\params.csv',params);
