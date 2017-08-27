function [V,u,x,I_s] = draw_initilization ( settings, params, data )

%% init
rng(params.seed);
num_samples = length(data.timeVec); % number of samples in simulation
V = zeros(params.num_neurons,num_samples);
u = zeros(params.num_neurons,num_samples);
x = zeros(params.num_neurons,num_samples);
I_s = zeros(params.num_neurons,num_samples);
%% draw random values to initialize with
V(:,1) = [ones(params.num_exitatory,1) * params.V0_exitatory; ones(params.num_inhibatory,1) * params.V0_inhibatory];
u(:,1) = ones(params.num_neurons,1) * params.U;
x(:,1) = ones(params.num_neurons,1) * params.x0;
I_s(:,1) = ones(params.num_neurons,1) * params.I0;

