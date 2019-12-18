function [ output_args ] = xComparisonMatrix( ax, X, Label )
%xComparisonMatrix will plot the result of ttest/ttest2 in a grid matrix
%   J. Cagle, University of Florida, 2017

% Check
N = length(Label);
if length(X) ~= N
    error('Label Length and Data Length not match');
end

% Setup
cla(ax); hold(ax,'on'); box(ax,'on');
cmap = redblue(201);
colormap(cmap);
set(ax,'fontname','Trebuchet MS')

% Compute cross-comparison matrix
R = zeros(N);
T = zeros(N);
for i = 1:N
    for j = 1:N
        if length(X{i})==length(X{j})
            [~,R(i,j)] = ttest(X{i},X{j});
        else
            [~,R(i,j)] = ttest2(X{i},X{j});
        end
        T(i,j) = sign(mean(X{i})-mean(X{j}));
    end
end
R(isnan(R)) = 1;
R = R * (N-1)^2;
R(R>1) = 1;

% Plot the Grid
for i = 1:length(R)-1
    plot(ax,[0 length(R)+1],[i i]+0.5,'linewidth',1.5,'color',[0.5 0.5 0.5]);
    plot(ax,[i i]+0.5,[0 length(R)+1],'linewidth',1.5,'color',[0.5 0.5 0.5]);
end
set(ax,'gridcolor',[0.5 0.5 0.5]);

% Plot ellipse
for i = 1:length(R)
    for j = 1:length(R)
        if true %length(R)-j+1 ~= i
            Magnitude = -log10(R(i,length(R)-j+1));
            if Magnitude > 4
                Magnitude = 4;
            end
            Magnitude = Magnitude / 4 * T(i,length(R)-j+1);
            shadedEllipse(i,j,Magnitude,cmap(202-round(Magnitude*100+101),:));
            TXT = text(i,j,sprintf('%.2f',-Magnitude*4),'horizontalalignment','center','fontsize',11,'fontname','Arial black');
            if abs(Magnitude)>0.8
                set(TXT,'color','w');
            end
        end
    end
end

% Setup axis
axis(ax,[0.5 length(R)+0.5 0.5 length(R)+0.5]);
set(ax,'XTick',1:length(R),'YTick',1:length(R),'XAxisLocation','top');
set(ax,'TickLength',[0 0],'XTickLabel',Label,'YTickLabel',flip(Label),'XTickLabelRotation',49);
set(ax, 'XColor', [1 0 0], 'YColor', [1 0 0]);
pbaspect(ax,[1 1 1])

output_args = R;

end

function shadedEllipse(X,Y,r,cScale)

    radius = 0.35;
    width = 1;
    xRange = X-0.5:0.001:X+0.5;
    underRoot = (-r*width*(xRange-X)).^2 - 4*((xRange-X).^2 - (radius^2));
    xRange = xRange(underRoot > 0);
    underRoot = underRoot(underRoot > 0);

    lowerY = (-(-r*width*(xRange-X)) + sqrt(underRoot))/2 + Y;
    upperY = (-(-r*width*(xRange-X)) - sqrt(underRoot))/2 + Y;

    h = patch([xRange,flip(xRange)],[lowerY,flip(upperY)],cScale);
    alpha(h,sqrt(abs(r)));
    
end
