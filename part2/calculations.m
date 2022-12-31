
% house-keeping
clear; clc; close all;

% at Mars parking orbit
year_ = 2024;
month_ = 1;
day_ = 24;
hour_ = 10;
minute_ = 59;
second_ = 59;

% Case 1 and Case 2 of the Project Part 2
is_rate_gyro = 1;

% sampling time [sec]
dt = 1;

% convert from degrees to radians
deg2_rad =  pi / 180;

% calculate Julian day (Eq.5.48)
J_0 = julian_day(year_, month_, day_);

% include hour-minute-second to Julian number
U_T = (hour_ + (minute_ / 60) + (second_ / 3600)) / 24;

% apply (Eq.5.47) to calculate precise Julian day number
J_D = J_0 + U_T;

% time passed in seconds
time = 0.0;

% theta angle [deg]
true_anomaly = 200.0;

% initial sun position vector in inertial frame [deg - deg - km]
[lamda, eps, sun_position] = solar_position(J_D);

% orbital period [s] and spacecraft state vector in inertial frame [km]
[spacecraft_position, period] = vehicle_position(time, true_anomaly);

% total number of estimated measurements of EKF
number_of_measurements = ceil(period);

% determining whether the satellite is in a shadow of Mars (Algorithm 10.3)
is_los = line_of_sight(spacecraft_position, sun_position);

% initial euler angles for DC from orbital frame to body frame [rad]
euler_angles = [0; 0; 0] * deg2_rad;

% standard deviation of process noise (given)
process_std = 0.017;

% standard deviation of measurement noise (given) [CSS]
measurement_std = 0.001;

% standard deviation of rate-gyre sensor reading noise (given) [RG]
RG_std = 1e-3;

% initial rate-gyro sensor measurements (given) [rad/s]
w_0_rad = [-0.1, 0.5, 0.5] * deg2_rad;
w_rad = w_0_rad;

% initial covariance estimation (given)
P = diag([1, 1, 1]);

% initial state estimate (given)
x = [0, 0, 1]';

% process noise covariance (given)
Q = eye(3) * process_std^2;

% measurement noise covariance (given)
R = eye(8) * measurement_std^2;

% state transition matrix
F = eye(3);

% true anomaly change at every delta time
anomaly_increment = (360 * dt) / period;

% collect measurements for one orbital period
z = [];
z_meas = [];
times = [];
true_anomalies = [];
shadow_anomalies = [];
shadow_idx = 0;

estimated_states = [];
true_directions = [];
angle_between_true_estimated = [];
angle_between_true_measured = [];
active_CSSes = [];

inning = 0;

% delta time is considered 1 second (k -> time in seconds)
for k = 1 : number_of_measurements
    time = time + dt;
    times(k) = time;

    true_anomaly = mod(true_anomaly + anomaly_increment, 360);
    true_anomalies(k) = true_anomaly;

    % correct time of Julian date
    if second_ + dt >= 60
        second_ = 0;
        minute_ = minute_ + 1;
    else
        second_ = second_ + dt;
    end

    if minute_ >= 60
        minute_ = 0;
        hour_ = hour_ + 1;
    end

    % include hour-minute-second to Julian number
    U_T = (hour_ + (minute_ / 60) + (second_ / 3600)) / 24;
    
    % apply (Eq.5.47) to calculate precise Julian day number
    J_D = J_0 + U_T;

    % sun position vector in inertial frame [deg - deg - km]
    [lamda, eps, sun_position] = solar_position(J_D);
    
    % orbital period [s] and spacecraft state vector in inertial frame [km]
    [spacecraft_position, period] = vehicle_position(time, true_anomaly);

    % sun direction vector in orbital frame [km]
    sun_direction = inertial_to_orbital(sun_position, spacecraft_position);

    % checking when the spacecraft is at the shadow to Mars
    is_los = line_of_sight(spacecraft_position, sun_position);
    if is_los == 0
        shadow_idx = shadow_idx + 1;
        shadow_times(shadow_idx) = time;
        shadow_anomalies(shadow_idx) = true_anomaly;
        inning = 1;
    end

    if inning == 1 && is_los == 1
        if k == shadow_times(end)
            k = k + 100;
        end
    end

    % sun direction vector with respect to body frame [km] "X_k Function"
    true_sun_direction = orbital_to_body(euler_angles, ...
                                         sun_direction);
    state_vector = true_sun_direction; % x (3x1)
    
    % get sun-sensor readings (measurements) "Y_k Function"
    [CSS, CSS_meas, H, available_css] = sun_sensors(true_sun_direction, ...
                                          measurement_std);
    measurement_vector = CSS; % y (8x1)
    meas_vector = CSS_meas; % y_meas (8x3)
    
    % get rate-gyro sensor readings (measurements) [rad/s]
    if is_rate_gyro
        w = rate_gyros(w_rad, RG_std);
        w_rad = w;
    end

    % update measured euler angles
    euler_angles = w_rad * dt;

    % store measurement vectors
    z(k, :) = measurement_vector; % (8x1)
    z_meas(k, :, :) = meas_vector; % (8x3)

    % store correcly calculated Sun direction vector in body frame
    true_directions(k, :) = true_sun_direction;

