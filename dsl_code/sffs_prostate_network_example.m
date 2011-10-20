
% prostate lc-sffs-DIRAC

clear

% important note: indexes into gs_seed, gs_sffs, eta_seed, eta_sffs are all
% different -> you must look at the gs_id name to map rows to each other ATM
% this isn't so bad so long as few networks are considered at a time (top% 5)

%% primary vs. normal (free)
d = 1;
load Datasets\'Prostate (GDS2545)'\prostate_GDS2545_p_nf
load hprd_lc_gs_defs


% these are networks with middling size ~5-50
%{
selected_networks ={};
selected_networks = [selected_networks; hprd_lc_gs_defs(168,:)];
selected_networks = [selected_networks; hprd_lc_gs_defs(185,:)];
selected_networks = [selected_networks; hprd_lc_gs_defs(84,:)];
selected_networks = [selected_networks; hprd_lc_gs_defs(61,:)];
selected_networks = [selected_networks; hprd_lc_gs_defs(184,:)];
selected_networks = [selected_networks; hprd_lc_gs_defs(516,:)];
selected_networks = [selected_networks; hprd_lc_gs_defs(550,:)];
selected_networks = [selected_networks; hprd_lc_gs_defs(733,:)];
selected_networks = [selected_networks; hprd_lc_gs_defs(121,:)];
selected_networks = [selected_networks; hprd_lc_gs_defs(290,:)];
selected_networks = [selected_networks; hprd_lc_gs_defs(1,:)];
hprd_lc_gs_defs = selected_networks;
%}

if not(isdir('dsl_results'))
    mkdir dsl_results
end
if not(isdir('dsl_results/prostate'))
    mkdir dsl_results/prostate
end

if sum(sum(isnan(E_log10_QN)))
    notnan = find(sum(isnan(E_log10_QN),2)==0);
    names = names(notnan);
    E_log10_QN = E_log10_QN(notnan,:);
end

cd 'Core Functions'

test_fraction = 0.25;
[E_log10_QN_train,groups_train,E_log10_QN_test,groups_test] = ...
    split_sample_data(E_log10_QN, groups, test_fraction);

gs_struct_train = gs_match_id(E_log10_QN_train,names_new,hprd_lc_gs_defs);

[mu_R_1_gs,mu_R_1_stats,mu_R_2_gs,mu_R_2_stats] = mu_R(gs_struct_train,groups_train);
mu_R_struct(d).name = 'primary_normal';
mu_R_struct(d).mu_R_1_gs = mu_R_1_gs;
mu_R_struct(d).mu_R_1_stats = mu_R_1_stats;
mu_R_struct(d).mu_R_2_gs = mu_R_2_gs;
mu_R_struct(d).mu_R_2_stats = mu_R_2_stats;
save ../dsl_results/prostate/lc_mu_R_struct_prostate mu_R_struct

[mu_R_1,mu_R_2,mu_diff_gs,mu_diff_stats] = mu_diff(gs_struct_train,groups_train,1);
mu_diff_struct(d).name = 'primary_normal';
mu_diff_struct(d).gs = mu_diff_gs;
mu_diff_struct(d).mu_R = [mu_R_1,mu_R_2];
mu_diff_struct(d).mu_diff = mu_diff_stats;
save ../dsl_results/prostate/lc_mu_diff_struct_prostate mu_diff_struct

[eta_gs,eta_stats] = eta_fdr(gs_struct_train,groups_train,1);
% sffs procedure
[trace, final_networks, seeds] = ...
    sffs(eta_gs,E_log10_QN_train, names_new, groups_train,10,5,1);
sffs_eta_trace = {trace};

gs_seeds(d) = gs_match_id(E_log10_QN_test,names_new,seeds);
[eta_gs_seeds,eta_stats_seeds] = eta_fdr(gs_seeds(d),groups_test,100);
[classifiers_seeds,results_seeds] = eta_loocv(gs_seeds(d),groups_test,1);

gs_sffs(d) = gs_match_id(E_log10_QN_test,names_new,final_networks);
[eta_gs_sffs,eta_stats_sffs] = eta_fdr(gs_sffs(d),groups_test,100);
[classifiers_sffs,results_sffs] = eta_loocv(gs_sffs(d),groups_test,1);

eta_struct_seeds(d).name = 'primary_normal';
eta_struct_seeds(d).gs = eta_gs_seeds;
eta_struct_seeds(d).stats = eta_stats_seeds;
eta_struct_seeds(d).accuracy = results_seeds(5);
save ../dsl_results/prostate/lc_eta_struct_seeds_prostate eta_struct_seeds
save ../dsl_results/prostate/lc_gs_struct_seeds_prostate gs_seeds

