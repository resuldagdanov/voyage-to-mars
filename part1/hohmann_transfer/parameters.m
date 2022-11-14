%%
%
% =========================================================================
% ******   Configuration Parameters for Applying Hohmann Transfer   *******
% =========================================================================
% Description:
% - general parameters of the interplanetary transfer
% - rocket launch duration to Earth parking orbit is determined previously
%
%%

% convert degrees to radians
deg2_rad = pi / 180;

% gravitational parameters of the Earth, the Mars, and the Sun (Table.A.2)
mu_earth = 398600; % [km^3/s^2]
mu_mars = 42828; % [km^3/s^2]
mu_sun = 1.32712440018e11; % [km^3/s^2]

% orbital radii of the Earth and the Mars (Table.A.1)
R_E = 149.6e6; % [km]
R_M = 227.9e6; % [km]

% radius of a planet Earth and a planet Mars (Table.A.1) 
earth_radius = 6378; % [km]
mars_radius = 3396; % [km]

% sphere of influence radius of the Earth and the Mars (Table.A.2)
earth_soi = 925000; % [km]
mars_soi = 577000; % [km]

% altitude from ground at Mars parking orbit (given in this project)
mars_parking_altitude = 300; % [km]
