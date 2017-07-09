function plotRaster ( settings , params , data, model )

%% init
t = repmat(data.timeVec,params.num_neurons,1);
spikes = bsxfun(@times,model.spike_times,(1:params.num_neurons)');
indices = ~logical(spikes);
t(indices) = nan;
spikes(indices) = nan;
%% plot
figure, scatter(t(:),spikes(:),3,'k','filled');
axis([0,params.simulation_time,0,params.num_neurons]);
