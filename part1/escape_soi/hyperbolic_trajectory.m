%%
%
% =========================================================================
% *****  Hyperbolic Trajectory from Earth Parking Orbit to Earth SOI   ****
% =========================================================================
% Arguments:
% - altitude: Earth parking orbit altitude from sea-level
% - I_sp: specific impulse of the spacecraft to get to hyperbolic orbit
% Returns:
% - information: list of results on conducting a hyperbolic trajectory
%
%%

function information = hyperbolic_trajectory(altitude, I_sp)
    
    % convert degrees to radians
    deg2_rad = pi / 180;

    % gravitational parameters of the Earth and the Sun (Table.A.2)
    mu_earth = 398600; % [km^3/s^2]
    mu_sun = 1.32712440018e11; % [km^3/s^2]
    
    % orbital radii of the Earth and the Mars (Table.A.1)
    R_E = 149.6e6; % [km]
    R_M = 227.9e6; % [km]

    % radius of a planet Earth (Table.A.1) 
    earth_radius = 6378; % [km]

    % sphere of influence radius of Earth (Table.A.2)
    earth_soi = 925000; % [km]

    % gravitational acceleration constant
    g_0 = 9.81 * 1.e-3; % [km/s^2]

    % hyperbolic excess speed of the Earth departure hyperbola (Eq.8.35)
    v_inf = sqrt((mu_sun/R_E)) * (sqrt((2*R_M) / (R_E + R_M))-1); % [km/s]
    
    % speed of the spacecraft in circular parking orbit (Eq.8.41)
    v_circular = sqrt(mu_earth / (earth_radius + altitude)); % [km/s]
    
    % delta-v required to step up to the departure hyperbola (Eq.8.42)
    delta_v = v_circular * (sqrt(2 + (v_inf / v_circular)^2) - 1); % [km/s]
    
    % perigee of a departure hyperbola w.r.t the Earth velocity vector
    beta = acos(1 / (1 + (((earth_radius + altitude) * v_inf^2) / ...
                                           mu_earth))) / deg2_rad; % [deg]
    
    % ratio of required propellant mass to the spacecraft mass (Eq.6.1)
    m_ratio = 1 - exp(-delta_v / (I_sp * g_0));
    
    % calculate eccentricity e>1 of the hyperbolic orbit (Eq.2.99)
    eccentricity = 1 / cos(beta * deg2_rad);
    
    % angular momentum at the perigee point of hyperbolic orbit (Eq.2.31)
    momentum = (earth_radius + altitude)*(v_circular + delta_v); % [km^2/s]
    
    % true anomaly of the asymptote of the hyperbola (Eq.2.97)
    true_anomaly_inf = acos(-1 / eccentricity) / deg2_rad; % [deg]
    
    % using orbit equation for reaching SOI radius is calculated
    true_anomaly_soi = acos(((momentum^2) / ...
                             (mu_earth * earth_soi) - 1) / ...
                             eccentricity) / deg2_rad; % [deg]
    
    % hyperbolic eccentric anomaly from perigee to reach SOI (Eq.3.44a) (F)
    eccentric_anomaly = (2 * atanh((sqrt((eccentricity - 1) / ...
                        (eccentricity + 1))) * tan((true_anomaly_soi / ...
                         2) * deg2_rad))) / deg2_rad; % [deg]
    
    % mean anomaly is calculated with Kepler's equation for hyperbola (M)
    mean_anomaly = (((eccentricity * sinh(eccentric_anomaly * ...
                      deg2_rad)) - (eccentric_anomaly*deg2_rad))); % [rad]
    
    % time passed from hyperbolic perigee to reach SOI radius (Eq.3.34)
    t_hyperbola = ((momentum^3) / (mu_earth^2)) * (mean_anomaly / ...
                                  ((eccentricity^2) - 1)^(3/2)) ; % [s]

    % compacting all required information about hyperbolic departure
    information = [v_inf, v_circular, delta_v, beta, m_ratio, ...
                   eccentricity, momentum, true_anomaly_inf, ...
                   true_anomaly_soi, eccentric_anomaly, mean_anomaly, ...
                   t_hyperbola];

end
