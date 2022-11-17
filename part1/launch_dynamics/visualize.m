%%
%
% =========================================================================
% **************  Visualization of Launch to Parking Orbit   **************
% =========================================================================
% Arguments:
% - v: velocity of the rocket at each step in km/s
% - h: altitude of the launch vehicle during flight in km
% - v_D: list of velocity loss due to drag until burnout in km/s
% - v_G: list of velocity loss due to gravity until burnout in km/s
% - t: time as step in s
% Returns:
% - graph
%
%%

function visualize(v, h, v_D, v_G, t)
    
    figure(1);
    plot(t, v, "-r*")
    xlabel("Time [s]")
    ylabel("Velocity [km/s]")
    grid on;

    figure(2);
    plot(t, h, "-bo")
    xlabel("Time [s]")
    ylabel("Altitude [km]")
    grid on;

    figure(3);
    plot(h, v_D, "-k+")
    hold on;
    plot(h, v_G, "-go")
    xlabel("Altitude [km]")
    ylabel("Velocity Loss [km/s]")
    grid on;
    legend(["drag", "gravity"])

    figure(4);
    plot(h, v, "-k*")
    xlabel("Altitude [km]")
    ylabel("Velocity [km/s]")
    grid on;

    figure(5)
    subplot(2, 2, 1)
    plot(t, v, "-r*")
    xlabel("Time [s]")
    ylabel("Velocity [km/s]")
    grid on;
    
    subplot(2, 2, 2)
    plot(t, h, "-bo")
    xlabel("Time [s]")
    ylabel("Altitude [km]")
    grid on;
    
    subplot(2, 2, 3)
    plot(h, v_D, "-k+")
    hold on;
    plot(h, v_G, "-go")
    xlabel("Altitude [km]")
    ylabel("Velocity Loss [km/s]")
    grid on;
    legend(["drag", "gravity"])
    
    subplot(2, 2, 4)
    plot(h, v, "-k*")
    xlabel("Altitude [km]")
    ylabel("Velocity [km/s]")
    grid on;

end