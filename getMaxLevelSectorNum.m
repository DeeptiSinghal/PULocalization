%%Code written by Deepti Singhal from IIIT, Hyderabad.
%Publication for citation: [Singhal, D.; Sharma, M.K.; Garimella, R.M.,
%"Energy efficient localization of primary users for avoiding interference
%in cognitive networks," Computer Communication and Informatics (ICCCI),
%2012 International Conference on , vol., no., pp.1,5, 10-12 Jan. 2012.] 
function [max_levels, max_sectors] = getMaxLevelSectorNum(x_grid, y_grid, radius, sector_angle)
    center_x = x_grid / 2;
    center_y = y_grid / 2;
    x_diff = x_grid - center_x;
    y_diff = y_grid - center_y;
    dis_pow = (x_diff * x_diff) + (y_diff * y_diff);
    distance = sqrt(dis_pow);
    max_levels = ceil(distance / radius);
    
    max_sectors = 360 / sector_angle;
    clear center_x center_y x_diff y_diff dis_pow distance;
