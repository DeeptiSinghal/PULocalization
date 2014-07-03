%%Code written by Deepti Singhal from IIIT, Hyderabad.
%Publication for citation: [Singhal, D.; Sharma, M.K.; Garimella, R.M.,
%"Energy efficient localization of primary users for avoiding interference
%in cognitive networks," Computer Communication and Informatics (ICCCI),
%2012 International Conference on , vol., no., pp.1,5, 10-12 Jan. 2012.] 
function [sector_id] = getSector(x_pos, y_pos, x_grid, y_grid, sector_angle)
    r_xs = x_grid / 2;
    r_ys = y_grid / 2;
    r_xe = x_grid;
    r_ye = r_ys;
    
    xs = r_xs;
    ys = r_ys;
    xe = x_pos;
    ye = y_pos;
    
    rx_diff = r_xe - r_xs;
    ry_diff = r_ye - r_ys;
    rlen = sqrt((rx_diff * rx_diff) + (ry_diff * ry_diff));
    rdx = rx_diff / rlen;
    rdy = ry_diff / rlen;
    
    x_diff = xe - xs;
    y_diff = ye - ys;
    len = sqrt((x_diff * x_diff) + (y_diff * y_diff));
    
    if (len == 0)
        angle = 0;
    else
        dx = x_diff / len;
        dy = y_diff / len;
        angleR = ((rdx * dx) + (rdy * dy));
        angle = ((acos(angleR) * 360) / 6.28);
        if (ye < ys)
            angle = 360 - angle;
        end;
    end;
    sector_id = ceil(angle/sector_angle);  
    if (sector_id == 0)
        sector_id = 1;
    end;
    clear r_xs r_ys r_xe r_ye xs xe ys ye rx_diff ry_diff rlen rdx rdy x_diff y_diff len dx dy angleR angle x_pos y_pos;
