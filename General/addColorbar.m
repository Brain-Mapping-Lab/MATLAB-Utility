function [ cHandle ] = addColorbar( Title, varargin )
%Modified Colorbar Function
%   [ cHandle ] = addColorbar( Title )
%
%   Add colorbar to current axis with title string given in input.
%   Resize current axis to maintain the same scale as before colorbar
%   added.
%
%   J. Cagle, University of Florida 2016

if length(varargin) == 2
    if strcmpi(varargin{1}, 'AX')
        h = varargin{2};
    end
else
    h = gca;
end

imageAxis = get(h, 'position');
cHandle = colorbar('peer',h);
textH = ylabel(cHandle,Title,'fontsize',12,'Rotation',-90.0,'VerticalAlignment','bottom');
set(h, 'position', imageAxis);

if length(varargin) == 1
    set(textH,'fontsize',varargin{1})
end

end

