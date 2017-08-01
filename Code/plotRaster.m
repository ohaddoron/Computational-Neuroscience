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
c = [repmat([0 1 0],length(t(:))/2,1); repmat([0 0 0],length(t(:))/2,1)];
t(indices) = nan;
spikes(indices) = nan;
%% plot
hold on
for i = 1 : size(t,2)
    scatter(t(1:num_neurons/2,i),spikes(1:num_neurons/2,i),5,'g','filled');
    scatter(t(num_neurons/2+1:end,i),spikes(num_neurons/2+1:end,i),5,'k','filled');
%     drawnow;
end
% X = [0 params.activation_time params.activation_time 0];
% y = ylim;
% Y = [0 0 y(2) y(2)];
% patch(X,Y,0.3 * [1 1 1],'FaceAlpha',0.4)
% set(gca,'children',flipud(get(gca,'children')));
title('Raster Plot'), xlabel('Neuron #'), ylabel('Neuron #');
legend('Specific Activating Current','Spikes');
