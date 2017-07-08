function data = load_data ( settings, params )


data.timeVec = 0:params.dt:params.simulation_time;

switch params.current_type
    case 'constant'
        data.I_e = params.I_e  * ones(params.num_neurons,length(data.timeVec));
    case 'step'
        data.I_e = params.I_e * ones(params.num_neurons,floor(length(data.timeVec)/2));
        data.I_e(end+1 : length(data.timeVec)) = 0;
    case 'specific'
        data.I_e = params.I_e/3 *ones(params.num_neurons,length(data.timeVec));
        data.I_e (1 : params.num_neurons_group,1:floor(length(data.timeVec)/5)) = params.I_e;
    otherwise
        data.I_e = zeros(params.num_neurons,length(data.timeVec));
end
% data.I_e = awgn(data.I_e,params.SNR);
data.connectivity_map = generate_connectivity(settings,params);
% figure, plot(data.I_e);
return
