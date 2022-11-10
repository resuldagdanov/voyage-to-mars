%%
%
% =========================================================================
% **************  Dynamic Motion Equations of Rocket Launch   *************
% =========================================================================
% Arguments:
% - t_step: time in seconds at a specific point
% - y_value: ordinary differential equation vector values
% Returns:
% - dy_dt: time derivative of the equations of motion
%
%%

function dy_dt = dynamic_motion(t_step, y_value)
    configs;

    % initialize dydt as a column vector
    dy_dt = zeros(length(y_value), 1);

    % velocity
    v = y_value(1); % [m/s]

    % flight path angle
    gamma = y_value(2); % [rad]

    % downrange distance
    x = y_value(3); % [m]

    % altitude
    h = y_value(4); % [m]

    % velocity loss due to drag
    v_D = y_value(5); % [m/s]

    % velocity loss due to gravity
    v_G = y_value(6); % [m/s]

    % thrust mass flow rate equal to zero when time t exceeds the burn time
    if t_step < t_burn
        % current total rocket vehicle mass with payload
        m = m_0 - (m_dot * t_step); % [kg]
    else
        % final total rocket vehicle mass with payload
        m = m_0 - (m_dot * t_burn); % [kg]
        T = 0;
    end
    
    % varying acceleration of gravity w.r.t altitude (Eq.1.36)
    g = g_0 / ((1 + (h / R_E))^2); % [m/s^2]

    % varying atmospheric exponential density
    rho = rho_0 * exp(-(h / h_scale)); % [kg/m^3]

    % drag force due to atmospheric density (Eq.13.1)
    D = 0.5 * (rho * (v^2)) * (A * C_D); % [N]

    % velocity derivative (Eq.13.6)
    v_dot = (T / m) - (D / m) - (g * sin(gamma)); % [m/s^2]
    
    % flight path angle derivative (Eq.13.7)
    gamma_dot = -(1 / v) * (g - (v^2 / (R_E + h))) * cos(gamma);
    
    % downrage motion derivative (Eq.13.81)
    x_dot = (R_E / (R_E + h)) * v * cos(gamma); % [m/s]
    
    % altitude motion derivative (Eq.13.82)
    h_dot = v * sin(gamma); % [m/s]

    % gravity loss deceleration
    v_G_dot = -g * sin(gamma); % [m/s^2]

    % deceleration due to drag
    v_D_dot = -D / m; % [m/s^2]

    % load the first derivatives of y(t) into the vector dydt
    dy_dt(1) = v_dot;
    dy_dt(2) = gamma_dot;
    dy_dt(3) = x_dot;
    dy_dt(4) = h_dot;
    dy_dt(5) = v_D_dot;
    dy_dt(6) = v_G_dot;

end
