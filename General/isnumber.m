function output = isnumber(string)

output = false(size(string));
counter = 1;
for a = string
    output(counter) = ~isempty(strfind('0123456789', upper(a)));
    counter = counter + 1;
end