%%
%
% =========================================================================
% **************   Calculate Earth Parking Orbital Elements   *************
% =========================================================================
% Description:
% - calculation equations are taken from reference book of Howard D. Curtis
% - azimuth angle of the launch platform is selected arbitrary
% - sun-synchronous orbit is choosen for simplicity
% - major orbital elements are printed
% - required latitude of launch platform is determined
% - expected to have orbital inclination close to 90 degrees
%
%%

% house-keeping
clear; clc;

% azimuth angle of launch site (could be anything for the project)
longitude = 279.3489; % [deg]

% get orbital elements for specific launch to sun-syncronous orbit
[h, sigma_dot, i, latitude, period] = orbital_elements(longitude);

% printing orbital elements
display_results([h, sigma_dot, i, latitude, longitude, period]);

%%

function [h, sigma_dot, i, latitude, period] = orbital_elements(longitude)

    % store all predefined configurations in workspace
    constants;
    
    % angular momentum in Earth circular orbit as eccentricity=0 (Eq.2.62)
    h = sqrt(mu * (R_E + altitude)); % [km^2/s]
    
    % sun-synchronous orbit derivative of right ascension of ascending node
    sigma_dot = (2 * pi) / (365.26 * 24* 3600); % [rad/s]

    % inclination of the Earth parking sun-synchronous orbit (Eq.4.52)
    i = acos(-(2 * sigma_dot * a^(7/2)) / ...
            (3 * sqrt(mu) * J2_E * R_E^2)) / deg2_rad; % [deg]
    
    % orbital inclination is based on launch azimuth and latitude (Eq.6.24)
    latitude = acos(cos(i * deg2_rad) / ...
               sin(longitude * deg2_rad)) / deg2_rad; % [deg]
    
    % time period of the circular orbit (Eq.2.64)
    period = ((2 * pi) / (sqrt(mu))) * (R_E + altitude)^(3/2); % [s]

end

%%

function display_results(elements)

    fprintf("\n\n –––––––––––––––––––––––––––––––––––\n")
    fprintf("\n At Sun-Synchronous Orbit:")
    
    fprintf("\n Specific Angular Momentum = %10.3f km^2/s", elements(1))
    fprintf("\n Rate of Ascending Node = %10.12f rad/s ", elements(2))
    fprintf("\n Orbital Inclination = %10.3f deg ", elements(3))
    fprintf("\n Launch Platform Latitude Angle = %10.3f deg ", elements(4))
    fprintf("\n Launch Platform Azimuth Angle = %10.3f deg", elements(5))
    fprintf("\n Orbital Period = %10.3f s", elements(6))
    
    fprintf("\n\n –––––––––––––––––––––––––––––––––––\n")

end
