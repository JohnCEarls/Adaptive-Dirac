function [ratio, intersection_count, unique_union_count] = jaccard_genesets(set_a, set_b)
% ratio = |A and B| / |A or B|
% sets A and B are cell arrays
% assumes elements are not duplicated within a single array
% (A or B cannot be {'foo' 'bar' 'foo'})

% the first entry is the geneset name, the second is the descriptor
set_a = set_a(3:end);
set_b = set_b(3:end);

map = java.util.Hashtable;

size_a = nonempty_elements(set_a);
size_b = nonempty_elements(set_b);
union_count = size_a + size_b;

for i = 1:size_a
    map.put(set_a{i},1);
end

intersection_count = 0;
for i = 1:size_b
    if ~isempty(map.put(set_b{i}, 1))
        intersection_count = intersection_count + 1;
    end
end

unique_union_count = union_count - intersection_count;
ratio = intersection_count / unique_union_count;