%% modularity Scsst

csst = readmatrix(".\outputs\connect_state\Ccsst.csv");
[Ci,Q]=modularity_und(csst,1);
writematrix(Ci, './outputs/modularity/Ci_csst.csv')

disp("matlab script done")