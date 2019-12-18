function noise = powerNoise(n)
normalizedFrequency = linspace(0, 1, 50);
frequencyPower = 1./(1 + normalizedFrequency*2); 
b = firls(42, normalizedFrequency, frequencyPower);
whiteNoise = rand(1,n);
noise = filtfilt(b, 1, whiteNoise);