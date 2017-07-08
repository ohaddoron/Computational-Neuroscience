%% load settings params
[settings,params] = load_settings_params();
%% load data
data = load_data(settings,params);
%% model
model = LIF_TM_model(settings,params,data);
%% raster plot
plotRaster(data.timeVec,model.spike_times);