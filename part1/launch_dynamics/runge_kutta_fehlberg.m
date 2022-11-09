%%
%
% =========================================================================
% **********   Runge-Kutta-Fehlberg 4(5) Integration Algorithm   **********
% =========================================================================
% Arguments:
% - ode_func: ordinary differential equation function
% - t_range: time interval of integration
% - y_in: initail vector of values to be integrated size(1, 6)
% Returns:
% - t_out: time of each step calculation
% - y_out: matrix of integrated results size(6, t_out)
%
%%

function [t_out, y_out] = runge_kutta_fehlberg(ode_func, t_range, y_in)
    
    % fehlberg coefficients for locating nodes within each time interval
    a = [0, 1/4, 3/8, 12/13, 1, 1/2];

    % coupling coefficients for computing derivative at each interior point
    b = [ 0,         0,          0,            0,            0;
          1/4,       0,          0,            0,            0;
          3/32,      9/32,       0,            0,            0;
          1932/2197, -7200/2197, 7296/2197,    0,            0;
          439/216,   -8,         3680/513     -845/4104,     0;
         -8/27,       2,        -3544/2565,    1859/4104,   -11/40 ];

    % fehlberg coefficients for the fourth-order solution
    c_4 = [25/216, 0, 1408/2565, 2197/4104, -1/5, 0];

    % fehlberg coefficients for the fifth-order solution
    c_5 = [16/135, 0, 6656/12825, 28561/56430, -9/50, 2/55];

    % initial and final time of total launch
    t_0 = t_range(1);
    t_f = t_range(2);

    % assumed initial time step
    h = (t_range(2) - t_range(1)) / 100;
    
    % initialize function variables and timestep
    t = t_0;
    y = y_in;
    t_out = t;
    y_out = y';

    % loop until final time is not reached
    while t < t_f

        % the smallest number such that x + eps(x) = x 
        h_min = 16 * eps(t);

        % incremental time and function variables
        t_i = t;
        y_i = y;

        % evaluate the time derivative(s) at each points
        for i = 1:length(y_in)
            t_inner = t_i + (a(i) * h);
            y_inner = y_i;
            
            % get next step point
            for j = 1:i-1
                y_inner = y_inner + (h * b(i, j) * func(:, j));
            end
            
            % apply function for each interior point
            func(:, i) = feval(ode_func, t_inner, y_inner);
        end

        % difference between 4th and 5th order solutions
        truncated_error = h * func * (c_4' - c_5');

        % compute the maximum truncation error
        max_trunc_error = max(abs(truncated_error));

        % compute the allowable truncation error
        allow_trunc_error = max(max(abs(y)), 1.0);

        %...Compute the fractional change in step size:
        delta = (allow_trunc_error / (max_trunc_error + eps))^(1/5);

        % when the truncation error is in bounds, then update the solution
        if max_trunc_error <= allow_trunc_error
            h = min(h, t_f - t);
            t = t + h;
            y = y_i + h * func * c_5';
            t_out = [t_out; t];
            y_out = [y_out; y'];
        end

        % update the time step
        h = min(delta * h, 4 * h);

        if h < h_min
            return
        end
    
    end

end
