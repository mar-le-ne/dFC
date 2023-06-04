
N_windows = 125;
Q_all = [];
N_pat = 50;
Ci_all = zeros(N_windows,N_pat);
M_CN = [];
Ccs = cell(N_pat,1);
group = "AD";

%% Get maximized modularity (Q) and optimal community structure (Ci)

for pat = 1:N_pat
Ccs{pat} = readmatrix(".\outputs\Ccs_100_corr\"+group+"\Ccs_"+string(pat-1)+".csv");
[Ci,Q]=modularity_und(Ccs{pat},1);
Ci_all(:,pat) = Ci;
Q_all = [Q_all; Q];
M_CN(pat) = numel(unique(Ci));
end

%% save
writematrix(Ci_all, './outputs/modularity/Ci_all_'+group+'.csv')
writematrix(Q_all, './outputs/modularity/Q_all_'+group+'.csv')

%% SIGNIFICANCE

% [h, p, ci, stats] = ttest2(M_CN, M_AD)
tbl = table
tbl.CN = [M_CN,nan]'
tbl.AD = M_AD'
writetable(tbl,'./outputs/results.csv')

%% visualize
figure
histogram(M)
title("N connectivity states vs N subjects ("+group+")")

%% count states

N_states = 0;
for i=1:N_pat
    N_states = N_states + max(Ci_all(:,i));
end

%% modularity Scsst

csst = readmatrix(".\outputs\connect_state\Ccsst.csv");
[Ci,Q]=modularity_und(csst,1);
writematrix(Ci, './outputs/modularity/Ci_csst.csv')

%% box-plot on states

C_CN = [];
Eff_CN = [];
for i= 1:182
    % CLUSTERING COEF
    ST_CN = readmatrix(".\outputs\connect_state\CN\ST_"+string(i-1)+".csv");
    C=sum(clustering_coef_wu(ST_CN));
    C_CN = [C_CN; C];

    % GLOBAL EFFICIENCY
    Eff = efficiency_wei(ST_CN, 0);
    Eff_CN = [Eff_CN, Eff];
end
writematrix(C_CN/100, './outputs/clustering/first_level_states_C_CN.csv')
writematrix(Eff_CN', './outputs/efficiency/first_level_states_Eff_CN.csv')

C_AD = [];
Eff_AD = [];
for i= 1:166
    ST_AD = readmatrix(".\outputs\connect_state\AD\ST_"+string(i-1)+".csv");
    C=sum(clustering_coef_wu(ST_AD));
    C_AD = [C_AD; C];

    % GLOBAL EFFICIENCY
    Eff = efficiency_wei(ST_AD, 0);
    Eff_AD = [Eff_AD, Eff];
end
writematrix(C_AD/100, './outputs/clustering/first_level_states_C_AD.csv')
writematrix(Eff_AD', './outputs/efficiency/first_level_states_Eff_AD.csv')


%% box-plot on states - 

