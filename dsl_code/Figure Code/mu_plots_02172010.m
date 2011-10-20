
% mu_plots

% close all

blue = [198,217,241]/255; dark_blue = [31,73,125]/255;
yellow = [255,192,0]/255;
red = [255,0,0]/255; dark_red = [192,0,0]/255;
olive = [119,147,60]/255;
brown = [221,217,195]/255;

load mu_diff_struct_02172010


d_names = {'GIST','LMS',...
    '(nr) breast cancer','(r) breast cancer',...
    'lung cancer','normal lung',...
    'MFS fibroblast','non-MFS fibroblast',...
    'Crohn''s PBMCs','non-Crohn''s PBMCs',...
    'Parkinson''s disease','healthy blood',...
    'bipolar cortex','non-bipolar cortex',...
    'AML 1','ALL 1',...
    'AML 2','ALL 2',...
    'HNSCC','normal head/neck',...
    'CL ovarian tumor','AL ovarian tumor',...
    '(p) prostate cancer','normal prostate',...
    '(m) prostate cancer','normal prostate',...
    '(m) prostate cancer','(p) prostate cancer'};


to_delete = [3,5,6,14];
% to_delete = [3,5,6,8,9];
mu_diff_struct(to_delete) = [];
d_names([2*to_delete, 2*to_delete-1]) = [];

% sort_order = [1;6;3;5;2;4;7;8;9];
% mu_diff_struct = mu_diff_struct(sort_order);
% 
% names_sort_order = [1;2;11;12;5;6;9;10;3;4;7;8;13;14;15;16;17;18];
% d_names = d_names(names_sort_order);

D = numel(d_names);
i = 1;

% figure;
% subplot(3,4,1:2)
% plot(.75,.85,'o',...
%     'color','k',...
%     'markerfacecolor',dark_red,...
%     'markersize',5);
% % hold on
% % plot(0,0,'o',...
% %     'color','k',...
% %     'markerfacecolor',blue,...
% %     'markersize',5)
% text(.725,.95,'(# tighter in less malignant)',...
%     'horizontalalignment','left',...
%     'fontsize',8)
% 
% text(.975,.75,'(# tighter in more malignant)',...
%     'horizontalalignment','right',...
%     'fontsize',8)
% 
% text(.85,.85,{'Relative regulation of network'; 'one phenotype vs. the other'},...
%     'horizontalalignment','center',...
%     'fontsize',8,'fontweight','bold');
% 
% xlim([.7 1])
% ylim([.7 1])
% % legend('Relative regulation of pathway between phenotypes',...
% %     'location','east')
% legend('boxoff')
% xlabel('Rank conservation index in more malignant phenotype',...
%     'fontangle','italic','fontsize',8)
% ylabel({'Rank conservation index';'in less malignant phenotype'},...
%     'fontangle','italic','fontsize',8,...
%     'horizontalalignment','right','verticalalignment','middle','rotation',0)
% set(gca,'xtick',[],'ytick',[],'fontsize',10,'fontweight','bold','box','off')
% 
% 
% labels = {'A','B','C','D','E','F','G','H','I'};
% alpha = 0.05;
% mu_diff_counts = zeros(numel(mu_diff_struct),2);
% for i = 1:numel(mu_diff_struct)
%     subplot(3,4,i+3)
%     mu_diff_stats = mu_diff_struct(i).mu_diff;
%     mu_diff_m = find(mu_diff_stats(:,5) < alpha);
%     mu_R_1 = mu_diff_struct(i).mu_R(mu_diff_m,1);
%     mu_R_2 = mu_diff_struct(i).mu_R(mu_diff_m,2);
% 
%     pos = mu_R_2 > mu_R_1;
%     neg = mu_R_2 < mu_R_1;
%     mu_diff_counts(i,:) = [sum(pos),sum(neg)];
%     plot(mu_R_1(pos),mu_R_2(pos),'o',...
%         'color',dark_red,...
%         'markerfacecolor',dark_red,...
%         'markersize',3);
%     hold on
%     plot(mu_R_1(neg),mu_R_2(neg),'o',...
%         'color',dark_red,...
%         'markerfacecolor',dark_red,...
%         'markersize',3)
%     
% %     range = [min([mu_R_1;mu_R_2]), max([mu_R_1;mu_R_2])];
%     range = [.72 .98];
%     plot(range,range,'k-')
% 
%     xlim([.7 1])
%     ylim([.7 1])
%     
%     text(.725,.95,['(',num2str(sum(pos)),')'],...
%         'horizontalalignment','left',...
%         'fontsize',8')
% 
%     text(.975,.75,['(',num2str(sum(neg)),')'],...
%         'horizontalalignment','right',...
%         'fontsize',8')
%     
%     xlabel(d_names(2*i-1),'fontsize',8)
%     ylabel(d_names(2*i),'fontsize',8)
%     
% %     title(labels{i},'fontsize',8,'fontweight','bold','horizontalalign','left')
%     text(.60,1.04,labels{i},'fontsize',8,'fontweight','bold')
%     
%     set(gca,'xtick',[],'ytick',[],'fontsize',8)
% end


figure;
mu_diff_stats = mu_diff_struct(1).mu_diff;
global_mu = zeros(size(mu_diff_stats,1),D);
for i = 1:numel(mu_diff_struct)
    mu_diff_stats = mu_diff_struct(i).mu_diff;
    [mds,sort_idx] = sortrows(mu_diff_stats);
    mu_R_1 = mu_diff_struct(i).mu_R(sort_idx,1);
    mu_R_2 = mu_diff_struct(i).mu_R(sort_idx,2);
    j = (2*i)-1;
    global_mu(mds(:,1),j:j+1) = [mu_R_1,mu_R_2];
end
global_mu(:,end) = []; d_names(end) = [];
D = numel(d_names);
for i = 1:D
    global_mu(global_mu(:,i)==0,i)=mean(global_mu(:,i));
end

global_mu_mean = mean(global_mu,1);
[gmm,s] = sort(global_mu_mean,'descend');
gm_s = global_mu(:,s);

global_mu_mean2 = mean(gm_s,2);
[gmm2,s2] = sort(global_mu_mean2,'descend');
gm_s = gm_s(s2,:);

% mu_R_gs = gs_struct.gs(s2);

clims = [min(min(global_mu(global_mu > 0))),max(max(global_mu))];
imagesc(gm_s,clims)

% scale = linspace(0,1,50)';
% r = olive(1)*scale; g = olive(2)*scale; b = olive(3)*scale;
% rgb = [r,g,b];
colormap(hot)

text(0,-47,'Highest rank conservation',...
    'horizontalalignment','left',...
    'fontsize',8,'fontweight','bold')

text(D,-47,'Lowest rank conservation',...
    'horizontalalignment','right',...
    'fontsize',8,'fontweight','bold')

annotation('doublearrow',[.15 .82],[.95 .95])

ylabel('Networks','fontsize',8)
xlabel('Phenotypes','fontsize',8)

for i = 1:D
    text(i,-1,d_names{s(i)},...
    'Rotation',30, ...
    'VerticalAlignment','bottom', ...
    'HorizontalAlignment','left','fontsize',8);
%     text(i,255,num2str(gmm(i),'%1.3f'),...
%         'horizontalalignment','center','fontsize',7)
end
set(gca,'xtick',1:D,'xticklabel',[],...
    'ytick',[],'fontsize',8,'outerposition',[0 0 1 .9])

colorbar
set(gca,'fontsize',8)

