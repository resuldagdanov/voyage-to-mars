%%
%
% =========================================================================
% *******************   Determine Launch Date & Time   ********************
% =========================================================================
% Description:
% - calculation equations are taken from reference book of Howard D. Curtis
% - orbital ephemeris information is used to calculate planetary positions
% - earth and mars orbits are assumed to have circular orbits
% - both earth and mars planets lay on the same plane with inclination zero
% - true anomaly has to be 45 degrees for Hohmann transfer to initialize
% - date and time of launch are determined by trial and errors
% - following launch date is assumed to be selected to satisfy true anomaly
%
%%

% house-keeping
clear; clc;

% launch date + time to reach parking orbit + duration until escaping SOI 
year_ = 2023;
month_ = 5;
day_ = 11;
hour_ = 11;
minute_ = 11;
second_ = 11;

% compact form of selected launch date and time
date_time = [year_, month_, day_, hour_, minute_, second_];

% get orbital elements for lunching from planet Earth to planet Mars
values_Earth = compute_anomaly(date_time, "Earth");
values_Mars = compute_anomaly(date_time, "Mars");

% Earth and Mars true anomalies with respect to Sun
true_anomaly_E = values_Earth(8); % [deg]
true_anomaly_M = values_Mars(8); % [deg]

% printing planetary orbital elements for selected date-time
display_results(values_Earth, "Earth")
display_results(values_Mars, "Mars")

fprintf("\n True Anomaly Before Hohmann Transfer Started = %10.5f deg\n", ...
        true_anomaly_M - true_anomaly_E)

%%

function display_results(values, planet_name)

    fprintf("\n\n –––––––––––––––––––––––––––––––––––\n")
    fprintf("\n For Planetary Orbit:")
    
    fprintf("\n Planet Name = %s", planet_name)
    fprintf("\n Semimajor axis (a) = %10.5f km", values(1))
    fprintf("\n Eccentricity (e) = %10.5f", values(2))
    fprintf("\n Angular Momentum (h) = %10.5f km^2/s", values(3))
    fprintf("\n Longitude Perihelion (w) = %10.5f deg", values(4))
    fprintf("\n Mean Longitude (L) = %10.5f deg", values(5))
    fprintf("\n Eccentric Anomaly (E) = %10.5f deg", values(6))
    fprintf("\n Mean Anomaly (M) = %10.5f deg", values(7))
    fprintf("\n True Anomaly w.r.t Sun (O) = %10.5f deg", values(8))
    
    fprintf("\n\n –––––––––––––––––––––––––––––––––––\n")

end
