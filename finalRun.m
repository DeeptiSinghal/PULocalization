%%Code written by Deepti Singhal from IIIT, Hyderabad.
%Publication for citation: [Singhal, D.; Sharma, M.K.; Garimella, R.M.,
%"Energy efficient localization of primary users for avoiding interference
%in cognitive networks," Computer Communication and Informatics (ICCCI),
%2012 International Conference on , vol., no., pp.1,5, 10-12 Jan. 2012.] 

clear;
initial = 100;
increment = 100;
for i = 0:8
    total_no_CUs = initial + (i*increment);
    total_no_CUs
    run(total_no_CUs);
end;
clear initial increment total_no_CUs;
