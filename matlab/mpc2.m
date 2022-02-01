function output = mpc2(inputs)
persistent s a icount

if (isempty(icount))    
    % Select server and application name
    s = 'http://byu.apmonitor.com';
    %s = 'http://127.0.0.1/apm_windows';    
    a = ['controller' int2str(rand()*1000)];
    % Initialize MPC controller
    mpc_init(s,a)
    % Initialize counter
    icount = 0;
    % first cycle, set u = 3
    u = 3;
else
    icount = icount + 1;
    % process inputs
    xsp = inputs(1);
    x_meas = inputs(2);
    d_meas = inputs(3);
    ex_meas = inputs(4);
    
    % Input setpoint and measurements
    apm_option(s,a,'x.sphi',xsp+1);
    apm_option(s,a,'x.splo',xsp-1);
    apm_meas(s,a,'x',x_meas);
    apm_meas(s,a,'d',d_meas);
    apm_meas(s,a,'ex',ex_meas);
    
    % Solve
    output = apm(s,a,'solve');
    disp(output)
    
    % Output parameters, check if good solution
    if (apm_tag(s,a,'nlc.appstatus')==1),
        u = apm_tag(s,a,'u.newval');
    else
        u = 0;
    end
end

% output Tc value
if isnan(u)
    % protect outputs against bad solutions
    output = 0;
else
    output = u;
end

if (icount==5)
    % open web-viewer
    apm_web(s,a);
end

return