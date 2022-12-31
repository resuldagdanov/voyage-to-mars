
function [h, sigma_dot, omega_dot, T] = orbital_elements(incl)
    
    R_M = 3396; % [km]
    altitude = 300; % [km]
    r = R_M + altitude; % [km]
    a = r; % [km]

    % gravitational parameter of Mars (Table.A.2)
    mu = 42828; % [km^3/s^2]

    % second zonal harmonics of Mars (Table.4.3)
    J2 = 1.96045 * 10^(-3);
    
    % angular momentum in Mars circular orbit as eccentricity=0 (Eq.2.62)
    h = sqrt(r * mu); % [km^2/s]
    
    % orbit derivative of right ascension of ascending node (Eq.4.52)
    sigma_dot = - ((3 / 2) * ((sqrt(mu) * J2 * r) / ...
                   (a^(7 / 2)))) * cos(incl); % [rad/s]

    % argument of perigee [rad] (Eq.4.54)
    omega_dot = sigma_dot * (((5 / 2) * (sin(incl)^2) - 2) / cos(incl));

    % time period of the circular orbit (Eq.2.64)
    T = ((2 * pi) / (sqrt(mu))) * (r)^(3 / 2); % [s]

end
