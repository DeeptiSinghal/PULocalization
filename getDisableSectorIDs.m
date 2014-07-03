%%Code written by Deepti Singhal from IIIT, Hyderabad.
%Publication for citation: [Singhal, D.; Sharma, M.K.; Garimella, R.M.,
%"Energy efficient localization of primary users for avoiding interference
%in cognitive networks," Computer Communication and Informatics (ICCCI),
%2012 International Conference on , vol., no., pp.1,5, 10-12 Jan. 2012.] 
function [Disable_S] = getDisableSectorIDs(sector_id, level_id, radius, radius_DR, sector_angle, max_sectors)
    distanceSectorMid_BS = ((level_id -1)* radius) + (radius/2);
    
    if (distanceSectorMid_BS > radius_DR)
        DisableAngle = ((asin(radius_DR/distanceSectorMid_BS)* 360) / 6.28);
        
        numberOfDisableSector = int8(DisableAngle/sector_angle) + 1;
        if (numberOfDisableSector == 1)
            numberOfDisableSector = numberOfDisableSector + 1;
        end;
        Disable_S = zeros(1, numberOfDisableSector);

        DisableIndex = 1;
        Disable_S(DisableIndex) = sector_id;
        for index_up = 1 : (numberOfDisableSector - 1)
            DisableIndex = DisableIndex + 1;
            if (sector_id + index_up <= max_sectors)
                Disable_S(DisableIndex) = sector_id + index_up ;
            else
                Disable_S(DisableIndex) = sector_id + index_up - max_sectors;
            end;
        end;
        for index_down = 1 : (numberOfDisableSector - 1)
            DisableIndex = DisableIndex + 1;
            if (sector_id - index_down > 0)
                Disable_S(DisableIndex) = sector_id - index_down ;
            else
                Disable_S(DisableIndex) = sector_id - index_down + max_sectors;
            end;
        end;
    else
        numberOfDisableSector = max_sectors;
        Disable_S = zeros(1, numberOfDisableSector);
        
        for DisableIndex = 1 : numberOfDisableSector
            Disable_S(DisableIndex) = DisableIndex;
        end;
    end;
    sort(Disable_S);
    clear distanceSectorMid_BS DisableAngle numberOfDisableSector DisableIndex index_up index_down;
