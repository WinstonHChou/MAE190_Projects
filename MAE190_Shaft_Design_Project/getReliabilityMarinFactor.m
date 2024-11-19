function Ke = getReliabilityMarinFactor(reliability)
    % getReliabilityMarinFactor - Calculates the reliability modification factor (K_e)
    % for fatigue endurance limit estimation.
    %
    % Inputs:
    %   reliability - Desired reliability level as a percentage (e.g., 90 for 90%)
    %
    % Output:
    %   Ke - Reliability modification factor (dimensionless)
    
    % Define reliability levels and corresponding K_e values
    reliabilityLevels = [50, 90, 95, 99, 99.9, 99.99, 99.999, 99.9999];     % Reliability levels (%)
    Ke_values = [1.000, 0.897, 0.868, 0.814, 0.753, 0.702, 0.659, 0.620];   % Corresponding K_e values

    % Ensure reliability is within the range of defined levels
    if reliability < min(reliabilityLevels) || reliability > max(reliabilityLevels)
        error('Reliability must be between %.1f%% and %.1f%%.', min(reliabilityLevels), max(reliabilityLevels));
    end

    % Interpolate K_e for the given reliability
    Ke = interp1(reliabilityLevels, Ke_values, reliability, 'linear');

    % Ensure Ke is within reasonable bounds
    Ke = capValue(Ke, 0, 1); % K_e cannot exceed 1 or be negative
end