function [ Frequency ] = getFrequency( NFFT,Fs )
%getFrequency will acquire the frequency resolution for fast Fourier Tranform
%   [ Frequency ] = getFrequency( NFFT,Fs )

Frequency = 0:1/(NFFT/Fs):(NFFT-1)*1/(NFFT/Fs);

end

