%%
%
% =========================================================================
% ***************  Calculates Julian Day Number at 0 UT   *****************
% =========================================================================
% Arguments:
% - year_: selected launch year between range of 1901 and 2099
% - month_: selected launch month between range of 1 and 12
% - day_: selected launch day between range of 1 and 31
% Returns:
% - J_0: Julian day for given year/month/day (Eq.5.48)
%
%%

function J_0 = julian_day(year_, month_, day_)

    % apply (Eq.5.48) from Howard D. Curtis book given in references
    J_0 = (367 * year_) - fix(7 * (year_ + fix((month_ + 9) / 12)) / 4) ...
                        + fix(275 * month_ / 9) + day_ + 1721013.5;

end
