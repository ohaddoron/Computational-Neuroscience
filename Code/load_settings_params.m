function [settings,params] = load_settings_params()

%% settings
settings.path2results = fullfile('..','results');
settings.path2data = fullfile('..','data');
settings.path2figures = fullfile('..','figures');
settings.visualize = true;
settings.simulation_type = 'memory_maintenance';
%% Simulation Params 
params.seed = 1;
params.simulation_time = 2e-0; % sec
params.dt = 1e-4; % sec
%% Single Cell Parameters
params.thresh = 20e-3; % membrane threshold [V]
params.V0_exitatory = 16e-3; % membrane reset potential for exitatory neurons[V]
params.V0_inhibatory = 13e-3; % memberane reset potential for inhibatory neurons [V]
params.spike_potential = 30e-3; % memberane maximal potential at a spike [V]
params.tau_exitatory = 15e-3; % membrane time constant [sec]
params.tau_inhibatory = 10e-3; % membrane time constant [sec]
params.refract = 2e-3; % refractory period for exitatory neurons [sec]
%% Network Parameters
params.f = 0.1; % Coding Level
params.c = 0.2; % Probability of synaptic contact
params.num_memories = 5; % number of memories in the simulation
% params.num_neurons = (params.num_memories + 2) * params.num_neurons_group;
params.num_inhibatory = 2e2; % num neurons
params.num_exitatory = 8e2; % num neurons
<<<<<<< HEAD
params.mu_ext_exitatotry = 1e-3; % extitory neurons mean external input [V]
params.sigma_ext_exitatotry = 1e-2; % extitory neurons standard deviation external input [V]
params.mu_ext_inhibatory = 1e-3; % inhibatory neurons mean external input [V]
params.sigma_ext_inhibatory = 1e-2; % inhibatory neurons standard deviation external input [V]
=======
params.mu_ext_exitatotry = 23.1e-3; % extitory neurons mean external input [V]
params.sigma_ext_exitatotry = 1e-3; % extitory neurons standard deviation external input [V]
params.mu_ext_inhibatory = 21.0e-3; % inhibatory neurons mean external input [V]
params.sigma_ext_inhibatory = 1e-3; % inhibatory neurons standard deviation external input [V]
>>>>>>> 95bed982ee5e0bc2d5b751bf96f6c9e3c7bfa138
params.num_neurons = params.num_inhibatory + params.num_exitatory; % total number of neurons in the simulation
params.p_stimulation = 1e-3;
%% Synaptic Parameters
params.J_I_E = 0.135e-3; % Synaptic Efficacy E -> I [V]
params.J_E_I = -0.25e-3; % Synaptic Efficacy I -> E [V]
params.J_I_I = -0.2e-3; % Synaptic Efficacy I -> I [V]
params.J_b = 0.1e-3;% Basline level of E - > E synapses [V]
params.J_p = 0.45e-3;% Potentiated level of E -> E synapses [V]
params.gamma0 = 0.1; % Fraction of potentiated synapses before learning
params.delta = [0.1,1]*1e-3; % Synaptic delays [sec]
%% Short term synaptic dynapics parameters
params.x0 = 1; % Baseline resources factor
params.I0 = 0; % Baseline current
params.U = 0.2; % Basleline utilization factor
params.tau_D = 200e-3; % Recovery time of synaptic resources [sec]
params.tau_F = 1500e-3; % Recovery time of utilization factor [sec]
params.tau_I_s = 300e-3; % Time constant of synaptic current
%% Selective Stimulation 
params.D_cue = 0.5e0; % Cue delay. Used to allow the network reach a spontaneous state
params.T_cue = 350e-3; % Duration of selective potentiation
params.A_cue = 1.15e0; % Amplification factor
%% Reactivation Signal
params.D_reactivating = 1.5e0; % Delay until reactivation
params.T_reactivating = 250e-3; % Duration of reactivating signal
params.A_reactivating = 1.05e0; % Amplification factor
%% Periodic activating signal
params.T_periodic = 100e-3; % Duration of reactivating signal
params.Period = 250e-3; % Period of reactivation time
params.A_periodic = 1.075; % Amplification factor