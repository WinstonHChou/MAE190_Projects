function n = computeFoS(Tm, Ta, Mm, Ma, Kf, Kfs, Sy, Se, Sut, d, criterion, stress_unit, length_unit)
    % computeFoS - Computes the Factor of Safety for a shaft
    % based on the selected fatigue criterion.
    %
    % Inputs:
    %   Tm          - Mean Torque (Nm or lb*in)
    %   Ta          - Alternating Torque  (Nm or lb*in)
    %   Mm          - Mean Bending Moment (Nm or lb*in)
    %   Ma          - Alternating Bending Moment (Nm or lb*in)
    %   Sy          - Yield Strngth (MPa or lb*in)
    %   Se          - Modified Endurance Limit (MPa or ksi)
    %   Sut         - Ultimate tensile strength (MPa or ksi)
    %   d           - diameter (mm or in)
    %   criterion   - fatigue failure criterion
    %   stress_unit - 'MPa' / 'ksi'
    %   length_unit - 'mm' / 'in'
    %
    % Output:
    %   n           - Safety Factor

    % Convert stresses into Pa or psi
    switch stress_unit
        case 'MPa'
            Sy = Sy * 10^6;
            Se = Se * 10^6;
            Sut = Sut * 10^6;
        case 'ksi'
            Sy = Sy * 10^3;
            Se = Se * 10^3;
            Sut = Sut * 10^3;
    end
    
    % Convert mm to m if applicable
    switch length_unit
        case 'mm'
            d = d / 1000;
    end

    % Calculate the required diameter using given criterion
    switch criterion
        case 'Modified Goodman'
            n = 1 / ((16/(pi*d^3)) * ((1/Se)*(4*(Kf*Ma)^2 + 3*(Kfs*Ta)^2)^(1/2) + (1/Sut)*(4*(Kf*Mm)^2 + 3*(Kfs*Tm)^2)^(1/2)));
        case 'DE-Gerber'
            A = (4*(Kf*Ma)^2 + 3*(Kfs*Ta)^2) ^ (1/2);
            B = (4*(Kf*Mm)^2 + 3*(Kfs*Tm)^2) ^ (1/2);
            n = 1 / ((8*A/(pi*(d^3)*Se)) * (1 + (1 + (2*B*Se/(A*Sut))^2)^(1/2)));
        case 'DE-ASME Elliptic'
            n = 1 / ((16/(pi*d^3)) * (4*(Kf*Ma/Se)^2 + 3*(Kfs*Ta/Se)^2 + 4*(Kf*Mm/Sy)^2 + 3*(Kfs*Tm/Sy)^2)^(1/2));
        case 'DE-Soderberg'
            n = 1 / ((16/(pi*d^3)) * ((1/Se)*(4*(Kf*Ma)^2 + 3*(Kfs*Ta)^2)^(1/2) + (1/Sy)*(4*(Kf*Mm)^2 + 3*(Kfs*Tm)^2)^(1/2)));
    end 
end