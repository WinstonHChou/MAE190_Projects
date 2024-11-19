function Se = getEnduranceLimitSteel(Sut, unit)
    % getEnduranceLimitSteel - Calculates the endurance limit for steel
    % based on the ultimate tensile strength (S_ut).
    %
    % Inputs:
    %   Sut  - Ultimate tensile strength (S_ut) of the steel (MPa or ksi)
    %   unit - "MPa" / "ksi"
    %
    % Output:
    %   Se   - Endurance limit (S_e) for the steel (MPa or ksi)
    
    % Check if the ultimate tensile strength is a positive value
    if Sut <= 0
        error('Ultimate tensile strength must be a positive value.');
    end
    
    % Endurance limit for steel is typically 0.5 times the UTS
    switch unit
        case 'MPa'
            if Sut <= 1400
                Se = 0.5 * Sut;
            else
                Se = 700; % 700 MPa
            end
        case 'ksi'
            if Sut <= 200
                Se = 0.5 * Sut;
            else
                Se = 100; % 100 ksi
            end
    end
end
