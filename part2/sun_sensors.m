
function [CSS, CSS_meas, H, n_s] = sun_sensors(sun_direction, measured_std)
    
    % given euler angles coefficients [rad]
    a = sqrt(2) / 2;
    b = 0.5;

    % sensor orientation on the body frame
    n_11 = [a, -b,  b];
    n_12 = [a, -b, -b];
    n_13 = [a,  b, -b];
    n_14 = [a,  b,  b];

    n_21 = [-a, -b,  b];
    n_22 = [-a, -b, -b];
    n_23 = [-a,  b, -b];
    n_24 = [-a,  b,  b];

    % compuse euler angle positions into one matrix
    n = [n_11;
         n_12;
         n_13;
         n_14;
         n_21;
         n_22;
         n_23;
         n_24];
    H = n;
    n = transpose(n);

    CSS = [];
    CSS_meas = [];

    for idx = 1 : length(n)

        % change orientation of the sensor readings (8x3)
        oriented_measurement = orbital_to_body(n(:, idx), sun_direction);
        
        CSS(idx) = dot(sun_direction, n(:, idx));
        CSS_meas(idx, :) = oriented_measurement';
    end

    [n_sensors, n_s] = size(H);
    available_css = n_s;

    R = eye(available_css) * measured_std^2;
end
