function [fitresult, gof] = sigmoidFit(time, rep)
% This script fits data to a sigmoid curve with three parameters.  It was
% auto-generated by MATLAB's curve fitting app.
%CREATEFIT(TIME,REP1)
%  Create a fit.
%
%  Data for 'sigmoid' fit:
%      X Input : time
%      Y Output: rep1
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 12-May-2016 16:28:22


%% Fit: 'sigmoid'.
[xData, yData] = prepareCurveData( time, rep );

% Set up fittype and options.
% ft = fittype( '1+A/(1+exp(-k*(t-T)))', 'independent', 't', 'dependent','y' );
ft = fittype( 'C+A/(1+exp(-(t-T0)/tau))', 'independent', 't', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
% opts.Lower = [0 0 0];
% opts.StartPoint = [0.171186687811562 0.27692298496089 0.0318328463774207];
opts.Lower = [0 -Inf -Inf 0]; % A C T0 tau
opts.Upper = [Inf Inf Inf Inf];
opts.StartPoint = [100 1 10 0.1];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

% Create a figure for the plots.
figure( 'Name', 'sigmoid' );

% Plot fit with data.
subplot( 2, 1, 1 );
h = plot( fitresult, xData, yData );
legend( h, 'Data', 'Fit', 'Location', 'SouthEast' );
% Label axes
xlabel time
ylabel rep1
grid on

% Plot residuals.
subplot( 2, 1, 2 );
h = plot( fitresult, xData, yData, 'residuals' );
legend( h, 'Residuals', 'Zero Line', 'Location', 'NorthEast' );
% Label axes
xlabel time
ylabel rep1
grid on


