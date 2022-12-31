
function light_switch = line_of_sight(spacecraft_position, sun_position)

    % Mars radius [km]
    RM = 6378;
    
    % satellite and sun position vector norms in the Mars inertial frame
    spacecraft_norm = norm(spacecraft_position);
    sun_norm = norm(sun_position);
    
    % angle between sun and satellite position vectors
    theta = acosd(dot(spacecraft_position, sun_position) / ...
                      (spacecraft_norm * sun_norm));
    
    % angle between the satellite position vector and the radial to the
    % point of tangency with the earth of a line from the satellite
    theta_sc = acosd(RM / spacecraft_norm);
    
    % angle between the sun position vector and the radial to the point
    % of tangency with the Mars of a line from the sun
    theta_sun = acosd(RM / sun_norm);
    
    % determine whether a line from the sun to the spacecraft
    if theta_sc + theta_sun < theta
        light_switch = 0; % yes
    else
        light_switch = 1; % no
    end
end
