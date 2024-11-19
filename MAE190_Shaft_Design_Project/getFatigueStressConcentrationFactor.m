function [Kf,Kfs] = getFatigueStressConcentrationFactor(Kt, Kts, r, Sut)
    % getFatigueStressConcentrationFactor - Computes the fatigue stress concentration factor (K_f)
    % based on a given stress concentration factor (K_t) and a characteristic dimension.
    %
    % Inputs:
    %   Kt      - Geometric normal stress concentration factor (dimensionless)
    %   Kts     - Geometric shear stress concentration factor (dimensionless)
    %   r       - Notch radius (in)
    %   Sut     - Ultimate tensile strength (ksi)
    %
    % Output:
    %   Kf      - Fatigue stress concentration factor (dimensionless)
    
    % Check if inputs are positive
    if Kt <= 0 || Kts <= 0 || Sut <= 0
        error('All input values must be positive.');
    end
    
    % Compute notch sensitivities
    sqrt_a_bending_axial = 0.246 - 3.08*(10^-3)*Sut + 1.51*(10^-5)*Sut^2 - 2.67*(10^-8)*Sut^3;
    sqrt_a_torsion = 0.190 - 2.51*(10^-3)*Sut + 1.35*(10^-5)*Sut^2 - 2.67*(10^-8)*Sut^3;;
    q = 1 / (1 + sqrt_a_bending_axial / sqrt(r));
    q_shear = 1 / (1 + sqrt_a_torsion / sqrt(r));
    % disp(q);
    % disp(q_shear);

    % Calculate the fatigue stress concentration factor
    Kf = 1 + q*(Kt - 1);
    Kfs = 1 + q_shear*(Kts - 1);
end
