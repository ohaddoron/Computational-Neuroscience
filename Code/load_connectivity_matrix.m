function connectivity = load_connectivity_matrix ( settings, params )

%% init
% timeVec = 0:params.dt:settings.simulation_time; % time vector
% nSamples = length(timeVec); % number of samples
group_size = params.f * params.num_exitatory;
N_neurons = params.num_exitatory + params.num_inhibatory;
N_selective = params.num_memories * group_size;
connectivity = false(N_neurons);
%% Binary connectivity
for i = 1 : N_neurons
    %% selective
    for k = 1 : params.num_memories
        idx = randsample((1:group_size) + group_size * (k-1),round(params.c * params.f * group_size));
        connectivity(i,idx) = true; 
    end
    %% non selective
    idx = randsample(params.num_memories * group_size + 1 : params.num_exitatory,params.c * (1- params.f * params.num_memories ) * params.num_exitatory);
    connectivity(i,idx) = true;
    %% inhibitory
    idx = randsample(N_neurons - params.num_inhibatory + 1 : N_neurons,params.c * params.num_inhibatory);
    connectivity(i,idx) = true;
end
return
    