eta_struct_sffs(d).name = 'primary_normal';
eta_struct_sffs(d).gs = eta_gs_sffs;
eta_struct_sffs(d).stats = eta_stats_sffs;
eta_struct_sffs(d).accuracy = results_sffs(5);
save ../dsl_results/prostate/lc_eta_struct_sffs_prostate eta_struct_sffs
save ../dsl_results/prostate/lc_gs_struct_sffs_prostate gs_sffs
save ../dsl_results/prostate/sffs_eta_trace_prostate sffs_eta_trace
clear
clc
cd ..

%% metastatic vs. normal (free)
d = 2;
load Datasets\'Prostate (GDS2545)'\prostate_GDS2545_m_nf
load hprd_lc_gs_defs
load ./dsl_results/prostate/lc_mu_R_struct_prostate
load ./dsl_results/prostate/lc_mu_diff_struct_prostate
load ./dsl_results/prostate/lc_eta_struct_seeds_prostate
load ./dsl_results/prostate/lc_eta_struct_sffs_prostate
load ./dsl_results/prostate/lc_gs_struct_seeds_prostate
load ./dsl_results/prostate/lc_gs_struct_sffs_prostate
load ./dsl_results/prostate/sffs_eta_trace_prostate

if sum(sum(isnan(E_log10_QN)))
    notnan = find(sum(isnan(E_log10_QN),2)==0);
    names = names(notnan);
    E_log10_QN = E_log10_QN(notnan,:);
end

cd 'Core Functions'

test_fraction = 0.25;
[E_log10_QN_train,groups_train,E_log10_QN_test,groups_test] = ...
    split_sample_data(E_log10_QN, groups, test_fraction);

gs_struct = gs_match_id(E_log10_QN,names_new,hprd_lc_gs_defs);

[mu_R_1_gs,mu_R_1_stats,mu_R_2_gs,mu_R_2_stats] = mu_R(gs_struct,groups);
mu_R_struct(d).name = 'metastatic_normal';
mu_R_struct(d).mu_R_1_gs = mu_R_1_gs;
mu_R_struct(d).mu_R_1_stats = mu_R_1_stats;
mu_R_struct(d).mu_R_2_gs = mu_R_2_gs;
mu_R_struct(d).mu_R_2_stats = mu_R_2_stats;
save ../dsl_results/prostate/lc_mu_R_struct_prostate mu_R_struct

[mu_R_1,mu_R_2,mu_diff_gs,mu_diff_stats] = mu_diff(gs_struct,groups,1);
mu_diff_struct(d).name = 'metastatic_normal';
mu_diff_struct(d).gs = mu_diff_gs;
mu_diff_struct(d).mu_R = [mu_R_1,mu_R_2];
mu_diff_struct(d).mu_diff = mu_diff_stats;
save ../dsl_results/prostate/lc_mu_diff_struct_prostate mu_diff_struct

[eta_gs,eta_stats] = eta_fdr(gs_struct,groups,1);
% sffs procedure
[trace, final_networks, seeds] = sffs(eta_gs,E_log10_QN, names_new, groups,5,11,1);
sffs_eta_trace = [sffs_eta_trace; trace];

gs_seeds(d) = gs_match_id(E_log10_QN,names_new,seeds);
[eta_gs_seeds,eta_stats_seeds] = eta_fdr(gs_seeds(d),groups,100);
[classifiers_seeds,results_seeds] = eta_loocv(gs_seeds(d),groups,1);

gs_sffs(d) = gs_match_id(E_log10_QN,names_new,final_networks);
[eta_gs_sffs,eta_stats_sffs] = eta_fdr(gs_sffs(d),groups,100);
[classifiers_sffs,results_sffs] = eta_loocv(gs_sffs(d),groups,1);

eta_struct_seeds(d).name = 'metastatic_normal';
eta_struct_seeds(d).gs = eta_gs_seeds;
eta_struct_seeds(d).stats = eta_stats_seeds;
eta_struct_seeds(d).accuracy = results_seeds(5);
save ../dsl_results/prostate/lc_eta_struct_seeds_prostate eta_struct_seeds
save ../dsl_results/prostate/lc_gs_struct_seeds_prostate gs_seeds

