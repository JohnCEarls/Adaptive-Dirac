
np_in_pt = zeros(20,1);
for i = 1:20
np_in_pt(i) = strmatch(mu_R_struct(1).mu_R_2_gs{i},mu_R_struct(1).mu_R_1_gs);
end
np_in_pt_gs = mu_R_struct(1).mu_R_1_gs(np_in_pt);
np_in_pt_mu = mu_R_struct(1).mu_R_1_stats(np_in_pt,4);

np_in_mt = zeros(20,1);
for i = 1:20
np_in_mt(i) = strmatch(mu_R_struct(2).mu_R_2_gs{i},mu_R_struct(2).mu_R_1_gs);
end
np_in_mt_gs = mu_R_struct(2).mu_R_1_gs(np_in_mt);
np_in_mt_mu = mu_R_struct(2).mu_R_1_stats(np_in_mt,4);


pt_in_np = zeros(20,1);
for i = 1:20
pt_in_np(i) = strmatch(mu_R_struct(1).mu_R_1_gs{i},mu_R_struct(1).mu_R_2_gs);
end
pt_in_np_gs = mu_R_struct(1).mu_R_2_gs(pt_in_np);
pt_in_np_mu = mu_R_struct(1).mu_R_2_stats(pt_in_np,4);

pt_in_mt = zeros(20,1);
for i = 1:20
pt_in_mt(i) = strmatch(mu_R_struct(1).mu_R_1_gs{i},mu_R_struct(2).mu_R_1_gs);
end
pt_in_mt_gs = mu_R_struct(2).mu_R_1_gs(pt_in_mt);
pt_in_mt_mu = mu_R_struct(2).mu_R_1_stats(pt_in_mt,4);


mt_in_np = zeros(20,1);
for i = 1:20
mt_in_np(i) = strmatch(mu_R_struct(2).mu_R_1_gs{i},mu_R_struct(1).mu_R_2_gs);
end
mt_in_np_gs = mu_R_struct(1).mu_R_2_gs(mt_in_np);
mt_in_np_mu = mu_R_struct(1).mu_R_2_stats(mt_in_np,4);

mt_in_pt = zeros(20,1);
for i = 1:20
mt_in_pt(i) = strmatch(mu_R_struct(2).mu_R_1_gs{i},mu_R_struct(1).mu_R_1_gs);
end
mt_in_pt_gs = mu_R_struct(1).mu_R_1_gs(mt_in_pt);
mt_in_pt_mu = mu_R_struct(1).mu_R_1_stats(mt_in_pt,4);