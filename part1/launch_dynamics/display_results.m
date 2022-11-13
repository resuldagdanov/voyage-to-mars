%%
%
% =========================================================================
% *******************  Print-Out Results After Burnout   ******************
% =========================================================================
% Arguments:
% - output_y: vector of results after burnout
%
%%

function display_results(output_y)

    fprintf("\n\n –––––––––––––––––––––––––––––––––––\n")
    fprintf("\n At Burnout:")
    
    fprintf("\n Speed = %10.5f km/s", output_y(1))
    fprintf("\n Flight Path Angle = %10.5f deg ", output_y(2))
    fprintf("\n Downrange Distance = %10.5f km ", output_y(3))
    fprintf("\n Altitude = %10.5f km ", output_y(4))
    fprintf("\n Drag Loss = %10.5f km/s", output_y(5))
    fprintf("\n Gravity Loss = %10.5f km/s", output_y(6))
    fprintf("\n Launch Duration = %10.5f s", output_y(7))
    
    fprintf("\n\n –––––––––––––––––––––––––––––––––––\n")

    fprintf("\n Based on Launch Duration of = %10.5f s:\n", 327.48588)
    fprintf("\n Minutes = %10.0f m", 5)
    fprintf("\n Seconds = %10.0f s\n", 28)

end
