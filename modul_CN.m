N_windows = 125;
Q_all = [];
N_pat = 49;
Ci_all = zeros(N_windows,N_pat);
M = [];
Ccs = cell(N_pat,1);
group = "CN";

%% Get maximized modularity (Q) and optimal community structure (Ci)

for pat = 1:N_pat
Ccs{pat} = readmatrix(".\outputs\Ccs_100_corr\"+group+"\Ccs_"+string(pat-1)+".csv");
[Ci,Q]=modularity_und(Ccs{pat},1);
Ci_all(:,pat) = Ci;
Q_all = [Q_all; Q];
M(pat) = numel(unique(Ci));
end

%% save
writematrix(Ci_all, './outputs/modularity/Ci_all_'+group+'.csv')
writematrix(Q_all, './outputs/modularity/Q_all_'+group+'.csv')
writematrix(M, './outputs/modularity/M_'+group+'.csv')

state = "matlab script done"

% if the matrix inserted is C and not S (+1/2), the modularity is much
% bigger