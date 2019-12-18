function addSignificantBoundary(X,Y,BW,varargin)

p = inputParser;
addRequired(p, 'X', @isnumeric);
addRequired(p, 'Y', @isnumeric);
addRequired(p, 'BW', @islogical);
addParameter(p, 'color', 'b', @(x) ischar(x) || (isnumeric(x) && length(x) == 3));
addParameter(p, 'linewidth', 2, @(x) isnumeric(x) && (x > 0));
addParameter(p, 'parent', gca);
addParameter(p, 'level', 0, @(x) isnumeric(x) && (x > 0));
parse(p, X, Y, BW, varargin{:});

dilutedFDR = imdilate(BW, strel('sphere',1));
[B,~] = bwboundaries(dilutedFDR);

for n = 1:length(B)
    plot3(X(B{n}(:,2)),Y(B{n}(:,1)),p.Results.level*ones(size(B{n},1)),'color',p.Results.color,'linewidth',p.Results.linewidth,'parent',p.Results.parent)
end