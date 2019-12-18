function Y = soundGenerator( A, X, duration, Fs )
%Create Sound Waveform from given frequency and duration.
%   J. Cagle, 2018

t = (0:Fs*duration-1)/Fs;
Y = zeros(1,Fs*duration);
for n = 1:length(X)
    Y = Y + A(n)*sin(2*pi*X(n)*t);
end

end

