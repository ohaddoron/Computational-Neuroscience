function h = plotRaster ( settings , params , data, model )

%% init
h = figure;

% plotting only for the relevant neurons
spike_mat = model.spike_times;
indices = 1 : 0.01 * params.num_exitatory;
indices = [indices, indices + 0.1 * params.num_exitatory];
num_neurons = length(indices);
spike_mat = spike_mat(indices,:);
spikes = bsxfun(@times,spike_mat,repmat((1:num_neurons/2)',2,1));
spikes(num_neurons/2 + 1 : end,:) = spikes(num_neurons/2 + 1 : end,:) - 0.5;
indices = spikes == 0 | spikes == -0.5;
t = repmat(data.timeVec,num_neurons,1);
c = [repmat([0 0 0],length(t(:))/2,1); repmat([0 1 0],length(t(:))/2,1)];
t(indices) = nan;
spikes(indices) = nan;
spikes = spikes + 0.1 * randn(size(spikes));

%% plot
hold on


% scatter(t(:),spikes(:),5,c,'filled');
% spikes = flipud(spikes);
for i = 1 : size(spikes,1)
    if i <= size(spikes,1) / 2
        scatter(t(i,:),spikes(i,:),5,'k','filled');
    else
        scatter(t(i,:),spikes(i,:),5,'g','filled');
    end
    
end
if settings.activation

    y = ylim;
    X1 = [params.D_cue, params.D_cue + params.T_cue,params.D_cue + params.T_cue,params.D_cue];
    Y1 = [0, 0, y(2), y(2)];
    patch(X1,Y1,[1 1 1] * 0.1, 'FaceAlpha',0.3);


    X2 = [params.D_reactivating, params.D_reactivating + params.T_reactivating...
        ,params.D_reactivating + params.T_reactivating,params.D_reactivating];
    Y2 = [0, 0, y(2), y(2)];
    patch(X2,Y2,[1 1 1] * 0.7, 'FaceAlpha',0.3);

    xlim([0 params.simulation_time]);
    set(gca,'children',flipud(get(gca,'children')))
end
title('Raster Plot'), xlabel('Time [sec]'), ylabel('Neuron #');
% legend('Activated group','Non-activated group','Specific activating current','Non-specific activating current');
