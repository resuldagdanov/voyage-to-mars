%%
%
% =========================================================================
% ****************   Hohmann Transfer From Mars to Earth   ****************
% =========================================================================
% Description:
% - apply Hohmann transfer maneuver when spacecraft is at Mars SOI radius
% - calculate delta-v required to initialize eliptical transfer orbit
% - finish Hohmann transfer maneuver at Earth parking radius orbit
% - Earth and Mars orbits are assumed to be coplanar
% - Earth and Mars orbits are assumed to be heliocentric circular orbits
% - assumed that both Earth and Mars have zero orbital inclinations
% - calculate waiting duration until next departure from Mars to Earth
% - got Hohmann transfer duration to get arrival date-time to Mars parking
%
%%

% house-keeping
clear; clc;

% store all predefined configurations in workspace
parameters;

% from script "earth_to_mars", Hohmann transfer duration is computed
hohmann_time = 22362713.30644; % [s]

% speed of the spacecraft at Earth SOI location (Eq.8.1)
V_E = sqrt(mu_sun / R_E); % [km/s]

% speed at Mars capture orbit (at Mars SOI radius) (Eq.8.1)
V_M = sqrt(mu_sun / R_M); % [km/s]

% semimajor axis of Hohmann transfer ellipse (Eq.2.71) (a)
semimajor = (1 / 2) * (R_E + R_M); % [km]

% Earth planet angular velocity - circular orbit assumption (n2) (Eq.7.61)
angular_v_earth = V_E / R_E; % [rad/s]

% Mars planet angular velocity - circular orbit assumption (n2) (Eq.7.61)
angular_v_mars = V_M / R_M; % [rad/s]

% initial phase angle between Earth and Mars (Eq.8.12)
phi_0 = pi - (angular_v_mars * hohmann_time); % [rad]

% final phase angle between Earth and Mars when arrival to Mars (Eq.8.13)
phi_f = phi_0 + ((angular_v_mars - angular_v_earth)*hohmann_time); % [rad]

% waiting time until departure from Mars to Earth (Eq.8.15)
if angular_v_earth > angular_v_mars
    wait_time = ((-2 * phi_f) - (2 * pi)) / ...
                 (angular_v_mars - angular_v_earth); % [s]
else
    wait_time = ((-2 * phi_f) + (2 * pi)) / ...
                 (angular_v_mars - angular_v_earth); % [s]
end

fprintf("\n\n –––––––––––––––––––––––––––––––––––\n")

fprintf("\n Initial Phase Between Planets = %10.5f deg", phi_0 / deg2_rad)
fprintf("\n Final Phase Between Planets = %10.5f deg", phi_f / deg2_rad)
fprintf("\n Waiting Duration on Mars Orbit = %10.5f s", wait_time)

fprintf("\n\n –––––––––––––––––––––––––––––––––––\n")

fprintf("\n Based on Waiting Time of = %10.5f s:\n", 39286373.02635)
fprintf("\n Years = %10.0f y (365 days)", 1)
fprintf("\n Days = %10.0f d", 89)
fprintf("\n Hours = %10.0f h", 16)
fprintf("\n Minutes = %10.0f m", 52)
fprintf("\n Seconds = %10.0f s\n", 53)

% launch date from Mars to Earth is computed from previously computed data
year_departure = 2025;
month_departure = 4;
day_departure = 25;
hour_departure = 2;
minute_departure = 52;
second_departure = 46;

fprintf("\n –––––––––––––––––––––––––––––––––––\n")
fprintf("\n Departure Date & Time to Planet Mars:\n")

fprintf("\n Year = %10.0f", year_departure)
fprintf("\n Month = %10.0f", month_departure)
fprintf("\n Day = %10.0f", day_departure)
fprintf("\n Hour = %10.0f h", hour_departure)
fprintf("\n Minute = %10.0f m", minute_departure)
fprintf("\n Second = %10.0f s\n", second_departure)
