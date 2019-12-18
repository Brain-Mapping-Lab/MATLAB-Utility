function [ hL ] = legendFont( Handler, Input, Config )
%legendFont is the aliased version of legend with box off.
%   [ hL ] = legendFont( Handler, Input, Config );
%
% J. Cagle, University of Florida, 2013

if isstruct(Handler)
    for n = 1:length(Handler)
        lineHandler(n) = Handler(n).mainLine;
    end
    hL = legend(lineHandler,Input);
else
    hL = legend(Handler,Input);
end
for n = 1:length(Config)/2
    set(hL,Config{(n-1)*2+1},Config{n*2});
end
legend(gca,'boxoff');

end

