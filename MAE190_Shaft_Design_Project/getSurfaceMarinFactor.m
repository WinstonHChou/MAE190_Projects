function Ka = getSurfaceMarinFactor(Sut, finishType, unit)
    % getSurfaceMarinFactor - Calculates the surface modification factor (K_a)
    % for endurance limit estimation.
    %
    % Inputs:
    %   Su         - Ultimate tensile strength
    %   finishType - Type of surface finish
    %                1) Ground
    %                2) Machined or cold-drawn
    %                3) Hot-rolled
    %                4) As-forged
    %   unit       - "MPa" / "ksi"
    %
    % Output:
    %   Ka - Surface modification factor (dimensionless)

    % Check if Su is valid
    if Sut <= 0
        error('Ultimate tensile strength (Su) must be positive.');
    end

    % Define coefficients (a, b) for different surface finishes
    % Based on empirical data
    switch unit
        case 'MPa'
            switch finishType
                case 'Ground'
                    a = 1.58;
                    b = -0.085;
                case 'Machined / Cold-drawn'
                    a = 4.51;
                    b = -0.265;
                case 'Hot-rolled'
                    a = 57.7;
                    b = -0.718;
                case 'As-forged'
                    a = 272;
                    b = -0.995;
                otherwise
                    error('Invalid surface finish type. Choose "Ground", "Machined / Cold-drawn", "Hot-rolled", or "As-forged".');
            end
        case 'ksi'
            switch finishType
                case 'Ground'
                    a = 1.34;
                    b = -0.085;
                case 'Machined / Cold-drawn'
                    a = 2.70;
                    b = -0.265;
                case 'Hot-rolled'
                    a = 14.4;
                    b = -0.718;
                case 'As-forged'
                    a = 39.9;
                    b = -0.995;
                otherwise
                    error('Invalid surface finish type. Choose "Ground", "Machined / Cold-drawn", "Hot-rolled", or "As-forged".');
            end
    end

    % Compute surface factor K_a
    Ka = a * (Sut)^b;

    % Ensure K_a is within reasonable bounds
    Ka = capValue(Ka, 0, Inf); % K_a cannot be negative
end
