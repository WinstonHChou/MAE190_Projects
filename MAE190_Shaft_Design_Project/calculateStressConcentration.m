function [Kt, Kts] = calculateStressConcentration(D, d, r)
    % calculateStressConcentration - Computes stress concentration factors
    %
    % Inputs:
    %   D - Thick Diameter
    %   d - Thin Diameter
    %   r - radius
    %
    % Outputs:
    %   Kt - Torsional stress concentration factor
    %   Kb - Bending stress concentration factor

    % Define default values
    Kt = 1;
    Kts = 1;

    % Error Handling
    if D/d > 2.00 || D/d < 1.09
        error('No available data for K_ts');
    end
    if D/d > 6.00 || D/d < 1.01
        error('No available data for K_t');
    end
    if any(D==0,d==0,r==0)
        error('None of the diameters and notch radius should be 0');
    end
    
    % Compute for Kt
    D_d = [1.01, 1.02, 1.03, 1.05, 1.07, 1.10, 1.20, 1.50, 2.00, 3.00, 6.00];                                           % D/d values
    A = [0.91938, 0.96048, 0.98061, 0.98137, 0.97527, 0.95120, 0.97098, 0.93836, 0.90879, 0.89334, 0.87868];            % Corresponding A values
    b = [-0.17032, -0.17711, -0.18381, -0.19653, -0.20958, -0.23757, -0.21796, -0.25759, -0.28598, -0.30860, -0.33243]; % Corresponding b values
    A_target = interp1(D_d, A, D/d, 'linear');
    b_target = interp1(D_d, b, D/d, 'linear');
    Kt = A_target * (r/d) ^ b_target;

    % Compute for Kts
    D_d = [1.09, 1.20, 1.33, 2.00];                 % D/d values
    A = [0.90337, 0.83425, 0.84897, 0.86331];       % Corresponding A values
    b = [-0.12692, -0.21649, -0.23161, -0.23865];   % Corresponding b values
    A_target = interp1(D_d, A, D/d, 'linear');
    b_target = interp1(D_d, b, D/d, 'linear');
    Kts = A_target * (r/d) ^ b_target;

    % Cap the factors
    Kt = capValue(Kt,1.0,Inf);
    Kts = capValue(Kts,1.0,Inf);
end
