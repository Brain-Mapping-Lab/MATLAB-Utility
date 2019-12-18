function [ Filter_Output, DC_Output ] = DC_Remove( Input, StepSize )
%DC Removal based on LMS Algorithm
%   [ Filter_Output, DC_Output ] = DC_Remove( Input, StepSize )

DC_Source = ones(size(Input));
Weight = 0;

for n = 1:length(Input)
    DC_Output(n) = Weight(n) * DC_Source(n);
    Filter_Output(n) = Input(n)-DC_Output(n);
    Weight(n+1) = Weight(n) + StepSize * Filter_Output(n) * DC_Source(n);
end

end