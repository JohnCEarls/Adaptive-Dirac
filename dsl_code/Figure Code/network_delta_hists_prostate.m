clear
close all

blue = [198,217,241]/255; dark_blue = [31,73,125]/255;
yellow = [255,192,0]/255;
dark_red = [192,0,0]/255;
olive = [119,147,60]/255;
brown = [221,217,195]/255;
dark_gray = [89,89,89]/255;

cd 'Datasets\Prostate (GDS2545)'
load prostate_GDS2545_m_nf
cd ../..
% load prostate_GDS2545_m_nf
% load prostate_GDS2545_m_p
load lc_gs_defs prostate_GDS2545_m_nf_lc_gs_defs
biocarta_gs_defs = prostate_GDS2545_m_nf_lc_gs_defs;

cd Co're Functions'\

if sum(sum(isnan(E_log10_QN)))
    notnan = find(sum(isnan(E_log10_QN),2)==0);
    names = names(notnan);
    E_log10_QN = E_log10_QN(notnan,:);
end

N = numel(groups);
N_1 = sum(groups); N_2 = sum(~groups);

gs_struct = gs_match_id(E_log10_QN,names_new,biocarta_gs_defs);
X = gs_struct.X;
g_gs_idx = gs_struct.g_gs_idx;

[eta_gs,eta_stats] = eta_fdr(gs_struct,groups,1);
m = eta_stats(1,1);

[R_1,R_2] = rank_matching(X,g_gs_idx,'train',groups);

R_1_m_1 = R_1(m,groups);
R_1_m_2 = R_1(m,~groups);
R_2_m_1 = R_2(m,groups);
R_2_m_2 = R_2(m,~groups);

mu_R_1_m = mean(R_1_m_1);
alt_mu_1_m = mean(R_1_m_2);
mu_R_2_m = mean(R_2_m_2);
alt_mu_2_m = mean(R_2_m_1);

x = [0.5:.01:1];
subplot(3,2,1)
hold on

[num,c] = hist(R_1_m_1,N_1);
stem(c(num>0),num(num>0),'.','color',dark_blue,'marker','none','linewidth',2)

[num,c] = hist(R_2_m_1,N_1);
stem(c(num>0),num(num>0),'.','color',yellow,'marker','none','linewidth',2)

text(.7,9,'A','fontsize',8,'fontweight','bold')
text(.85,9,'metastatic samples','fontsize',8,'fontweight','bold',...
    'horizontalalignment','center')

ylabel('Num. samples','fontsize',8)
xlabel('Rank matching scores','fontsize',8)
legend('{\it{R}}^{(MAPK,met.)}','{\it{R}}^{(MAPK,norm.)}','location','northwest')
legend('boxoff')
ylim([0 8])
set(gca,'ytick',[0,8],'fontsize',8)

subplot(3,2,2)
hold on


[num,c] = hist(R_1_m_2,N_2);
stem(c(num>0),num(num>0),'.','color',dark_blue,'marker','none','linewidth',2)

[num,c] = hist(R_2_m_2,N_2);
stem(c(num>0),num(num>0),'.','color',yellow,'marker','none','linewidth',2)

text(.85,9,'normal samples','fontsize',8,'fontweight','bold',...
    'horizontalalignment','center')

ylabel('Num. samples','fontsize',8)
xlabel('Rank matching scores','fontsize',8)
ylim([0 8])
set(gca,'ytick',[0,8],'fontsize',8,'box','off')

subplot(3,2,3:4)
hold on

plot(1:N,[R_1_m_1,R_1_m_2],'o',...
    'color','k',...
    'markerfacecolor',dark_blue,...
    'markersize',5)

plot(1:N,[R_2_m_1,R_2_m_2],'o',...
    'color','k',...
    'markerfacecolor',yellow,...
    'markersize',5)

h1 = plot([0,N_1+0.5],[mu_R_1_m,mu_R_1_m],'--',...
    'color',dark_blue,...
    'linewidth',2);

h2 = plot([0,N_1+1.5],[alt_mu_2_m,alt_mu_2_m],'--',...
    'color',yellow,...
    'linewidth',2);

h3 = plot([N_1+0.5,N+1],[alt_mu_1_m,alt_mu_1_m],'--',...
    'color',dark_blue,...
    'linewidth',2);

h4 = plot([N_1+1.5,N+1],[mu_R_2_m,mu_R_2_m],'--',...
    'color',yellow,...
    'linewidth',2);


legend('{\it{R}}^{(MAPK,met.)}','{\it{R}}^{(MAPK,norm.)}',...
    'orientation','horizontal','location','northeast')
legend('boxoff')

for i = 1:N_1
    h = plot([i i],[R_1_m_1(i) R_2_m_1(i)],'-',...
        'color',dark_gray);
    uistack(h,'bottom')
end

for i = 1:N_2
    h = plot([i i]+N_1,[R_1_m_2(i) R_2_m_2(i)],'-',...
        'color',dark_gray);
    uistack(h,'bottom')
end

uistack(h1,'bottom'); uistack(h2,'bottom');
uistack(h3,'bottom'); uistack(h4,'bottom');

plot([N_1+0.5,N_1+0.5],[0.5,0.975],'k--','linewidth',2)

text(-5,1.2,'B','fontsize',8,'fontweight','bold')

ylim([.70 1.1])
xlim([0 N+1])
ylabel('Rank matching score','fontsize',8)
set(gca,'xtick',[],'ytick',[.75,1.0],'fontsize',8)


subplot(3,2,5:6)
Delta_m = [R_1_m_1,R_1_m_2]-[R_2_m_1,R_2_m_2];
Delta_m_pos = Delta_m(Delta_m > 0);
Delta_m_neg = Delta_m(Delta_m < 0);
Delta_m_zero = Delta_m(Delta_m == 0);

x = 1:N;
x_pos = x(Delta_m > 0);
x_neg = x(Delta_m < 0);
x_zero = x(Delta_m == 0);

hold on

stem(x_pos,Delta_m_pos,'fill',':',...
    'color','k',...
    'markerfacecolor',dark_blue,...
    'markersize',5)

stem(x_neg,Delta_m_neg,'fill',':',...
    'color','k',...
    'markerfacecolor',yellow,...
    'markersize',5)

stem(x_zero,Delta_m_zero,':',...
    'color','k',...
    'markerfacecolor',brown,...
    'markersize',5)

plot([N_1+0.5,N_1+0.5],[-.2,.2],'k--','linewidth',2)

text(-5,.6,'C','fontsize',8,'fontweight','bold')

legend('Predicted as metastatic','Predicted as normal','orientation','horizontal')
legend('boxoff')
ylim([-.2 .5])
xlim([0 N+1])
ylabel('Rank difference score','fontsize',8)
set(gca,'xtick',[],'ytick',[-.2,0,.2],'fontsize',8)

