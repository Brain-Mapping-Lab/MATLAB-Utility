function noise = randf(n, fs)
% Randon Number Generator for 1/f spectrum
%   J. Cagle, 2019
frequency = 0:0.01:0.99;
amplitude = 1./(1+frequency*2);
filterCoefficient = firls(round(sqrt(fs)), frequency, amplitude);

rawNoise = randn([1,n]);
noise = filtfilt(filterCoefficient,1,rawNoise);