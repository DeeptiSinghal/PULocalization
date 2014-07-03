%%Code written by Deepti Singhal from IIIT, Hyderabad.
%Publication for citation: [Singhal, D.; Sharma, M.K.; Garimella, R.M.,
%"Energy efficient localization of primary users for avoiding interference
%in cognitive networks," Computer Communication and Informatics (ICCCI),
%2012 International Conference on , vol., no., pp.1,5, 10-12 Jan. 2012.] 
function [org_disable_count, sim_disable_count, error_per, wrong_enable_cnt] = main(total_no_CUs, total_no_PUs, x_grid, y_grid, radius, sector_angle, radius_CU, radius_PU)
    %-------------------------------- Cognitive Users ----------------------------
    % Initializing the lists
    list_node_id = zeros(1, total_no_CUs);
    list_node_x_pos = zeros(1, total_no_CUs);
    list_node_y_pos = zeros(1, total_no_CUs);
    list_level_id = zeros(1, total_no_CUs);
    list_sector_id = zeros(1, total_no_CUs);

    % Initializing the topology of CUs
    x_max = x_grid;
    x_min = 0;
    y_max = y_grid;
    y_min = 0;
    x_rand = rand(1,total_no_CUs);
    y_rand = rand(1,total_no_CUs);
    for nodeid = 1:total_no_CUs
        list_node_id(nodeid) = nodeid;
        list_node_x_pos(nodeid) =  x_min + (x_max - x_min) * x_rand(nodeid);
        list_node_y_pos(nodeid) =  y_min + (y_max - y_min) * y_rand(nodeid);
    end
    clear nodeid x_max x_min y_max y_min x_rand y_rand;

    % set Level IDs and Sector IDs for all CUs
    for nodeid = 1:total_no_CUs
        list_level_id(nodeid) = getLevel(list_node_x_pos(nodeid), list_node_y_pos(nodeid), x_grid, y_grid, radius);
        list_sector_id(nodeid) = getSector(list_node_x_pos(nodeid), list_node_y_pos(nodeid), x_grid, y_grid, sector_angle);
    end
    clear nodeid;
    %-----------------------------------------------------------------------------

    %-------------------------------- Primary Users ------------------------------
    % Initializing the lists
    list_pu_id = zeros(1, total_no_PUs);
    list_pu_x_pos = zeros(1, total_no_PUs);
    list_pu_y_pos = zeros(1, total_no_PUs);
    list_pu_level_id = zeros(1, total_no_PUs);
    list_pu_sector_id = zeros(1, total_no_PUs);

    % Initializing the topology of PUs
    x_max = x_grid;
    x_min = 0;
    y_max = y_grid;
    y_min = 0;
    x_rand = rand(1,total_no_PUs);
    y_rand = rand(1,total_no_PUs);
    for nodeid = 1:total_no_PUs
        list_pu_id(nodeid) = nodeid;
        list_pu_x_pos(nodeid) =  x_min + (x_max - x_min) * x_rand(nodeid);
        list_pu_y_pos(nodeid) =  y_min + (y_max - y_min) * y_rand(nodeid);
    end
    clear x_max x_min y_max y_min x_rand y_rand nodeid;

    % set Level IDs and Sector IDs for all PUs
    for nodeid = 1:total_no_PUs
        list_pu_level_id(nodeid) = getLevel(list_pu_x_pos(nodeid), list_pu_y_pos(nodeid), x_grid, y_grid, radius);
        list_pu_sector_id(nodeid) = getSector(list_pu_x_pos(nodeid), list_pu_y_pos(nodeid), x_grid, y_grid, sector_angle);
    end
    clear nodeid;
    %-----------------------------------------------------------------------------


    %----------------------- Disable Region Radius Calculation -------------------
    % Disable Region Radius
    radius_DR = radius_CU + radius_PU;
    clear radius_CU radius_PU;
    %-----------------------------------------------------------------------------

    %------------------------- Calculation for # Disabled CUS --------------------
    % calculating maximum number of level id and sector id
    [max_levels, max_sectors] = getMaxLevelSectorNum(x_grid, y_grid, radius, sector_angle);

    org_disable_count = 0;
    sim_disable_count = 0;
    for nodeid = 1:total_no_CUs
        for pu_id = 1:total_no_PUs
            % Origanal
            disable_status_org = getCU_Status_Gom(list_pu_x_pos(pu_id), list_pu_y_pos(pu_id), list_node_x_pos(nodeid), list_node_y_pos(nodeid), radius_DR);
            org_disable_count = org_disable_count + disable_status_org;
            % Simulation
            [Disable_L] = getDisableLevelIDs(list_pu_level_id(pu_id), radius_DR, radius, max_levels);
            [Disable_S] = getDisableSectorIDs(list_pu_sector_id(pu_id), list_pu_level_id(pu_id), radius, radius_DR, sector_angle, max_sectors);
            disable_status_sim = getCU_Status(list_level_id(nodeid), list_sector_id(nodeid), Disable_L, Disable_S);
            if (disable_status_sim == 1)
                break;
            end;
        end;
        sim_disable_count = sim_disable_count + disable_status_sim;
        wrong_enable_cnt = 0;
        if (disable_status_org > disable_status_sim)
            wrong_enable_cnt = wrong_enable_cnt + 0;
        end;
    end
    clear nodeid pu_id Disable_L Disable_S disable_status_org disable_status_sim;
    %-----------------------------------------------------------------------------

    %------------------------- Calculation for # Disabled CUS --------------------
    %     org_disable_count = 0;
    %     for nodeid = 1:total_no_CUs
    %         for pu_id = 1:total_no_PUs
    %             disable_status_org = getCU_Status_Gom(list_pu_x_pos(pu_id), list_pu_y_pos(pu_id), list_node_x_pos(nodeid), list_node_y_pos(nodeid), radius_DR);
    %             org_disable_count = org_disable_count + disable_status_org;
    %         end
    %     end
    %     clear nodeid pu_id disable_status_org;
    %-----------------------------------------------------------------------------

    %------------------------- Calculation for Error -----------------------------
    error = sqrt((org_disable_count - sim_disable_count)*(org_disable_count - sim_disable_count));
    error_per = (error/total_no_CUs)*100;
    clear error;
    %-----------------------------------------------------------------------------

    %clear total_no_CUs total_no_PUs radius sector_angle x_grid y_grid initial_energy;
    clear list_node_id list_node_x_pos list_node_y_pos list_level_id list_sector_id;
    clear list_pu_id list_pu_x_pos list_pu_y_pos list_pu_level_id list_pu_sector_id;
    clear radius_DR max_levels max_sectors Disable_Levels Disable_Sectors;
    % clear sim_disable_count org_disable_count error_per;
