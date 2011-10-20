function [E_log10_QN_train,groups_train,E_log10_QN_test,groups_test] = ...
    split_sample_data(E_log10_QN, groups, num_folds)

[groups, indices] = sort(groups, 'descend');
E_log10_QN = E_log10_QN(:, indices);

total = length(groups);

E_log10_QN_test = cell(num_folds, 1);
E_log10_QN_train = cell(num_folds, 1);
groups_test = cell(num_folds, 1);
groups_train = cell(num_folds, 1);

for i=1:total
    cur_index = mod(i-1, num_folds) + 1;
    E_log10_QN_test{cur_index} = [E_log10_QN_test{cur_index} E_log10_QN(:,i)];
    groups_test{cur_index} = logical([groups_test{cur_index} groups(i)]);
end

for i=1:num_folds
    for j=1:num_folds
        if j == i
            continue
        else
            E_log10_QN_train{i} = [E_log10_QN_train{i} E_log10_QN_test{j}];
            groups_train{i} = [groups_train{i} groups_test{j}];
        end
    end
    
    [g, ind] = sort(groups_train{i}, 'descend');
    groups_train{i} = logical(g);
    E_log10_QN_train{i} = E_log10_QN_train{i}(:, ind);
end

