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


state = "matlab script done"