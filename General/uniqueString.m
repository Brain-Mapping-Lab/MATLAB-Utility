function [filteredArray, numericID] = uniqueString(stringArray)

if ~iscell(stringArray)
    error('Input must be cell array');
end

filteredArray{1} = stringArray{1};
numericID = zeros(size(stringArray));
numericID(1) = 1;
for i = 2:length(stringArray)
    if ~strcmpi(filteredArray, stringArray{i})
        filteredArray{end+1} = stringArray{i};
    end
    numericID(i) = find(strcmpi(filteredArray, stringArray{i}));
end

end

