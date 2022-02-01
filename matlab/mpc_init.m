function msg = mpc_init(s,a)

% -------------------------------------------
% Setting up APMonitor
% For any tutorials see
% http://apmonitor.com/wiki/index.php/Main/MATLAB
% -------------------------------------------

% Add path to APM libraries
addpath('apm');

% Clear previous application
apm(s,a,'clear all');

% Load model
apm_load(s,a,'mpc.apm');

% Load data
csv_load(s,a,'mpc.csv');

%%  APM Variable Classification
apm_info(s,a,'FV','d');
apm_info(s,a,'MV','u');
apm_info(s,a,'CV','x');

%% Options
apm_option(s,a,'nlc.imode',6);
apm_option(s,a,'nlc.nodes',3);
apm_option(s,a,'nlc.cv_type',1);
apm_option(s,a,'nlc.web_plot_freq',1);
% Bounds
apm_option(s,a,'u.lower',0);
apm_option(s,a,'u.upper',10);
% Turn on status for MV / CV
apm_option(s,a,'u.status',1);
apm_option(s,a,'x.status',1);
% Turn on measurment for FV, CV and off for MV
apm_option(s,a,'d.fstatus',1);
apm_option(s,a,'u.fstatus',0);
apm_option(s,a,'x.fstatus',1);
% Tune MV and CV
apm_option(s,a,'u.dcost',0.1);
apm_option(s,a,'u.dmaxhi',1.5);
apm_option(s,a,'u.dmaxlo',-10);
apm_option(s,a,'x.tau',1.0);
apm_option(s,a,'x.tr_init',0);
apm_option(s,a,'x.tr_open',0);

return