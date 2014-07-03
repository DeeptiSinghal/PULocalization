%%Code written by Deepti Singhal from IIIT, Hyderabad.
%Publication for citation: [Singhal, D.; Sharma, M.K.; Garimella, R.M.,
%"Energy efficient localization of primary users for avoiding interference
%in cognitive networks," Computer Communication and Informatics (ICCCI),
%2012 International Conference on , vol., no., pp.1,5, 10-12 Jan. 2012.] 
function disable_status = getCU_Status_Gom(x_pos_pu, y_pos_pu, x_pos_cu, y_pos_cu, radius_DR)
    x_diff = x_pos_pu - x_pos_cu;
    y_diff = y_pos_pu - y_pos_cu;

    dis_pow = (x_diff * x_diff) + (y_diff * y_diff);
    distance = sqrt(dis_pow);
    
    if (distance <= radius_DR)
        disable_status = 1; % Disable ON
    else 
        disable_status = 0; % Disable OFF
    end;
