%%Code written by Deepti Singhal from IIIT, Hyderabad.
%Publication for citation: [Singhal, D.; Sharma, M.K.; Garimella, R.M.,
%"Energy efficient localization of primary users for avoiding interference
%in cognitive networks," Computer Communication and Informatics (ICCCI),
%2012 International Conference on , vol., no., pp.1,5, 10-12 Jan. 2012.] 
function [Disable_L] = getDisableLevelIDs(level_id, radius_DR, radius, max_levels)
    numberOfDisableLevel = int8(radius_DR/radius) + 1;
    DisableIndex = 1;
    Disable_L(DisableIndex) = level_id;
    for index_up = 1 : (numberOfDisableLevel - 1)
        if (level_id + index_up <= max_levels)
            DisableIndex = DisableIndex + 1;
            Disable_L(DisableIndex) = level_id + index_up ;
        end;
    end;
    for index_down = 1 : (numberOfDisableLevel - 1)
        if (level_id - index_down > 0)
            DisableIndex = DisableIndex + 1;
            Disable_L(DisableIndex) = level_id - index_down ;
        end;
    end;
    Disable_L = sort(Disable_L);
    clear numberOfDisableLevel DisableIndex index_up index_down;
