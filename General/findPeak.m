function [ localMax ] = findPeak( Data, direction )
%Finding Local Maximum with Simple Thresholding
%   J. Cagle, University of Florida, 2018

slope = diff(Data);
if direction > 0
    peak = find(slope(2:end)<=0 & slope(1:end-1)>0);
    threshold = std(Data(peak+1))*5;
    localMax = peak(Data(peak+1)>threshold)+2;
else
    peak = find(slope(2:end)>0 & slope(1:end-1)<=0);
    threshold = std(Data(peak+1))*-5;
    localMax = peak(Data(peak+1)<threshold)+2;
end

end

