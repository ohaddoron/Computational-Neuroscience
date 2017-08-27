function unite_figures (settings,params,type) 
%% load figures
h0 = openfig(fullfile(settings.path2figures,strcat(type,'0')));
h1 = openfig(fullfile(settings.path2figures,strcat(type,'1')));
%% get axes
ax0 = h0.Children;
ax1 = h1.Children;
ax0 = flipud(ax0);
ax1 = flipud(ax1);
legends = {'Specific Activated Group','Specific Non-Activated Group',...
    'Non-Specific Non-Activated Group','Inhibitory Group'};
%% plot on new figure
% h = figure; 
num_plots = length(ax0) ;
count = 1;
h = figure('Visible','on');
s = subplot(1,1,1);

% for i = 1 : num_plots
% %     title('With Specific and Non-Specific Activations');
%     fig0 = get(ax0(i),'children');
% %     fig1 = get(ax1(i),'children');
% %     s = subplot(num_plots,2,count);
%     copyobj(fig0,s);
%     ylim([0 1]);
%     
% %     if i == num_plots 
% %         title('Without Specific or Non-Specific Activations');
% %     end
% %     s = subplot(num_plots,2,count + 1);
% %     copyobj(fig1,h.CurrentAxes);
% %     if i == num_plots 
% %         title('With Specific and Non-Specific Activations');
% %     end
% %     count = count + 1;
%     
% end
% leg = legend(legends);
for i = 1 : num_plots
    fig0 = get(ax0(i),'children');
    fig1 = get(ax1(i),'children');
    s = subplot(num_plots,2,count);
    copyobj(fig0,s);
    ylim([0 1]);
    
    if i == 1 
        t = title('Without Specific or Non-Specific Activations');
        t.FontSize = 16;
    end
    s = subplot(num_plots,2,count + 1);
    copyobj(fig1,s);
    ylim([0 1]);
    if i == 1 
        t = title('With Specific and Non-Specific Activations');
        t.FontSize = 16;
    end
    count = count + 2;
    
end
t = suptitle(sprintf('%s vs Time',type));
savefig(h,fullfile(settings.path2figures,strcat(type,'_United')));
saveas(h,fullfile(settings.path2figures,strcat(type,'_United')),'emf');
