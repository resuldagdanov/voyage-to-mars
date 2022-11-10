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
    
    fprintf("\n Speed = %10.3f km/s", output_y(1))
    fprintf("\n Flight Path Angle = %10.3f deg ", output_y(2))
    fprintf("\n Downrange Distance = %10.3f km ", output_y(3))
    fprintf("\n Altitude = %10.3f km ", output_y(4))
    fprintf("\n Drag Loss = %10.3f km/s", output_y(5))
    fprintf("\n Gravity Loss = %10.3f km/s", output_y(6))
    
    fprintf("\n\n –––––––––––––––––––––––––––––––––––\n")

end
