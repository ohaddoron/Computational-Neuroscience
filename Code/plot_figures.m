function plot_figures ( settings, params, data, model)

rng(params.seed);
%% plot raster
h = plotRaster(settings,params,data,model);
savefig(h,fullfile(settings.path2figures,'Raster Plot'))
saveas(h,fullfile(settings.path2figures,'Raster Plot.bmp'));

%% draw connectivity
 h = figure;
imagesc(data.connectivity);
xlabel('Neuron #');
ylabel('Neuron #');
b = colorbar;
xlabel(b,'Connection Strength');
title('Neuron Connectivity Map');
leg = {'Activated Group','Other Groups'};
savefig(h,fullfile(settings.path2figures,'Connectivity Map'))
saveas(h,fullfile(settings.path2figures,'Connectivity Map.bmp'));
%% V,u,x,I
neuron_idx1 = randsample(1:params.num_neurons_group,1); % draw a neuron index from the first group
neuron_idx2 = randsample(params.num_neurons_group+1:2 * params.num_neurons_group,1); % draw a neuron index from the second group
h = figure;
subplot(4,1,1), hold on
plot(data.timeVec,model.V(neuron_idx1,:)), plot(data.timeVec,model.V(neuron_idx2,:));
title('Potential'), legend(leg,'Location','EastOutside');
subplot(4,1,2), hold on
plot(data.timeVec,model.u(neuron_idx1,:)), plot(data.timeVec,model.u(neuron_idx2,:));
title('u'), legend(leg,'Location','EastOutside');
subplot(4,1,3), hold on
plot(data.timeVec,model.x(neuron_idx1,:)), plot(data.timeVec,model.x(neuron_idx2,:));
title('x'), legend(leg,'Location','EastOutside');
subplot(4,1,4), hold on
plot(data.timeVec,model.I_s(neuron_idx1,:)), plot(data.timeVec,model.I_s(neuron_idx2,:));
title('I_{synaptic}'), legend(leg,'Location','EastOutside');
savefig(h,fullfile(settings.path2figures,'Example Neurons'))
saveas(h,fullfile(settings.path2figures,'Example Neurons.bmp'));

