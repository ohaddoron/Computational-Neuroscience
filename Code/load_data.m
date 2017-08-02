function data = load_data ( settings, params )

%% init
rng(params.seed);
data.timeVec = 0:params.dt:params.simulation_time;
%% draw external stimulation
num_neurons_group = params.num_exitatory * params.f; % the number of neurons is according to the coding level
I_amp_selective = false(params.num_neurons,length(data.timeVec)); % Amplification for selective exitation
I_amp_non_selective = false(params.num_neurons,length(data.timeVec)); % Amplification for non-selective exitation
switch settings.simulation_type
    case 'memory_maintenance'
        T_cue = round(params.T_cue / params.dt); % activation duration
        D_cue = round(params.D_cue / params.dt); % activation delay
        T_reactivation = (params.T_reactivating / params.dt); % reactivation duration
        D_reactivation = round(params.D_reactivating / params.dt); % reactivation delay
        I_amp_selective(1:num_neurons_group,D_cue:D_cue+T_cue) = true; % indices to amplify
        I_amp_non_selective(:,D_reactivation:D_reactivation + T_reactivation) = true; % indices to amplify
    otherwise
        ...        
end

data.I_external_exitatory = params.sigma_ext_exitatotry * ...
    randn(params.num_exitatory,length(data.timeVec)) + params.mu_ext_exitatotry; % general exitation for exitatory neurons
data.I_external_inhibatory = params.sigma_ext_inhibatory * ...
    randn(params.num_inhibatory,length(data.timeVec)) + params.mu_ext_inhibatory; % general exitation for inhibatory neurons

% Total current
data.I = [data.I_external_exitatory; data.I_external_inhibatory]; 
data.I(I_amp_selective) = data.I(I_amp_selective) * params.A_cue; 
data.I(I_amp_non_selective) = data.I(I_amp_non_selective) * params.A_reactivating; 
data.I(data.I<0) = 0;
%% Connectivity
%% Get indices of the different groups
inhibatory_indices = (params.num_neurons - params.num_inhibatory + 1) : params.num_neurons;
non_selective_indices = (params.num_exitatory - params.num_memories * num_neurons_group + 1):...
     (params.num_neurons - params.num_inhibatory);
selective_indices = cell(params.num_memories,1);
for i = 1 : params.num_memories
    selective_indices{i} = round((i-1)*params.f * params.num_exitatory + 1):round( i * params.f * params.num_exitatory);
end
E_selective_idx = cat(2,selective_indices{:});
E_idx = [non_selective_indices E_selective_idx];

%% Create connectivity maps for each of the different groups 
inhib_connectivity = connect ( settings, params, inhibatory_indices, non_selective_indices, selective_indices , inhibatory_indices );
non_select_connectivity = connect ( settings, params, inhibatory_indices, non_selective_indices, selective_indices , non_selective_indices );
select_connectivity = connect ( settings, params, inhibatory_indices, non_selective_indices, selective_indices , []);
for i = 1 : params.num_memories
    select_connectivity = select_connectivity | connect ( settings, params, inhibatory_indices, non_selective_indices, selective_indices , selective_indices{i} );
end
%% Put everything back together
connectivity_bin = inhib_connectivity | non_select_connectivity | select_connectivity;
%% Efficacy [V]
connectivity_map = zeros(params.num_neurons,params.num_neurons);

connectivity_map(inhibatory_indices,E_idx) = params.J_I_E; % E -> I
connectivity_map(E_idx,inhibatory_indices) = params.J_E_I; % I -> E
connectivity_map(inhibatory_indices,inhibatory_indices) = params.J_I_I; % I -> I
connectivity_map(E_idx,E_idx) = params.J_b;
for i = 1 : params.num_memories
    connectivity_map(selective_indices{i},selective_indices{i}) = params.J_p; % E - > E ingroup
    % gamma0 of non selective to selective and vise versa are potentiated
end
connectivity_map(non_selective_indices,non_selective_indices) = params.J_b;

data.connectivity = connectivity_map.*connectivity_bin;
%% synaptic delays
data.D = params.delta(1) + (params.delta(2) - params.delta(1)) * rand(size(data.connectivity));
return
function connectivity = connect ( settings, params, inhibatory_indices, non_selective_indices, selective_indices , group_indices )
%% initilize
rng(params.seed);
connectivity = false(params.num_neurons,params.num_neurons);
%% draw random connectivity pattern
for i = 1 : length(group_indices)
    %% selective connections
    selective_connection = cellfun(@(x) randsample(x,round(params.c * params.f * params.num_exitatory)), selective_indices,'Un',false);
    selective_connection = cat(2,selective_connection{:});
    %% non-selective connections
    non_selective_connection = randsample(non_selective_indices, round(params.c *(1 - params.num_memories * params.f) * params.num_exitatory));
    %% inhibatory connections
    inhib_connection = randsample(inhibatory_indices,round(params.c * params.num_inhibatory));
    %% connect
    connectivity(group_indices(i),selective_connection) = true;
    connectivity(group_indices(i),non_selective_connection) = true;
    connectivity(group_indices(i),inhib_connection) = true;
end
return

