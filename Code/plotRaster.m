function h = plotRaster ( settings , params , data, model )

%% init
h = figure;
t = repmat(data.timeVec,params.num_neurons,1);
spikes = bsxfun(@times,model.spike_times,(1:params.num_neurons)');
indices = ~logical(spikes);
t(indices) = nan;
spikes(indices) = nan;
%% plot
scatter(t(:),spikes(:),1,'k','filled');
axis([0,params.simulation_time,0,params.num_neurons]);
hold on
X = [0 params.activation_time params.activation_time 0];
y = ylim;
Y = [0 0 y(2) y(2)];
patch(X,Y,0.3 * [1 1 1],'FaceAlpha',0.4)
set(gca,'children',flipud(get(gca,'children')));
title('Raster Plot'), xlabel('Neuron #'), ylabel('Neuron #');
legend('Specific Activating Current','Spikes');
