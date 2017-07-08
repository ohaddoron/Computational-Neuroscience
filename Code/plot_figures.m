function plot_figures ( settings, params, data, model)

%% draw connectivity
 h = figure;
imagesc(data.connectivity_map);
xlabel('Neuron #');
ylabel('Neuron #');
b = colorbar;
xlabel(b,'Connection Strength');
title('Neuron Connectivity Map');
savefig(h,fullfile(settings.path2figures,'Connectivity Map'))
%% V,u,x,I
neuron_idx1 = randsample(1:params.num_neurons_group,1);
neuron_idx2 = randsample(params.num_neurons_group:2 * params.num_neurons_group,1);
h = figure;
subplot(4,1,1), hold on
plot(model.V(neuron_idx1,:)), plot(model.V(neuron_idx2,:));
title('Potential'), legend('Activated Group','Rest');
subplot(4,1,2), hold on
plot(model.u(neuron_idx1,:)), plot(model.u(neuron_idx2,:));
title('u'), legend('Activated Group','Rest');
subplot(4,1,3), hold on
plot(model.x(neuron_idx1,:)), plot(model.x(neuron_idx2,:));
title('x'), legend('Activated Group','Rest');
subplot(4,1,4), hold on
plot(model.I_s(neuron_idx1,:)), plot(model.I_s(neuron_idx2,:));
title('I_{synaptic}'), legend('Activated Group','Rest');

%% plot raster
plotRaster(settings,params,data,model);
