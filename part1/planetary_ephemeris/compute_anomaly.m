%%
%
% =========================================================================
% *************  Calculate True Anomaly of Planets w.r.t Sun   ************
% =========================================================================
% Arguments:
% - date_time: time to start Hohmann transfer maneuver
% - planet_name: planet from or to which planet orbital transfer is done
% Returns:
% - values: planeraty orbital elements and true anomaly for given date-time
%
%%

function values = compute_anomaly(date_time, planet_name)

    % extract date and time to start Hohmann transfer maneuver
    year_ = date_time(1);
    month_ = date_time(2);
    day_ = date_time(3);
    hour_ = date_time(4);
    minute_ = date_time(5);
    second_ = date_time(6);

    % convert degrees to radians
    deg2_rad = pi / 180;
    
    % gravitational parameter of Earth (Table.A.2)
    mu = 398600; % [km^3/s^2]
    
    % calculat Julian day (Eq.5.48)
    J_0 = julian_day(year_, month_, day_);
    
    % include hour-minute-second to Julian number
    U_T = (hour_ + (minute_ / 60) + (second_ / 3600)) / 24;
    
    % apply (Eq.5.47) to calculate precise Julian day number
    J_D = J_0 + U_T;
    
    % obtain data for the selected planet from (Table 8.1) with assumptions
    [J_2000, rates] = planetary_elements(planet_name);
    
    % number of Julian centuries between J2000 and the date (Eq.8.93a)
    T_0 = (J_D - 2451545) / 36525;
    
    % planetary orbital elements in (Table.8.1) for date-time (Eq.8.93b)
    elements = J_2000 + (rates * T_0);
    
    % semimajor axis of the planetary orbit for selected planet at J_D (a)
    semimajor = elements(1); % [km]
    
    % eccentricity of the planetary orbit for selected planet at J_D (e)
    eccentricity = elements(2);
    
    % calculate planetary angular momentum (Eq.2.71) (h)
    momentum = sqrt(mu * semimajor * (1 - eccentricity^2)); % [km^2/s]
    
    % reduce the longitude of perihelion to the range 0-360 deg (w_hat)
    longitude_perihelion = zero_to_360(elements(5)); % [deg]
    
    % reduce the mean longitude to within the range 0 - 360 degrees (L)
    mean_longitude = zero_to_360(elements(6)); % [deg]
    
    % reduce the mean anomaly to within the range 0 - 360 degrees (M)
    mean_anomaly = zero_to_360((mean_longitude - longitude_perihelion));
    
    % calculate Kepler'e equation for eccentric anomaly (Algorithm 3.1) (E)
    eccentric_anomaly = kepler_equation(eccentricity, ...
                                       (mean_anomaly * deg2_rad));
    
    % calculate planetary true anomaly in degrees (Eq.3.13) (theta)
    true_anomaly = zero_to_360(2 * atan(sqrt((1 + eccentricity) / ...
                   (1 - eccentricity)) * tan(eccentric_anomaly / 2)) / ...
                   deg2_rad); % [deg]
    
    % print-out obtained results
    values = [semimajor, eccentricity, momentum, longitude_perihelion, ...
            mean_longitude, eccentric_anomaly, mean_anomaly, true_anomaly];
    
    function y = zero_to_360(x)
        if x >= 360
            x = x - fix(x / 360) * 360;
        elseif x < 0
            x = x - (fix(x / 360) - 1) * 360;
        end
            y = x;
    end

end