eta_struct_sffs(d).name = 'metastatic_normal';
eta_struct_sffs(d).gs = eta_gs_sffs;
eta_struct_sffs(d).stats = eta_stats_sffs;
eta_struct_sffs(d).accuracy = results_sffs(5);
save ../dsl_results/prostate/lc_eta_struct_sffs_prostate eta_struct_sffs
save ../dsl_results/prostate/lc_gs_struct_sffs_prostate gs_sffs
save ../dsl_results/prostate/sffs_eta_trace_prostate sffs_eta_trace
clear
clc
cd ..

%% metastatic vs. primary
d = 3;
load Datasets\'Prostate (GDS2545)'\prostate_GDS2545_m_p
load hprd_lc_gs_defs
load ./dsl_results/prostate/lc_mu_R_struct_prostate
load ./dsl_results/prostate/lc_mu_diff_struct_prostate
load ./dsl_results/prostate/lc_eta_struct_seeds_prostate
load ./dsl_results/prostate/lc_eta_struct_sffs_prostate
load ./dsl_results/prostate/lc_gs_struct_seeds_prostate
load ./dsl_results/prostate/lc_gs_struct_sffs_prostate
load ./dsl_results/prostate/sffs_eta_trace_prostate

if sum(sum(isnan(E_log10_QN)))
    notnan = find(sum(isnan(E_log10_QN),2)==0);
    names = names(notnan);
    E_log10_QN = E_log10_QN(notnan,:);
end

cd 'Core Functions'

test_fraction = 0.25;
[E_log10_QN_train,groups_train,E_log10_QN_test,groups_test] = ...
    split_sample_data(E_log10_QN, groups, test_fraction);

gs_struct = gs_match_id(E_log10_QN,names_new,hprd_lc_gs_defs);

[mu_R_1_gs,mu_R_1_stats,mu_R_2_gs,mu_R_2_stats] = mu_R(gs_struct,groups);
mu_R_struct(d).name = 'metastatic_primary';
mu_R_struct(d).mu_R_1_gs = mu_R_1_gs;
mu_R_struct(d).mu_R_1_stats = mu_R_1_stats;
mu_R_struct(d).mu_R_2_gs = mu_R_2_gs;
mu_R_struct(d).mu_R_2_stats = mu_R_2_stats;
save ../dsl_results/prostate/lc_mu_R_struct_prostate mu_R_struct

[mu_R_1,mu_R_2,mu_diff_gs,mu_diff_stats] = mu_diff(gs_struct,groups,1);
mu_diff_struct(d).name = 'metastatic_primary';
mu_diff_struct(d).gs = mu_diff_gs;
mu_diff_struct(d).mu_R = [mu_R_1,mu_R_2];
mu_diff_struct(d).mu_diff = mu_diff_stats;
save ../dsl_results/prostate/lc_mu_diff_struct_prostate mu_diff_struct

[eta_gs,eta_stats] = eta_fdr(gs_struct,groups,1);
% sffs procedure
[trace, final_networks, seeds] = sffs(eta_gs,E_log10_QN, names_new, groups,5,11,1);
sffs_eta_trace = [sffs_eta_trace; trace];

gs_seeds(d) = gs_match_id(E_log10_QN,names_new,seeds);
[eta_gs_seeds,eta_stats_seeds] = eta_fdr(gs_seeds(d),groups,100);
[classifiers_seeds,results_seeds] = eta_loocv(gs_seeds(d),groups,1);

gs_sffs(d) = gs_match_id(E_log10_QN,names_new,final_networks);
[eta_gs_sffs,eta_stats_sffs] = eta_fdr(gs_sffs(d),groups,100);
[classifiers_sffs,results_sffs] = eta_loocv(gs_sffs(d),groups,1);

eta_struct_seeds(d).name = 'metastatic_primary';
eta_struct_seeds(d).gs = eta_gs_seeds;
eta_struct_seeds(d).stats = eta_stats_seeds;
eta_struct_seeds(d).accuracy = results_seeds(5);
save ../dsl_results/prostate/lc_eta_struct_seeds_prostate eta_struct_seeds
save ../dsl_results/prostate/lc_gs_struct_seeds_prostate gs_seeds

eta_struct_sffs(d).name = 'metastatic_primary';
eta_struct_sffs(d).gs = eta_gs_sffs;
eta_struct_sffs(d).stats = eta_stats_sffs;
eta_struct_sffs(d).accuracy = results_sffs(5);
save ../dsl_results/prostate/lc_eta_struct_sffs_prostate eta_struct_sffs
save ../dsl_results/prostate/lc_gs_struct_sffs_prostate gs_sffs
save ../dsl_results/prostate/sffs_eta_trace_prostate sffs_eta_trace
clear
clc
cd ..
