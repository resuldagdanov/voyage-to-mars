%%
%   Inputs:
%       F: state transition matrix
%       H: observation matrix
%       Q: process noise covariance
%       R: measurement noise covariance
%       x: initial state estimate
%       P: initial covariance estimate
%       z: measurement vector
%
%   Outputs:
%       x_hat: updated state estimate
%       P: updated covariance estimate
%%

function [x_hat, P] = extended_kalman_filter(F, H, Q, R, x, P, z)
    
    % predict state at next time step
    x_hat = F * x; % predicted state
    P = F * P * F' + Q; % predicted covariance

    % compute kalman gain
    S = (H * P * H') + R; % innovation covariance
    K = (P * H') / S; % kalman gain

    % update state estimate using measurement
    x_hat = x_hat + K * (z - H * x_hat); % updated state estimate
    P = (eye(size(P)) - K * H) * P; % updated covariance estimate

end

