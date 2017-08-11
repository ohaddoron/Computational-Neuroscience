function plot_figures ( settings, params, data, model)

rng(params.seed);
%% plot raster
h = plotRaster(settings,params,data,model);
%% V,u,x,I
indices = 1 : 0.01 * params.num_exitatory;
indices = [indices, indices + 0.1 * params.num_exitatory];
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
%% plot external current
h = figure;
imagesc(data.I);
xlabel('Time [ms]');
ylabel('Neuron #');
b = colorbar;
xlabel(b,'PSP [V]');
title('External Current');
savefig(h,fullfile(settings.path2figures,'External Current'))
saveas(h,fullfile(settings.path2figures,'External Current.bmp'));

