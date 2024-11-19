function cappedValue = capValue(value, minVal, maxVal)
    % capValue - Caps a value within the specified minimum and maximum range
    %
    % Inputs:
    %   value  - The value to be capped
    %   minVal - Minimum allowable value
    %   maxVal - Maximum allowable value
    %
    % Output:
    %   cappedValue - The capped value, limited to the range [minVal, maxVal]

    % Check if minVal is less than or equal to maxVal
    if minVal > maxVal
        error('minVal must be less than or equal to maxVal.');
    end

    % Apply capping
    cappedValue = max(min(value, maxVal), minVal);
end
