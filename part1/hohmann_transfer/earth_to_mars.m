%%
%
% =========================================================================
% ****************   Hohmann Transfer From Earth to Mars   ****************
% =========================================================================
% Description:
% - apply Hohmann transfer maneuver when spacecraft is at Earth SOI radius
% - calculate delta-v required to initialize eliptical transfer orbit
% - finish Hohmann transfer maneuver at Mars SOI radius
% - Earth and Mars orbits are assumed to be coplanar
% - Earth and Mars orbits are assumed to be heliocentric circular orbits
% - assumed that both Earth and Mars have zero orbital inclinations
%
%%

% house-keeping
clear; clc;

% store all predefined configurations in workspace
parameters;

% speed of the spacecraft at Earth SOI location (Eq.8.1)
V_1 = sqrt(mu_sun / R_E); % [km/s]

% speed at Mars capture orbit (at Mars SOI radius) (Eq.8.1)
V_2 = sqrt(mu_sun / R_M); % [km/s]

% semimajor axis of Hohmann transfer ellipse (Eq.2.71) (a)
semimajor = (1 / 2) * (R_E + R_M); % [km]

% spacecraft heliocentric velocity at the Earth departure point (Eq.8.2)
V_departure = sqrt(mu_sun * ((2 / R_E) - (1 / semimajor))); % [km/s]

% required delta-v to transfer to Hohmann transfer orbit (Eq.8.3)
delta_V_earth = V_departure - V_1; % [km/s]

% NOTE:
% it is obvious that delta_V_earth == v_inf : hyperbolic excess speed is 
% equal to difference of departure velocity and parking orbit velocity

% time required for the Hohmann transfer period is addapted from (Eq.2.83)
hohmann_time = (pi / sqrt(mu_sun)) * ((R_E + R_M) / 2)^(3 / 2); % [s]

fprintf("\n\n –––––––––––––––––––––––––––––––––––\n")
fprintf("\n At Earth SOI:")

fprintf("\n Hyperbolic Excess Speed = %10.5f km/s", delta_V_earth)
fprintf("\n Spacecraft Speed for Hohmann = %10.5f km/s", V_departure)
fprintf("\n Spacecraft Speed at Mars Capture Orbit = %10.5f km/s", V_2)
fprintf("\n Semimajor Axis of Hohmann Transfer = %10.5f km", semimajor)
fprintf("\n Elapsed Time During Hohmann to Mars = %10.5f s", hohmann_time)

% spacecraft heliocentric velocity at the Mars arrival point (Eq.8.2)
V_arrival = sqrt(mu_sun * ((2 / R_M) - (1 / semimajor))); % [km/s]

% hyperbolic excess speed at Mars arrival hyperbola (Eq.8.35)
v_inf_mars = V_arrival - V_2; % [km/s]

% spacecraft velocity relative to Mars at periapse of approach hyperbola
v_perigee_mars = sqrt((v_inf_mars^2) + ((2 * mu_mars) / ...
                      (mars_radius + mars_parking_altitude))); % [km/s]

% spacecraft parking orbit speed relative to Mars
v_circle_mars = sqrt(mu_mars/(mars_radius+mars_parking_altitude)); % [km/s]

% delta-V required to stay on the given circular orbit of Mars
delta_V_mars = v_circle_mars - v_perigee_mars; % [km/s]

fprintf("\n\n –––––––––––––––––––––––––––––––––––\n")
fprintf("\n At Mars SOI:")

fprintf("\n Hyperbolic Excess Speed = %10.5f km/s", v_inf_mars)
fprintf("\n Spacecraft Speed after Hohmann = %10.5f km/s", V_arrival)
fprintf("\n Spacecraft Speed at Mars Parking = %10.5f km/s", v_circle_mars)
fprintf("\n Periapse of Approach Hyperbola = %10.5f km/s", v_perigee_mars)
fprintf("\n Delta-V Required to Stay on Mars = %10.5f km/s", delta_V_mars)
fprintf("\n Elapsed Time in Hohmann to Earth = %10.5f s", hohmann_time)

fprintf("\n\n –––––––––––––––––––––––––––––––––––\n")

fprintf("\n Based on Hohmann Duration of = %10.5f s:\n", 22362713.30644)
fprintf("\n Days = %10.0f d", 258)
fprintf("\n Hours = %10.0f h", 19)
fprintf("\n Minutes = %10.0f m", 51)
fprintf("\n Seconds = %10.0f s\n", 53)

% following are arrival date-time at Mars parking orbit
year_arrival = 2024; % 2023
month_arrival = 1; % 5
day_arrival = 24; % 10
hour_arrival = 10; % 15
minute_arrival = 59; % 8
second_arrival = 59; % 6

fprintf("\n –––––––––––––––––––––––––––––––––––\n")
fprintf("\n Arrival Date & Time to Planet Mars:\n")

fprintf("\n Year = %10.0f", year_arrival)
fprintf("\n Month = %10.0f", month_arrival)
fprintf("\n Day = %10.0f", day_arrival)
fprintf("\n Hour = %10.0f h", hour_arrival)
fprintf("\n Minute = %10.0f m", minute_arrival)
fprintf("\n Second = %10.0f s\n", second_arrival)
