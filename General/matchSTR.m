function [ result ] = matchSTR( cell_array, str, varargin )
%matchStr to identify string within cell array
%   Created for textscan output

if iscell(cell_array)
    while(iscell(cell_array{1}))
        if isempty(cell_array{1})
            result = false;
            return;
        end
        cell_array = cell_array{1};
    end
    result = false(size(cell_array));
    for i = 1:size(cell_array,1)
        for j = 1:size(cell_array,2)
            if strcmp(cell_array{i,j},str)
                result(i,j) = true;
            end
        end
    end
else
    error('Input is not a cell array');
end

if nargin > 2
    if varargin{1}
        if sum(result)>0
            result = true;
        else
            result = false;
        end
    end
else
    result = find(result);
end

end

