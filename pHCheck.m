

%%
i = 5;
for j=1:6
[fitresult, gof] = sigmoidFit2(time, ph6(:,j));
 A(i,j) = fitresult.A;
 T0(i,j) = fitresult.T0;
 tau(i,j) = fitresult.tau;
 C(i,j) = fitresult.C;
end
%%
Tl = T0-2*tau;