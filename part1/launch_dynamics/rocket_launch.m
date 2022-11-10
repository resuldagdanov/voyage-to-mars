%%
%
% =========================================================================
% ************   Main Script for Launch Vehicle Construction   ************
% =========================================================================
% Description:
% - calculation equations are taken from reference book of Howard D. Curtis
% - 1-stage launch vehicle is choosen to be constructed
% - configuration parameters are choosen to satisfy project requirements
% - plots results for visualization
% - run this script as a main code in calculation of followings:
%   - burnout velocity after stage-2
%   - altitude of the payload after final burnout
%
%%

% house-keeping
clear; clc;

% store all predefined configurations in workspace
configs;

% initial conditions vector (Eq.13.27)
y_in = [eps; gamma * deg2rad; eps; eps; eps; eps];

% call to Runge-Kutta numerical integrator to solve df/dt = f(t)
[t, func] = runge_kutta_fehlberg(@dynamic_motion, [0, t_burn], y_in);

% velocity list until burnout
v = func(:, 1) * 1.e-3; % [km/s]

% flight path angle list until burnout
gamma = func(:, 2) / deg2rad; % [deg]

% downrange distance list until burnout
x = func(:, 3) * 1.e-3; % [km]

% altitude list until burnout
h = func(:, 4) * 1.e-3; % [km]

% list of velocity loss due to drag until burnout
v_D = -func(:, 5) * 1.e-3; % [km/s]

% list of velocity loss due to gravity until burnout
v_G = -func(:, 6) * 1.e-3; % [km/s]

% printing results at final burnout
display_results([v(end), gamma(end), x(end), h(end), v_D(end), v_G(end)])




