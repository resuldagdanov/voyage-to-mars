
function [spacecraft_position, period] = vehicle_position(time, theta)
    
    deg2_rad =  pi / 180;

    % initial right ascension of the node and argument of perigee [rad]
    sigma_0 = 49.57854 * deg2_rad;
    omega_0 = 336.04084 * deg2_rad;
    
    % inclination [rad]
    incl = 25.19 * deg2_rad;
    
    [h, sigma_dot, omega_dot, period] = orbital_elements(incl);

    % spacecraft position vector in perifocal coordinates [km]
    r_x = h * [cos(theta * deg2_rad); sin(theta * deg2_rad); 0.0];

    sigma = sigma_0 + (sigma_dot * time);
    omega = omega_0 + (omega_dot * time);

    % direction cosine matrix from geocentric equatorial to perifocal frame
    QXx = [cos(omega),  sin(omega),  0;
           -sin(omega), cos(omega),  0;
           0,           0,           1] * ...
          [1,           0,           0;
           0,           cos(incl),   sin(incl);
           0,           -sin(incl),  cos(incl)] * ...
          [cos(sigma),  sin(sigma),  0;
           -sin(sigma), cos(sigma),  0;
           0,           0,           1];
    
    QxX = transpose(QXx);

    % inertial position state vector [km]
    spacecraft_position = QxX * r_x;

end
