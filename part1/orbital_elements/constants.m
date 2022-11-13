%%
%
% =========================================================================
% *****   Configuration Parameters of Earth Parking Orbit Selection   *****
% =========================================================================
% Description:
% - determination of launch site coordinates
% - parameters are taken from the book in references
% - parking orbit altitude is required to be 500km
%
%%

% Earth and Mars inclination angles (Table.A.1)
inclination_E = 23.45; % [deg]
inclination_M = 25.19; % [deg]
% Note:
% in this project, inclinations are assumed to be the same for planets

% convert degrees to radians
deg2_rad = pi / 180;

% gravitational parameter of Earth (Table.A.2)
mu = 398600; % [km^3/s^2]

% radius of a planet Earth (Table.A.1) 
R_E = 6378; % [km]

% second zonal harmonics of Earth (Table.4.3)
J2_E = 1.08263 * 1.e-3;

% height of the selected parking orbit from Earth sea-level
altitude = 500; % [km]

% semimajor axis of the circular orbit
a = R_E + altitude; % [km]
