function [settings,params] = load_settings_params()

%% settings
settings.path2results = fullfile('..','results');
settings.path2data = fullfile('..','data');
settings.path2figures = fullfile('..','figures');
settings.visualize = true;
%% params
params.seed = 1;
%% LIF constansts
params.current_type = 'specific'; % constant / sinusoidal /step
params.I_e = 5e-7; % current amplitude [A]
params.thresh = -50e-3; % membrane threshold [V]
params.V0 = -70e-3; % membrane reset potential [V]
params.Rm = 5e6; % resitance [Ohm]
params.Cm = 1e-9; % capacitance [F]
params.simulation_time = 3e-0; % sec
params.dt = 1e-3; % sec
params.tau = params.Rm * params.Cm; % membrane time constant
params.E_L = -60e-3;
params.electrode_freq = 1e3; %Hz
params.SNR = 2e2;
params.refract = 10e-3; % refractory period [sec]
params.spike_amp = 20e-3; % spike amplitude. visualization only
params.init_tolerance = 0.4; % initilization tolerance
%% TM constansts
params.I_s = 1e-9; % synaptic current
params.I0 = 1e-9;
params.x0 = 0.99;
params.u0 = 0.01;
params.tau_D = 100e-3;
params.tau_F = 600e-3;
params.tau_I_s = 50e-3;
params.U = 0.45;
params.AP = 20e-3;

params.num_neurons_group = 50;
params.num_memories = 3;
% params.num_neurons = (params.num_memories + 2) * params.num_neurons_group;
params.num_inhibotory = params.num_neurons_group;
params.num_non_specific = params.num_neurons_group;
params.num_neurons = params.num_memories * params.num_neurons_group + params.num_inhibotory...
    + params.num_non_specific; 

params.w_group = 10; % connection strength between neurons of the same group
params.w_non_group = 2; % inter group connection strength
params.w_inhibitory = -2;

