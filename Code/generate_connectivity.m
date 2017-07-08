function connectivity_map = generate_connectivity ( settings , params )

%% init
num_memories = params.num_memories;
num_neurons_group = params.num_neurons_group; % number of neurons in a memory
num_neurons = num_neurons_group * num_memories + params.num_inhibotory + ...
    params.num_non_specific;
connectivity_map = params.w_non_group * rand(num_neurons) * 0.1; % number of neurons in simulation + inhibatory + non selective
rng(params.seed);

%% generate map
num_groups = num_neurons / num_neurons_group;
for i = 1 : num_groups
    if i == num_groups - 1
        continue
    end
    connectivity_map((i-1) * num_neurons_group + 1 : i * num_neurons_group,...
        (i-1) * num_neurons_group + 1: i * num_neurons_group)...
        = params.w_group;
end
connectivity_map(logical(eye(size(connectivity_map)))) = 0; % don't allow self connections
connectivity_map(end - params.num_inhibotory + 1:end,1:end - params.num_inhibotory) ...
    = rand(params.num_inhibotory,params.num_neurons-params.num_inhibotory) * params.w_inhibitory; % inhibitory group
return