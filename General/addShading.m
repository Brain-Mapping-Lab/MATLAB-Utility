function [handles] = addShading( aH, X, StateVector, varargin )
%Add Color Shading to a graphical axes. 
%   handles = addShading(aH, X, StateVector);
%       X is the X-axis vector for each State.
%       StateVector is a vector containing 1 indicating the X area should
%       be shaded. 
%
%   handles = addShading(aH, X, StateVector, Color);
%       Color can be modified by adding to the input arguments.
%
%   J. Cagle, University of Florida, 2018

holdState = ishold;
if ~holdState
    hold(aH, 'on');
end

Color = 'g';
if length(varargin)==1
    Color = varargin{1};
end

Limit = get(aH,'YLim');

Onset = X(find(diff(StateVector) == 1)+1);
Offset = X(find(diff(StateVector) == -1)+1);
if length(Onset) > length(Offset)
    Offset = [Offset X(end)];
elseif length(Offset) > length(Onset)
    Onset = [X(1) Onset];
elseif isempty(Offset)
    return;
elseif Offset(1) < Onset(1)
    Onset = [X(1) Onset];
    Offset = [Offset X(end)];
end

XData = [Onset; Onset; Offset; Offset];
YData = [Limit(1)-10 * ones(size(Onset));
    Limit(2)+10 * ones(size(Onset));
    Limit(2)+10 * ones(size(Onset));
    Limit(1)-10 * ones(size(Onset));];

handles = patch(aH, XData, YData, Color, 'edgecolor', 'none');
alpha(handles, 0.4);
ylim(aH, Limit);

if ~holdState
    hold(aH, 'off');
end

end

