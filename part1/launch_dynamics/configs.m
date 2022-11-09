%%
%
% =========================================================================
% **********   Launch Vehicle Related Configuration Parameters   **********
% =========================================================================
% Description:
% - general parameters of the rocket launch vehicle
% - parameters are determined by trial and errors
% - burnout altitude is required to be 500km
%
%%

% convert degrees to radians
deg2rad = pi/180;

% launch flight angle between ground horizon
gamma = 90; % [deg]

% radius of a planet Earth
R_E = 6378e3; % [m]

% graviational acceleration at sea level
g_0 = 9.81; % [m/s^2]

% sea level atmospheric density
rho_0 = 1.225; % [kg/m^3]

% scale height of the atmosphere where the density is about 37%
h_scale = 7500; % [m]

% specific impulse of the rocket
I_sp = 321; % [s]

% thrust of the rocket, assumed constant until burnout for both stages
T = 7654e3; % [N]

% drag coefficient
C_D = 0.5;

% rocket diameter
d = 3.7; % [m]

% payload mass
m_PL = 6666; % [kg]

% propellant mass of the rocket
m_P = 543210; % [kg]

% empy mass of the rocket
m_E = 23456; % [kg]

% frontal area of the rocket
A = pi * ((d^2) / 4); % [m^2]

% tandem-stacked launch vehicle before take-off (Eq.13.31)
m_0 = m_E + m_P + m_PL; % [kg]

% thrust to launch vehicle weight ratio
t2w = T / (m_0 * g_0);

% payload ratio (Eq.13.33)
lamda = m_PL / (m_E + m_P);

% structural ratio (Eq.13.34)
epsilon = m_E / (m_E + m_P);

% mass ratio - ratio of the initial mass to final mass (Eq.13.38)
n = (1 + lamda) / (epsilon + lamda);

% final burnout mass of the launch vehicle with payload
m_F = m_0 / n; % [kg]

% fuel flow rate is assumed to be constant as thrust is constant (Eq.13.20)
m_dot = T / (I_sp * g_0); % [kg/s]

% total propellant burning time
t_burn = m_P / m_dot; % [s]

