function model = LIF_TM_model ( settings, params, data )

%% init
num_samples = length(data.timeVec); % number of samples in simulation
num_neurons = size(data.connectivity,1); % number of neurons in simulation
[V,u,x,I_s] = draw_initilization ( settings, params, data ); % initialize the starting values
% refract = false(num_neurons,num_samples); % used as a refractory variable
refract_period = round(params.refract / params.dt); % refractory period in samples
skip = false(num_neurons,num_samples);
spikes = false(num_neurons,num_samples);
E_L = V(:,1);
D = -ones(num_neurons);
J = zeros(num_neurons);
tau = [repmat(params.tau_exitatory,params.num_exitatory,1); ...
    repmat(params.tau_inhibatory,params.num_inhibatory,1)];
%% model
for iter = 1 : num_samples - 1
    %% refractory neurons
    active_idx = ~skip(:,iter); % get index of neurons not in refractory period
    %% recurrent activation
    idx = D == 0;
    connectivity = idx' .* data.connectivity;
    I_s (:,iter) = connectivity * (u(:,iter) .* x(:,iter));
    %% LIF model
    f = (E_L-V(:,iter) + data.I(:,iter)  + I_s(:,iter))./tau;
%     f = (E_L - V(:,iter) + data.I(:,iter));
    V(:,iter+1) = V(:,iter) + params.dt * f .* active_idx; % add only to active neurons
%     if iter == 1 
%         figure;
%     end
%     plot(I_s(:,iter)), drawnow;
%     plot(V(1,1:iter)), hold on, plot(V(81,1:iter)), drawnow, hold off;
%     plot(V(1,1:iter)), hold on, plot(V(81,1:iter)), drawnow, hold off;
%     plot(data.connectivity * I_s(:,iter) + data.I(:,iter)), drawnow;
%     plot(V(end,1:iter)), drawnow;
%     plot(data.connectivity*I_s(:,iter),'.'), ylim([-1e-5 5e-5]), drawnow;
    spike_idx = V(:,iter+1) >= params.thresh;
    V(spike_idx,iter) = params.spike_potential;
    V(spike_idx,iter+1) = E_L(spike_idx);
    spikes(:,iter) = spike_idx;
    skip(spike_idx,iter:iter + refract_period) = true;
    if sum(spike_idx) > 0
        flag = true;
    end
    %% TM model
    % Solve for u
    f_u = (params.U- u(:,iter))./params.tau_F;
    u(:,iter+1) = u(:,iter) + params.dt * f_u + params.U * (1-u(:,iter)) .* spike_idx;
    % Solve for x
    f_x = (1-x(:,iter))./params.tau_D;
    x(:,iter+1) = x(:,iter) + params.dt * f_x  - u(:,iter+1).*x(:,iter) .* spike_idx;
    % update delay matrix
    D ( spike_idx, : ) = data.D(spike_idx,:);
    D = D - 1;
end
%% save model and exit
model.spike_times = spikes;
model.V = V;
model.u = u;
model.x = x;
model.I_s = I_s;
model.settings = settings;
model.params = params;
    
    
