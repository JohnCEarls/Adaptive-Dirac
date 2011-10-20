function [train_performance,results] = new_eta_loocv(gs_structs,groups,k_max)
% k_max is the number of top accuracy/confidence networks to consider

gs_train = gs_structs.train;
gs_test = gs_structs.test;

X_train = gs_train.X;
X_test = gs_test.X;
groups_train = groups.train(:);
groups_test = groups.test(:);
g_gs_idx_train = gs_train.g_gs_idx;
g_gs_idx_test = gs_test.g_gs_idx;

keep_m = find(sum(g_gs_idx_train > 0, 2) > 2);
g_gs_idx_train = g_gs_idx_train(keep_m,:);

if keep_m ~= find(sum(g_gs_idx_test > 0, 2) > 2)
    disp '1. INDICES DO NOT MATCH UP BETWEEN TRAIN AND TEST';
    return;
end
g_gs_idx_test = g_gs_idx_test(keep_m,:);
if keep_m ~= find(sum(g_gs_idx_test > 0, 2) > 2)
    disp '2. INDICES DO NOT MATCH UP BETWEEN TRAIN AND TEST';
    return;
end

[G_train,N_train] = size(X_train);
[G_test, N_test] = size(X_test);
N_1_train = sum(groups_train);
N_2_train = N_train - N_1_train;
N_1_test = sum(groups_test);
N_2_test = N_test - N_1_test;

p_1 = 0.5; p_2 = 0.5;
% p_2 = N_1/N; p_2 = N_2/N;

F_train = X_train; F_test = X_test;
Y = groups_train;


%---- TRAIN ----%

[R_1,R_2,T_train] = rank_matching(F_train,g_gs_idx_train,'train',Y);
Delta = R_1 - R_2;
% Delta(n, s) gives the confidence for sample s by network n (+ or -)
[R_1_new,R_2_new] = rank_matching(F_test,g_gs_idx_test,'test',T_train);
Delta_new = R_1_new - R_2_new;

% Y_hat(n, s) gives the prediction for sample s by network n (+ or -)
Y_hat = double(Delta > 0);
Y_hat(Delta == 0) = 0.5;
eta = (sum(Y_hat(:,Y),2)/N_1_train)*p_1+(sum(1-Y_hat(:,~Y),2)/N_2_train)*p_2;
[eta,m] = sort(eta,'descend');

% Gamma(n) is the confidence score for network n over all samples
% for either class + or -, the closer to +/- 1  ---> more confident
gamma_1 = sum(Delta(m,Y),2)/N_1_train;
gamma_2 = sum(Delta(m,~Y),2)/N_2_train;
% rho is the total confidence for both classes for a given network
rho = abs(gamma_1 - gamma_2);

theta = zeros(k_max,1); u = 1;
% if there are any ties in eta (accuracy) sort by their rho score (confidence)
while u <= k_max
    eta_u = eta(1);
    tie = eta == eta_u;
    [rho_u,m_u] = sort(rho(tie),'descend');
    theta(u:u+numel(m_u)-1) = m(m_u);
    m(tie) = []; eta(tie) = []; rho(tie) = [];
    u = u+numel(m_u);
end
theta = theta(1:k_max);
% theta gives the index into Delta_new of the best network 
% as judged by apparent accuracy and confidence (eta and rho)

h_u = Y_hat(theta(1),:);
eta_opt = (sum(h_u(:,Y),2)/N_1_train)*p_1+(sum(1-h_u(:,~Y),2)/N_2_train)*p_2;
k_opt = 1;
for k = 3:2:k_max
    h_u = mode(Y_hat(theta(1:k),:));
    eta = (sum(h_u(:,Y),2)/N_1_train)*p_1+(sum(1-h_u(:,~Y),2)/N_2_train)*p_2;
    if eta > eta_opt
        k_opt = k;
        eta_opt = eta;
    end
end
k = k_opt;
% train performance(i) is the apparent accuracy on the training set i
train_performance = eta_opt;

%---- TEST ----%

Y_hat_new = double(Delta_new(theta, :) > 0);
Y_hat_new(Delta_new(theta, :) == 0) = 0.5;
h = Y_hat_new(1,:);
% if considering multiple networks, have them vote
if k_max > 1
h_k = mode(Y_hat_new(1:k, :));
end

% h(t) contains the prediction made by the best network on test sample t
TP = sum(h(groups_test));
FN = sum(1-h(groups_test));
FP = sum(h(~groups_test));
TN = sum(1-h(~groups_test));

accuracy = (TP/N_1_test)*p_1 + (TN/N_2_test)*p_2;
results(1,:) = [TP FN FP TN accuracy];

if k_max > 1
k_TP = sum(h_k(groups_test));
k_FN = sum(1-h_k(groups_test));
k_FP = sum(h_k(~groups_test));
k_TN = sum(1-h_k(~groups_test));

k_accuracy = (k_TP/N_1_test)*p_1 + (k_TN/N_2_test)*p_2;
results(2,:) = [k_TP k_FN k_FP k_TN k_accuracy];
end
