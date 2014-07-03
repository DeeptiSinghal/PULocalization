%%Code written by Deepti Singhal from IIIT, Hyderabad.
%Publication for citation: [Singhal, D.; Sharma, M.K.; Garimella, R.M.,
%"Energy efficient localization of primary users for avoiding interference
%in cognitive networks," Computer Communication and Informatics (ICCCI),
%2012 International Conference on , vol., no., pp.1,5, 10-12 Jan. 2012.] 
function [level_id] = getLevel(x_pos, y_pos, x_grid, y_grid, radius)
    center_x = x_grid / 2;
    center_y = y_grid / 2;
    
	x_diff = x_pos - center_x;
    y_diff = y_pos - center_y;

    dis_pow = (x_diff * x_diff) + (y_diff * y_diff);
    distance = sqrt(dis_pow);

    level_id = ceil(distance / radius);
    if (level_id == 0)
        level_id = level_id + 1;
    end;
    clear center_x center_y x_diff y_diff dis_pow distance x_pos y_pos;
