function plot_figures ( settings, params, data, model)

rng(params.seed);
%% plot u,x,V
% u
stat_data = calc_statistics ( settings, params, model,'u' );
h = plot_stat_data(data,stat_data,{'Utilization';'Factor'});
savefig(h,fullfile(settings.path2figures,'u'))
saveas(h,fullfile(settings.path2figures,'u.bmp'));
% x
stat_data = calc_statistics ( settings, params, model,'x' );
h = plot_stat_data(data,stat_data,{'Available';'Resources'});
savefig(h,fullfile(settings.path2figures,'x'))
saveas(h,fullfile(settings.path2figures,'x.bmp'));

% V
% stat_data = calc_statistics ( settings, params, model,'V' );
% h = plot_stat_data(data,stat_data);
% savefig(h,fullfile(settings.path2figures,'V'))
% saveas(h,fullfile(settings.path2figures,'V.bmp'));


%% plot raster
h = plotRaster(settings,params,data,model);
%% V,u,x,I
indices = 1 : 0.01 * params.num_exitatory;
indices = [indices, indices + 0.1 * params.num_exitatory];
savefig(h,fullfile(settings.path2figures,'Raster Plot'))
saveas(h,fullfile(settings.path2figures,'Raster Plot.bmp'));

%% plot connectivity
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

function h1 = plot_stat_data(data,stat_data,Parameter)
h1 = figure;
subplot(411);
h = errorbar(data.timeVec,stat_data.activated_mean,stat_data.activated_std,'r'); 
set(h,'linestyle','none');
title('Selcetive Activated Group');
ylim([0 1]);
ylabel(Parameter);
set(gca,'FontSize',14);
subplot(412);
h = errorbar(data.timeVec,stat_data.non_activated_selective_mean,stat_data.non_activated_selective_std,'b'); 
set(h,'linestyle','none')
title('Selective Non-Activated Group');
ylim([0 1]);
ylabel(Parameter);
set(gca,'FontSize',14);
subplot(413);
h = errorbar(data.timeVec,stat_data.non_selective_mean,stat_data.non_selective_std,'g');
set(h,'linestyle','none');
title('Non-Selective Non-Activated Group');
ylim([0 1]);
ylabel(Parameter);
set(gca,'FontSize',14);
subplot(414);
h = errorbar(data.timeVec,stat_data.inhibitory_mean,stat_data.inhibitory_std,'y'); 
set(h,'linestyle','none');
title('Inhibitory Group');
xlabel('Time (sec)');
ylim([0 1]);
ylabel(Parameter);
set(gca,'FontSize',14);

return 
