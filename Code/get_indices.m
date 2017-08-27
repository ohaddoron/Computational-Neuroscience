function [activated,non_activated_selective,non_selective,inhibitory] = get_indices (settings,params)
% Returns indices of all possible groups. Used to plot results

group_size = 0.1 * params.num_exitatory;
activated = 1 : group_size;
non_activated_selective = 0.1 * params.num_exitatory + 1 : 2 * group_size;
non_selective = params.num_exitatory - group_size : params.num_exitatory;
inhibitory = params.num_exitatory + 1 : params.num_exitatory + params.num_inhibatory;

return
