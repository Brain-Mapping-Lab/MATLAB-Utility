function [index,difference] = closestMatchIndex(array, value)
%% Find the index an array closest to the value given

[difference, index] = min(abs(array-value));