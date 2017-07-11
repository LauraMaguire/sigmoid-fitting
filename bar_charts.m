%% Make bar charts of the averaged parameters

% Show GuHCl rep? 1=yes, 0=no
GuHCl = 1;

x=length(A1label);
if GuHCl==0
    x=length(A1label)-1;
end

close all
figure
subplot(2,2,1)
bar(A1);
hold all
set(gca, 'XTick', 1:length(A1label(1:x)), 'XTickLabel', A1label(1:x));
errorbar(A1,A1err,'k.')
ylabel('Amplitude (AU)')
title('Amplitude')


subplot(2,2,2)
bar(k1);
hold all
set(gca, 'XTick', 1:length(A1label(1:x)), 'XTickLabel', A1label(1:x));
errorbar(k1,k1err,'k.')
title('Time constant')
ylabel('Time constant (1/hr)')

subplot(2,2,3)
bar(T1);
hold all
set(gca, 'XTick', 1:length(A1label(1:x)), 'XTickLabel', A1label(1:x));
errorbar(T1,T1err,'k.')
ylabel('Half-time (hr)')
title('Half-time')
  
subplot(2,2,4)
bar(l1);
hold all
set(gca, 'XTick', 1:length(A1label(1:x)), 'XTickLabel', A1label(1:x));
errorbar(l1,l1err,'k.')
ylabel('Lag time (hr)')
title('Lag time')

clear x

%% Make bar charts of the averaged parameters

% Show GuHCl rep? 1=yes, 0=no

close all
figure
subplot(2,2,1)
bar(A2);
hold all
set(gca, 'XTick', 1:length(label2), 'XTickLabel', label2);
errorbar(A2,A2err,'k.')
ylabel('Amplitude (AU)')
title('PEG Amplitude')


subplot(2,2,2)
bar(k2);
hold all
set(gca, 'XTick', 1:length(label2), 'XTickLabel', label2);
errorbar(k2,k2err,'k.')
title('PEG Time constant')
ylabel('Time constant (1/hr)')

subplot(2,2,3)
bar(T2);
hold all
set(gca, 'XTick', 1:length(label2), 'XTickLabel', label2);
errorbar(T2,T2err,'k.')
ylabel('Half-time (hr)')
title('PEG Half-time')
  
subplot(2,2,4)
bar(l2);
hold all
set(gca, 'XTick', 1:length(label2), 'XTickLabel', label2);
errorbar(l2,l2err,'k.')
ylabel('Lag time (hr)')
title('PEG Lag time')

clear x

%% Make bar charts of the averaged parameters

% Show GuHCl rep? 1=yes, 0=no

close all
figure
subplot(2,2,1)
bar(A3);
hold all
set(gca, 'XTick', 1:length(label2), 'XTickLabel', label2);
errorbar(A3,A3err,'k.')
ylabel('Amplitude (AU)')
title('PVP Amplitude')


subplot(2,2,2)
bar(k3);
hold all
set(gca, 'XTick', 1:length(label2), 'XTickLabel', label2);
errorbar(k3,k3err,'k.')
title('PVP Time constant')
ylabel('Time constant (1/hr)')

subplot(2,2,3)
bar(T3);
hold all
set(gca, 'XTick', 1:length(label2), 'XTickLabel', label2);
errorbar(T3,T3err,'k.')
ylabel('Half-time (hr)')
title('PVP Half-time')
  
subplot(2,2,4)
bar(l3);
hold all
set(gca, 'XTick', 1:length(label2), 'XTickLabel', label2);
errorbar(l3,l3err,'k.')
ylabel('Lag time (hr)')
title('PVP Lag time')

clear x