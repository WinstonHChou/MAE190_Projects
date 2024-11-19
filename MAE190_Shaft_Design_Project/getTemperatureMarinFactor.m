function Kd = getTemperatureMarinFactor(temperature, unit)
    % getTemperatureMarinFactor - Calculates the temperature modification factor (K_t)
    % for fatigue endurance limit estimation.
    %
    % Inputs:
    %   temperature - Operating temperature in given unit
    %   unit        - Celsius (°C) / Fahrenheit (°F)
    %
    % Output:
    %   Kd - Temperature modification factor (dimensionless)
    switch unit
        case 'Celsius'
            temperature = (temperature * 9/5) + 32; % force convert to Fahrenheit
    end
    
    % Interpolate K_d for the given temperature
    Kd = 0.975 + 0.432*(10^-3)*temperature - 0.115*(10^-5)*temperature^2 + 0.104*(10^-8)*temperature^3 - 0.595*(10^-12)*temperature^4;

    % Ensure K_d is within reasonable bounds
    Kd = capValue(Kd, 0, Inf); % K_d cannot be negative
end
