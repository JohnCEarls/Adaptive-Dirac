function subsets = generate_subsets(initial)

name = initial{1};
if strcmp(initial{2}, 'na')
    pathroot = '';
else
    pathroot = initial{2};
end
initial = initial(3:end);
count = 1;
total = length(initial);
while isempty(initial{count}) == 0
    count = count + 1;
    if count > total
        break;
    end
end
subsets = {};
initial = initial(1:count-1);
for i=1:length(initial)
    path = strcat(pathroot, '-', initial{i});
    if i == length(initial)
        subsets = [subsets; ['orig', path, initial(1:i-1), initial(i+1:end)]];
    else
        subsets = [subsets; [name, path, initial(1:i-1), initial(i+1:end)]];
    end
end