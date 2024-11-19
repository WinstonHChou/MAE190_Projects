function d = computeDiameter(Tm, Ta, Mm, Ma, Kf, Kfs, Sy, Se, Sut, n, criterion, unit)
    % computeDiameter - Computes the required diameter for a shaft
    % based on the selected fatigue criterion.
    %
    % Inputs:
    %   Tm         - Mean Torque (Nm or lb*in)
    %   Ta         - Alternating Torque  (Nm or lb*in)
    %   Mm         - Mean Bending Moment (Nm or lb*in)
    %   Ma         - Alternating Bending Moment (Nm or lb*in)
    %   Sy         - Yield Strngth (MPa or lb*in)
    %   Se         - Modified Endurance Limit (MPa or ksi)
    %   Sut        - Ultimate tensile strength (MPa or ksi)
    %   n          - Desired Safety Factor
    %   criterion  - fatigue failure criterion
    %   unit       - 'MPa' / 'ksi'
    %
    % Output:
    %   d          - Required diameter (mm or inches)

    % Convert stresses into Pa or psi
    switch unit
        case 'MPa'
            Sy = Sy * 10^6;
            Se = Se * 10^6;
            Sut = Sut * 10^6;
        case 'ksi'
            Sy = Sy * 10^3;
            Se = Se * 10^3;
            Sut = Sut * 10^3;
    end

    % Calculate the required diameter using given criterion
    switch criterion
        case 'Modified Goodman'
            d = ((16*n/pi) * ((1/Se)*(4*(Kf*Ma)^2 + 3*(Kfs*Ta)^2)^(1/2) + (1/Sut)*(4*(Kf*Mm)^2 + 3*(Kfs*Tm)^2)^(1/2))) ^ (1/3);
        case 'DE-Gerber'
            A = (4*(Kf*Ma)^2 + 3*(Kfs*Ta)^2) ^ (1/2);
            B = (4*(Kf*Mm)^2 + 3*(Kfs*Tm)^2) ^ (1/2);
            d = ((8*n*A/(pi*Se)) * (1 + (1 + (2*B*Se/(A*Sut))^2)^(1/2))) ^ (1/3);
        case 'DE-ASME Elliptic'
            d = ((16*n/pi) * (4*(Kf*Ma/Se)^2 + 3*(Kfs*Ta/Se)^2 + 4*(Kf*Mm/Sy)^2 + 3*(Kfs*Tm/Sy)^2)^(1/2)) ^ (1/3);
        case 'DE-Soderberg'
            d = ((16*n/pi) * ((1/Se)*(4*(Kf*Ma)^2 + 3*(Kfs*Ta)^2)^(1/2) + (1/Sy)*(4*(Kf*Mm)^2 + 3*(Kfs*Tm)^2)^(1/2))) ^ (1/3);
    end 
end