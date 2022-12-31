
function [lamda, eps, sun_position] = solar_position(julian_date)

    % astronomical unit (km)
    AU = 149597870.691;
    
    % Julian days since J2000 (Eq.10.111) from Howard D. Curtis book
    n = julian_date - 2451545;
    
    % Julian centuries since J2000
    cy = n / 36525;
    
    % mean anomaly (deg) (Eq.10.109) from Howard D. Curtis book
    M = 357.528 + (0.9856003 * n);
    M = mod(M, 360);
    
    % mean longitude (deg) (Eq.10.108) from Howard D. Curtis book
    L = 280.459 + (0.98564736 * n);
    L = mod(L, 360);
    
    % apparent ecliptic longitude (deg) (Eq.10.107)
    lamda = L + (1.915 * sind(M)) + (0.020 * sind(2 * M));
    lamda = mod(lamda, 360);
    
    % obliquity of the ecliptic (deg) (Eq.10.111) Howard D. Curtis book
    eps = 25.19 - (3.56 * 10^(-7) * n);
    
    % unit vector from Mars to Sun
    u = [cosd(lamda);
         cosd(eps) * sind(lamda);
         sind(eps) * sind(lamda)];
    
    % distance from Mars to Sun (km)
    rS = (1.00014 - (0.09339410 * cosd(M)) - ...
         (0.000140 * cosd(2 * M))) * (1.52*AU);
    
    % marscentric position vector (km)
    sun_position = rS * u;

end
