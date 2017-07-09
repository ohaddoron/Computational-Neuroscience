function model = LIF_TM_model ( settings, params, data )

%% init
num_samples = length(data.timeVec); % number of samples in simulation
num_neurons = size(data.connectivity_map,1); % number of neurons in simulation
[V,u,x,I_s] = draw_initilization ( settings, params, data );
% refract = false(num_neurons,num_samples); % used as a refractory variable
refract_period = round(params.refract / params.dt);
skip = false(num_neurons,num_samples);
spikes = false(num_neurons,num_samples);

%% model
for iter = 1 : num_samples - 1
    %% refractory neurons
    active_idx = ~skip(:,iter); % get index of neurons not in refractory period
    
    %% LIF model
    f = 1/params.tau * (-V(:,iter) + params.E_L) + params.Rm *(data.I_e(:,iter)...
        + data.connectivity_map' * I_s(:,iter));
    V(:,iter+1) = V(:,iter) + params.dt * f .* active_idx; % add only to active neurons
    spike_idx = V(:,iter+1) >= params.thresh;
    V(spike_idx,iter) = params.AP;
    V(spike_idx,iter+1) = params.V0;
    spikes(:,iter) = spike_idx;
    skip(spike_idx,iter:iter + refract_period) = true;
    
    %% TM model
    % Solve for u
    f_u = (params.U- u(:,iter))/params.tau_F;
    u(:,iter+1) = u(:,iter) + params.dt * f_u + params.U * (1-u(:,iter)) .* spike_idx;
    % Solve for x
    f_x = (1-x(:,iter))/params.tau_D;
    x(:,iter+1) = x(:,iter) + params.dt * f_x  - u(:,iter+1).*x(:,iter) .* spike_idx;
    % Solve for I_s
    f_I = -params.dt *I_s(:,iter)/params.tau_I_s;
    I_s(:,iter+1) = I_s(:,iter) + f_I + ...
        params.I_s * u(:,iter+1) .* x(:,iter).*spike_idx;
end
%% save model and exit
model.spike_times = spikes;
model.V = V;
model.u = u;
model.x = x;
model.I_s = I_s;
    
    
