function [V,u,x,I_s] = draw_initilization ( settings, params, data )

%% init
rng(params.seed);
num_samples = length(data.timeVec); % number of samples in simulation
V = zeros(params.num_neurons,num_samples);
u = zeros(params.num_neurons,num_samples);
x = zeros(params.num_neurons,num_samples);
I_s = zeros(params.num_neurons,num_samples);
%% draw random values to initialize with
V0 = params.V0;
u0 = params.u0;
x0 = params.x0;
I0 = params.I0;

V(:,1) = (1.1*V0 - 0.9 * V0) * rand(params.num_neurons,1) + 0.9 * V0;
u(:,1) = (1.1*u0 - 0.9 * u0) * rand(params.num_neurons,1) + 0.9 * u0;
x(:,1) = (1.1*x0 - 0.9 * x0) * rand(params.num_neurons,1) + 0.9 * x0;
I_s(:,1) = (1.1*I0 - 0.9 * I0) * rand(params.num_neurons,1) + 0.9 * I0;

