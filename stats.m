[h,p]=ttest2(nonzeros(data(b,k,:,:)),nonzeros(data(s,k,:,:))); 
%%
[h,p]=ttest2(nonzeros(data(b,lg,:,:)),nonzeros(data(p13,lg,:,:))); 

%% run t-tests for "standard" conditions
hs = zeros(5,5,4);
probs = zeros(5,5,4);
ind = [1,2,3,6,10];
for pr=1:4
for c1=1:5
    for c2=1:5
        if c2>c1
            [hs(c1,c2,pr),probs(c1,c2,pr)]=ttest2(nonzeros(data(ind(c1),pr,:,:)),...
                nonzeros(data(ind(c2),pr,:,:)));
        end
    end
end
end

%% run t-tests for "standard" conditions
hs2 = zeros(5,5,4);
probs2 = zeros(5,5,4);
ind = [1,2,3,6,10];
for pr=1:4
for c1=1:5
    for c2=1:5
        if c2>c1
            [hs2(c1,c2,pr),probs2(c1,c2,pr)]=ttest2(nonzeros(dataShort(c1,pr,:,:)),...
                nonzeros(dataShort(c2,pr,:,:)));
        end
    end
end
end


%% run t-tests for PEG conditions
hp = zeros(5,5,4);
probp = zeros(5,5,4);
ind = [1 4 5 6 7];
for pr=1:4
for c1=1:5
    for c2=1:5
        if c2>c1
            [hp(c1,c2,pr),probp(c1,c2,pr)]=ttest2(nonzeros(data(ind(c1),pr,:,:)),...
                nonzeros(data(ind(c2),pr,:,:)));
        end
    end
end
end

%% run t-tests for PVP conditions
hv = zeros(5,5,4);
probv = zeros(5,5,4);
ind = [1 8 9 10 11];
for pr=1:4
for c1=1:5
    for c2=1:5
        if c2>c1
            [hv(c1,c2,pr),probv(c1,c2,pr)]=ttest2(nonzeros(data(ind(c1),pr,:,:)),...
                nonzeros(data(ind(c2),pr,:,:)));
        end
    end
end
end

%% run an ANOVA for standard conditions
ANOVAmatrixK = NaN(50,5);

for c=1:5
    col = nonzeros(dataShort(c,k,:,:));
    ANOVAmatrixK(1:length(col),c) = col;
end

ANOVAmatrixL = NaN(50,5);

for c=1:5
    col = nonzeros(dataShort(c,lg,:,:));
    ANOVAmatrixL(1:length(col),c) = col;
end

%%
[p,tbl,stats] = anova1(ANOVAmatrixK);