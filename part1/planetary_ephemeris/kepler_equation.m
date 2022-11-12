%%
%
% =========================================================================
% ***********  Newtonts Method to Solve of Kepler's Equation   ************
% =========================================================================
% Arguments:
% - eccentricity: eccentricity of the orbit
% - anomaly: mean anomaly in radians
% Returns:
% - E: eccentric anomaly in radians as Kepler's equation given in (Eq.3.17)
%
%%

function E = kepler_equation(eccentricity, anomaly)
    
    % error tolerance
    error = 1.e-7;

    % starting value for E
    if anomaly < pi
        E = anomaly + (eccentricity / 2);
    else
        E = anomaly - (eccentricity / 2);
    end

    % iterate (Eq.3.17) until E is determined to within error tolerance
    ratio = 1;

    % iterate (Eq.3.17) Newton's method to solve Kepler-s equation 
    while abs(ratio) > error
        ratio = (E - (eccentricity * sin(E)) - anomaly) / ...
                (1 - eccentricity * cos(E));
        E = E - ratio;
    end

end
