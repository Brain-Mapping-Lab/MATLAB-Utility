function standardErrorBar(x, y, e, varargin)

if sum(diff([length(x),length(y),length(e)])) ~= 0
    error('The X, Y, and Standard Errors dimension do not match');
end

p = inputParser;
addRequired(p, 'x', @isnumeric);
addRequired(p, 'y', @isnumeric);
addRequired(p, 'e', @isnumeric);
addParameter(p, 'color', 'b', @(x) ischar(x) || (isnumeric(x) && length(x) == 3));
addParameter(p, 'linewidth', 2, @(x) isnumeric(x) && (x > 0));
addParameter(p, 'parent', gca);
addParameter(p, 'width', 0, @(x) isnumeric(x) && (x > 0));
parse(p, x, y, e, varargin{:});

ax = p.Results.parent;
holdStatus = ishold(ax);
if p.Results.width == 0
    width = diff(ax.XLim)*0.05;
else
    width = p.Results.width;
end

if ~holdStatus
    hold(ax,'on');
end

for i = 1:length(x)
    plot(ax, [x(i) x(i)], y(i) + [e(i), -e(i)], 'color', p.Results.color, 'linewidth', p.Results.linewidth);
    plot(ax, [x(i)-width x(i)+width], [y(i)+e(i) y(i)+e(i)], 'color', p.Results.color, 'linewidth', p.Results.linewidth);
    plot(ax, [x(i)-width x(i)+width], [y(i)-e(i) y(i)-e(i)], 'color', p.Results.color, 'linewidth', p.Results.linewidth);
end

if ~holdStatus
    hold(ax,'off');
end