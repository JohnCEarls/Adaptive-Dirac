function count = nonempty_elements(cell_array_of_strs)

%binary search not worth it
count = 1;
length = size(cell_array_of_strs);
length = length(2);
while(count <= length && (isempty(cell_array_of_strs{count}) == 0)) 
    count = count + 1;
end
    
count = count - 1;