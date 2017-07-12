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


V(:,1) = 2 * (params.init_tolerance * rand(params.num_neurons,1) + (1-params.init_tolerance)) * V0;
u(:,1) = 2 * (params.init_tolerance * rand(params.num_neurons,1) + (1-params.init_tolerance)) * u0;
x(:,1) = 2 * (params.init_tolerance * rand(params.num_neurons,1) + (1-params.init_tolerance)) * x0;


u(u>1) = 1; u(u<0) = 0;
x(x>1) = 1; x(x<0) = 0;