end

for_error_estimation_x = [];
for_error_estimation_y = [];
for_error_estimation_z = [];
for_error_measurement_x = [];
for_error_measurement_y = [];
for_error_measurement_z = [];

% loop through each measurement for EKF estimations
for k = 1 : number_of_measurements

    if k == shadow_times(end)
        k = k + 100;
    end

    % when then spacecraft is in eclipse
    if any(shadow_times(:) == k)
        measurement_vector = zeros(8, 1);
        meas_vector = zeros(1, 3);
        R = zeros(8);
    else
        measurement_vector = z(k, :)';
        meas_vector = true_directions(k, :) + measurement_std*randn(1, 3);
    end

    % apply EKF algorithm to update state estimate
    [x, P] = extended_kalman_filter(F, H, Q, R, x, P, measurement_vector);
    
    % get angle between true sun direction and sun measured direction [deg]
    angle_between_true_measured(k) = ...
        acosd(dot(true_directions(k, :), meas_vector) / ...
        (norm(true_directions(k, :)) * norm(meas_vector)));

    % get angle between true sun direction and estimated direction [deg]
    angle_between_true_estimated(k) = ...
        acosd(dot(true_directions(k, :), x') / ...
        (norm(true_directions(k, :)) * norm(x')));

    % get CSS measurements from each sensor after applying DCM
    css_readings = reshape(z_meas(k, :, :), [8, 3]); % (8x3)

    % store number of active CSS measurements
    n_actives = sum(measurement_vector > 0);
    active_CSSes(k) = n_actives;

    t = x';

    for_error_estimation_x(k, :) = [true_directions(k, 1), t(1)];
    for_error_estimation_y(k, :) = [true_directions(k, 2), t(2)];
    for_error_estimation_z(k, :) = [true_directions(k, 3), t(3)];

    for_error_measurement_x(k, :) = [true_directions(k, 1), meas_vector(1)];
    for_error_measurement_y(k, :) = [true_directions(k, 2), meas_vector(2)];
    for_error_measurement_z(k, :) = [true_directions(k, 3), meas_vector(3)];

end

time_list = 1 : number_of_measurements;

until = find(isnan(for_error_measurement_x(:, 2)));

measurement_rms_error_x = rmse( ...
    for_error_measurement_x(:, 1), ...
    for_error_measurement_x(:, 2));

measurement_rms_error_y = rmse( ...
    for_error_measurement_y(:, 1), ...
    for_error_measurement_y(:, 2));

measurement_rms_error_z = rmse( ...
    for_error_measurement_z(:, 1), ...
    for_error_measurement_z(:, 2));

until = find(isnan(for_error_estimation_x(:, 2)));

estimation_rms_error_x = rmse( ...
    for_error_estimation_x(1:until(1)-1, 1), ...
    for_error_estimation_x(1:until(1)-1, 2));

estimation_rms_error_y = rmse( ...
    for_error_estimation_y(1:until(1)-1, 1), ...
    for_error_estimation_y(1:until(1)-1, 2));

estimation_rms_error_z = rmse( ...
    for_error_estimation_z(1:until(1)-1, 1), ...
    for_error_estimation_z(1:until(1)-1, 2));

if is_rate_gyro
    case_number = "Case 1";
    availability = "Available";
else
    case_number = "Case 2";
    availability = "Not Available";
end

figure(1);
plot(time_list, angle_between_true_measured, "LineWidth", 0.5);
grid on;
title(case_number + " Experiment [ Rate-Gyro Sensor is " + ...
      availability + " ]");
xlabel("Time [seconds]");
ylabel("Angle Between True and Measured Sun Direction Vectors [degrees]");
hold on;
xline(shadow_times(1), "--o", "LineWidth", 2.0, "Color", "red");
xline(shadow_times(end), "--o", "LineWidth", 2.0, "Color", "red");

figure(2);
plot(time_list, angle_between_true_estimated, "LineWidth", 0.5);
grid on;
title(case_number + " Experiment [ Rate-Gyro Sensor is " + ...
      availability + " ]");
xlabel("Time [seconds]");
ylabel("Angle Between True and Estimated Sun Direction Vectors [degrees]");
hold on;
xline(shadow_times(1), "--o", "LineWidth", 2.0, "Color", "red");
xline(shadow_times(end), "--o", "LineWidth", 2.0, "Color", "red");

figure(3);
plot(time_list, active_CSSes, "LineWidth", 0.5);
grid on;
title(case_number + " Experiment [ Rate-Gyro Sensor is " + ...
      availability + " ]");
xlabel("Time [seconds]");
ylabel("Total Number of Active CSS Measurements [#]");
hold on;
xline(shadow_times(1), "--o", "LineWidth", 2.0, "Color", "red");
xline(shadow_times(end), "--o", "LineWidth", 2.0, "Color", "red");

