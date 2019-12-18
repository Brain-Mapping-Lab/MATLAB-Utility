function [ varargout ] = MemSpect( Data, Window, Overlay, Frequency, Fs, varargin )
%Simplified Maximum Entropy Method Spectrogram
%   [S,F,T,P] = MemSpect(Data,Window,Overlay,Frequency,Fs);
%   
%   ---- Maximum Entrophy Method for BCI2000 does not compute S. This is
%   written as complementary to spectrogram function, which is why S is
%   used. 
%
%   J. Cagle, University of Florida 2016

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

Order = 30;
if length(varargin) > 0
    if rem(length(varargin),2) ~= 0
        error('Incorrect number of input parameter pair');
    end
    if strcmpi(varargin{1},'Order')
        Order = varargin{2};
    end
end

bins = getIndices(length(Data), Window, Overlay, 'floor');
numBin = length(bins);

F = Frequency;
T = zeros(1,numBin);
P = zeros(length(Frequency),numBin);

mem_params = configMem(Order, Frequency, Fs, 'detrend', true, 'evalBin', 5);

for i = 1:numBin
    T(i) = (bins(i) + bins(i)+Window) / 2 / Fs;
    subData = Data(bins(i) : bins(i)+Window);
    P(:,i) = mem(subData,mem_params);
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