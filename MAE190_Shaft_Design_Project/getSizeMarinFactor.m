function Kb = getSizeMarinFactor(d, unit)
    % getSizeMarinFactor - Calculates the size modification factor (K_b)
    % for a circular rotating shaft based on its diameter.
    %
    % Inputs:
    %   d       - Actual shaft diameter
    %   unit    - "mm" / "in"
    %
    % Output:
    %   Kb   - Size modification factor (dimensionless)
    
    % Check if the diameters are positive
    if d <= 0
        error('Diameters must be positive.');
    end

    switch unit
        case 'mm'
            d = d / 25.4; % force convert to in
    end

    % Calculate the size modification factor
    if d >= 0.11 && d <= 2
        Kb = (d / 0.3) ^ (-0.107);
    elseif d > 2 && d <= 10
        Kb = 0.91 * d ^ (-0.157);
    elseif d > 10
        error('The diameter of %f is too thick',d);
    else
        error('The diameter of %f is too thin',d);
    end
    
    % Ensure K_size is positive
    Kb = max(0, Kb); % K_b should not be negative
end
