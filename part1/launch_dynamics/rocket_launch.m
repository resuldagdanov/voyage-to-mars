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
y_in = [eps, gamma * deg2rad, eps, eps, eps, eps];

% call to Runge-Kutta numerical integrator to solve df/dt = f(t)
[t, func] = runge_kutta_fehlberg(@dynamic_motion, [0, t_burn], y_in);

% initial launching vehicle dry mass with payload
m = m_0 - m_P;




