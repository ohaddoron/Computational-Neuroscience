%% load settings params
fprintf('Loading settings and parameters... ');
[settings,params] = load_settings_params();
fprintf('Complete! \n');
%% load data
fprintf('Loading data... ')
data = load_data(settings,params);
fprintf('Complete! \n');
%% model
fprintf('Running simulation... ');
model = LIF_TM_model(settings,params,data);
fprintf('Complete! \n');
%% plot results
fprintf('Plotting figures... ');
plot_figures(settings,params,data,model);
fprintf('Complete! \n');