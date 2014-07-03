%%Code written by Deepti Singhal from IIIT, Hyderabad.
%Publication for citation: [Singhal, D.; Sharma, M.K.; Garimella, R.M.,
%"Energy efficient localization of primary users for avoiding interference
%in cognitive networks," Computer Communication and Informatics (ICCCI),
%2012 International Conference on , vol., no., pp.1,5, 10-12 Jan. 2012.] 
function [ ] = run(total_no_CUs)
% clear
% inputs...
max_run = 500;                  % # Maximum Run
%total_no_CUs = 1000;            % Number of CU
radius = 5;                     % for leveling
sector_angle = 30;              % for sectoring
grid_size = 2000;             % for network area
total_no_PUs = 10;              % Number of PU

x_grid = grid_size;                                 % for network area
y_grid = grid_size;                                 % for network area
radius_CU = 2*radius + 1;                           % CU coverage radius
radius_PU = 3*radius_CU;                            % PU coverage radius

filename = ['output_CU'  num2str(total_no_CUs) '_PU' num2str(total_no_PUs) '_grid' num2str(grid_size) '_angle' num2str(sector_angle) '.txt'];
fp = fopen(filename,'w');
for run_num = 1 : max_run
    if (run_num  == 1)
        temp_str = 'run_num org_disable_count sim_disable_count error_per wrong_enable_cnt';
        fprintf(fp,'%s \n', temp_str);
    end;
    [org_disable_count, sim_disable_count, error_per, wrong_enable_cnt] = main(total_no_CUs, total_no_PUs, x_grid, y_grid, radius, sector_angle, radius_CU, radius_PU);
    temp_str = [num2str(run_num) ' ' num2str(org_disable_count) ' ' num2str(sim_disable_count) ' ' num2str(error_per) ' ' num2str(wrong_enable_cnt) ] ;
    fprintf(fp,'%s \n', temp_str);
    run_num 
    clear sim_disable_count org_disable_count error_per wrong_enable_cnt;
end;
fclose(fp);
clear run_num temp_str filename fp;  
clear max_run radius grid_size sector_angle x_grid y_grid radius_CU radius_PU  total_no_PUs;
% clear total_no_CUs;
