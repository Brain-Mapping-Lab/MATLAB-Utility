function [ varargout ] = WelchSpect( Data, Window, Overlay, Frequency, Fs )
%Simplified Spectrogram based on Welch's Spectrogram
%   [S,F,T,P] = WelchSpect(Data,Window,Overlay,Frequency,Fs);
%   
%   J. Cagle, University of Florida 2019

if isempty(Window)
    Window = Fs;
else
    Window = round(Window);
end
if isempty(Overlay)
    Overlay = floor(Fs*0.5);
else
    Overlay = round(Overlay);
end

if size(Data,1) == 1
    Data = Data';
end

bins = getIndices(length(Data), Window, Overlay, 'floor');
numBin = length(bins);

F = Frequency;
T = zeros(1,numBin);
P = zeros(length(Frequency),numBin);

for i = 1:numBin
    T(i) = (bins(i) + bins(i)+Window) / 2 / Fs;
    subData = Data(bins(i) : bins(i)+Window);
    P(:,i) = pwelch(subData,[],[],Frequency,Fs);
end

S = 10*log10(P);
S(isinf(S)) = nan;

if nargout == 1
    varargout{1}.logPower = S;
    varargout{1}.Time = T;
    varargout{1}.Power = P;
    varargout{1}.Frequency = F;
elseif nargout == 4
    varargout{1} = S;
    varargout{2} = F;
    varargout{3} = T;
    varargout{4} = P;
else
    error('Incorrect number of output arguments');
end

end