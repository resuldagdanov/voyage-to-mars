%%
%
% =========================================================================
% ***************   Depart from Earth Sphere of Influence   ***************
% =========================================================================
% Description:
% - tables and equations are taken from reference book of Howard D. Curtis
% - escape from sphere of influence (SOI) with hyperbolic trajectory
% - heliocentric velocity of the spacecraft should be parallel to asymptote
% - spacecraft velocity should be parallel to Earth's heliocentric velocity
% - Hohmann transfer delta V should allign with the Earth's velocity vector
%
%%

% house-keeping
clear; clc;

% Earth circular parking orbit altitude is given as 500km from sea-level
altitude = 500; % [km]

% specific impulse of the spacecraft at Earth parking orbit (assumption)
I_sp = 321; % [s]

% conduct a hyperbolic trajectory from parking orbit to Earth SOI
information = hyperbolic_trajectory(altitude, I_sp);

% print-out results from conducting a hyperbolic trajectory maneuver
display_results(information)

%%

function display_results(information)

    fprintf("\n\n –––––––––––––––––––––––––––––––––––\n")
    fprintf("\n At Hyperbolic Departure Orbit:")
    
    fprintf("\n Hyperbolic Excess Speed = %10.5f km/s", information(1))
    fprintf("\n Vehicle Parking Orbit Speed = %10.5f km/s", information(2))
    fprintf("\n Required Departure Delta-V = %10.5f km/s", information(3))
    fprintf("\n Beta Angle of Hyperbola = %10.5f deg", information(4))
    fprintf("\n Propellant to Spacecraft Mass = %10.5f", information(5))
    fprintf("\n Eccentricity of Hyperbola = %10.5f", information(6))
    fprintf("\n Angular Momentum = %10.5f km^2/s", information(7))
    fprintf("\n Asymptote True Anomaly = %10.5f deg", information(8))
    fprintf("\n Earth SOI True Anomaly = %10.5f deg", information(9))
    fprintf("\n Hyperbola Eccentric Anomaly = %10.5f deg", information(10))
    fprintf("\n Hyperbola Mean Anomaly = %10.5f rad", information(11))
    fprintf("\n Time Passed Until Ariving SOI = %10.5f s", information(12))
    
    fprintf("\n\n –––––––––––––––––––––––––––––––––––\n")

    fprintf("\n Based on Flight Duration of = %10.5f s:\n", 273086.80638)
    fprintf("\n Days = %10.0f d", 3)
    fprintf("\n Hours = %10.0f h", 3)
    fprintf("\n Minutes = %10.0f m", 51)
    fprintf("\n Seconds = %10.0f s\n", 27)

end
