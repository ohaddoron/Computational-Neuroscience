function data = calc_statistics ( settings, params, model,parameter )
% Calculates the mean and standard deviation of all possible different
% groups
%% get indices
[activated,non_activated_selective,non_selective,inhibitory] = get_indices (settings,params);
%% mean
data.activated_mean = mean(model.(parameter)(activated,:));
data.non_activated_selective_mean = mean(model.(parameter)(non_activated_selective,:));
data.non_selective_mean = mean(model.(parameter)(non_selective,:));
data.inhibitory = mean(model.(parameter)(inhibitory,:));
%% std
data.activated_std = std(model.(parameter)(activated,:));
data.non_activated_selective_std = std(model.(parameter)(non_activated_selective,:));
data.non_selective_std = std(model.(parameter)(non_selective,:));
data.inhibitory = std(model.(parameter)(inhibitory,:));
