function [E_log10_QN_train,groups_train,E_log10_QN_test,groups_test] = ...
    split_sample_data(E_log10_QN, groups, test_fraction)

[groups, indices] = sort(groups);
E_log10_QN = E_log10_QN(:, indices);

total = length(groups);
pos_count = ones(1, total) * groups;
neg_count = total - pos_count;
num_test_pos = fix(test_fraction * pos_count);
num_test_neg = fix(test_fraction * neg_count);

test_pos_index_start = 1;
test_pos_index_end  = num_test_pos;
test_neg_index_start = pos_count+1;
test_neg_index_end = pos_count+num_test_neg;
train_pos_index_start = num_test_pos+1;
train_pos_index_end = pos_count;
train_neg_index_start = pos_count+1+num_test_neg;
train_neg_index_end = total;

% ensure test data contains at least 2 of each class
if test_pos_index_start == test_pos_index_end
    test_pos_index_end = test_pos_index_end + 1; %TODO, assumes much
    train_pos_index_start = train_pos_index_start + 1;
    num_test_pos = num_test_pos + 1;
end
if test_neg_index_start == test_neg_index_end
    test_neg_index_end = test_neg_index_end + 1;
    train_neg_index_start = train_neg_index_start + 1;
    num_test_neg = num_test_neg + 1;
end

E_log10_QN_test = E_log10_QN(:, test_pos_index_start:test_pos_index_end);
E_log10_QN_test = [E_log10_QN_test E_log10_QN(:, test_neg_index_start:test_neg_index_end)];
E_log10_QN_train = E_log10_QN(:, train_pos_index_start:train_pos_index_end);
E_log10_QN_train = [E_log10_QN_train E_log10_QN(:, train_neg_index_start:train_neg_index_end)];

groups_test = logical([ones(num_test_pos,1); zeros(num_test_neg,1)]);
groups_train = logical([ones(pos_count-num_test_pos,1); zeros(neg_count-num_test_neg,1)]);