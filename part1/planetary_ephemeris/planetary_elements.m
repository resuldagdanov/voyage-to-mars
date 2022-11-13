%%
%
% =========================================================================
% ***********  Planetary Orbital Elements & Centennial Rates   ************
% =========================================================================
% Arguments:
% - planet_name: name of the planet (Earth or Mars)
% Returns:
% - elements: planetary orbital elements given in Table.8.1
% - rates: planetary centennial rates given in Table.8.1
%
%%

function [elements, rates] = planetary_elements(planet_name)

    % orbital elements and their centennial rates (Table.8.1)
    if planet_name == "Earth"
        elements = [
        1.00000011, 0.01671022, 0.00005, -11.26064, 102.94719, 100.46435];
        rates = [
       -0.00000005, -0.00003804, -46.94, -18228.25, 1198.28, 129597740.63];
    elseif planet_name == "Mars"
        elements = [
        1.52366231, 0.09341233, 1.85061, 49.57854, 336.04084, 355.45332];
        rates = [
        -0.00007221, 0.00011902, -25.47, -1020.19, 1560.78, 68905103.78];
    else
        disp("Select only Earth or Mars!")
    end
    
    % convert from AU to km
    au_2_km = 149597871; %[km]
    elements(1) = elements(1) * au_2_km;
    rates(1) = rates(1) * au_2_km;
    
    % convert from arcseconds to fractions of a degree
    rates(3:6) = rates(3:6) / 3600;

    % NOTE:
    % as Earth and Mars orbits are assumed to be circular orbits
    % around the Sun, their eccentricities are modified to zero
    elements(2) = 0.0;
    rates(2) = 0.0;
    
end
