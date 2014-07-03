%%Code written by Deepti Singhal from IIIT, Hyderabad.
%Publication for citation: [Singhal, D.; Sharma, M.K.; Garimella, R.M.,
%"Energy efficient localization of primary users for avoiding interference
%in cognitive networks," Computer Communication and Informatics (ICCCI),
%2012 International Conference on , vol., no., pp.1,5, 10-12 Jan. 2012.] 
function disable_status = getCU_Status(level_id, sector_id, Disable_L, Disable_S)
    level_disable = 0; % Disable OFF By Default
    for level_index = 1:size(Disable_L,2)
        if(level_id == Disable_L(level_index))
            level_disable = 1; % Disable ON
        end;
    end;
    sector_disable = 0; % Disable OFF By Default
    for sector_index = 1:size(Disable_S,2)
        if(sector_id == Disable_S(sector_index))
            sector_disable = 1; % Disable ON
        end;
    end;
    if ((level_disable == 1) && (sector_disable == 1))
        disable_status = 1; % Disable ON
    else 
        disable_status = 0; % Disable OFF
    end;
