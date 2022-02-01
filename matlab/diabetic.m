function [sys,x0,str,ts,simStateCompliance] = diabetic(t,y,u,flag)

switch flag
    
    %%%%%%%%%%%%%%%%%%
    % Initialization %
    %%%%%%%%%%%%%%%%%%
    case 0,
        [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes();
        
        %%%%%%%%%%%%%%%
        % Derivatives %
        %%%%%%%%%%%%%%%
    case 1,
        sys=mdlDerivatives(t,y,u);
        
        %%%%%%%%%%
        % Update %
        %%%%%%%%%%
    case 2,
        sys=mdlUpdate(t,y,u);
        
        %%%%%%%%%%%
        % Outputs %
        %%%%%%%%%%%
    case 3,
        sys=mdlOutputs(t,y,u);
        
        %%%%%%%%%%%%%%%%%%%%%%%
        % GetTimeOfNextVarHit %
        %%%%%%%%%%%%%%%%%%%%%%%
    case 4,
        sys=mdlGetTimeOfNextVarHit(t,y,u);
        
        %%%%%%%%%%%%%
        % Terminate %
        %%%%%%%%%%%%%
    case 9,
        sys=mdlTerminate(t,y,u);
        
        %%%%%%%%%%%%%%%%%%%%
        % Unexpected flags %
        %%%%%%%%%%%%%%%%%%%%
    otherwise
        DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));
        
end

% end sfuntmpl

%
%=============================================================================
% mdlInitializeSizes
% Return the sizes, initial conditions, and sample times for the S-function.
%=============================================================================
%
function [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes()

%
% call simsizes for a sizes structure, fill it in and convert it to a
% sizes array.
%
% Note that in this example, the values are hard coded.  This is not a
% recommended practice as the characteristics of the block are typically
% defined by the S-function parameters.
%
sizes = simsizes;

sizes.NumContStates  = 9;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 1;
sizes.NumInputs      = 3;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 1;   % at least one sample time is needed

sys = simsizes(sizes);
%
% initialize the initial conditions
% SS for insulin injection of 2.0.
x0 = [80   0   0    0  0    0    0    0   0]';
% SS for insulin injection of 3.0.
%x0 = [ 76.2159   33.3333   33.3333   16.6667   16.6667  250.0000]';
%
% str is always an empty matrix
%
str = [];

%
% initialize the array of sample times
%
ts  = [0 0];

% Specify the block simStateCompliance. The allowed values are:
%    'UnknownSimState', < The default setting; warn and assume DefaultSimState
%    'DefaultSimState', < Same sim state as a built-in block
%    'HasNoSimState',   < No sim state
%    'DisallowSimState' < Error out when saving or restoring the model sim state
simStateCompliance = 'UnknownSimState';

% end mdlInitializeSizes

%==========================================================
% mdlDerivatives
% Return the derivatives for the continuous states.
%=============================================================================
%
function sys=mdlDerivatives(t,y,u)
%
% Model source:
% R. Palma and T.F. Edgar, Toward Patient Specific Insulin Therapy: A Novel
%    Insulin Bolus Calculator.  In Proceedings Texas Wisconsin California Control
%    Consortium, Austin, TX, Feb. 7-8, 2011.
%
% Expanded Bergman Minimal model to include meals and insulin
% Parameters for an insulin dependent type-I diabetic

% Inputs (2):
% Insulin infusion rate
ui = u(1);               % micro-U/min

% meals
d = u(2);

%u3*pvo
ex = u(3);

%meals 
%ggly = u(4);

% States (6):
% In non-diabetic patients, the body maintains the blood glucose level at a
%   range between about 3.6 and 5.8 mmol/L (64.8 and 104.4 mg/dL).
g     = y(1,1);               % blood glucose (mg/dl)
x     = y(2,1);               % remote insulin (micro-u/ml)
i     = y(3,1);               % insulin (micro-u/ml)
PVO   = y(4,1);                 % gut blood glucose (mg/dl)
gprod = y(5,1);
gup   = y(6,1);
ie    = y(7,1);
at    = y(8,1);
ggly  = y(9,1);
 

% Parameters:
gb   = 80;             % Basal Blood Glucose (mg/dL)
vg   = 117.0;            % dL
n    = 0.142;           %1/min
p4   = 0.098;            %1/ml   
p2   = 0.05;             %1/min
p3   = 0.000028;        % ml/uU*min^2
p1   = 0.035;           %1/min
a1   = 0.00158;         %mg/kg*min^2
a2   = 0.055;            %1/min
si   = 2.9e-2;          % 1/min * (mL/micro-U)
a3   = 0.00195;         %mg/kg*min^2
a4   = 0.0485;          %1/min
a5   = 0.00125;         %uU/ml*min
a6   = 0.075;           %1/min
f    = 8.00e-1;         % L
k    =0.0108;
T1   = 6;
W    = 70;               %Kg
ib   = (p4/n)*ui ;             % ib = (p4/n)*ui = (0.098/0.142) *2 
Ath  = -1.1521*(ex^2) + 87.471*ex;

% Compute ydot:
sys(1,1) = -p1*(g-gb) -x*g + (W/vg)*(gprod - ggly) - ...
    W/vg * gup + d/vg ;  % glucose dynamics

sys(2,1) = - p2*x + p3*(i-ib);             % remote insulin compartment dynamics

sys(3,1) = -n*i + p4*ui - ie;            % insulin dynamics

sys(4,1) = -0.8*PVO + 0.8*ex;

sys(5,1) = a1*PVO - a2*gprod;

sys(6,1) = a3*PVO - a4*gup;

sys(7,1) = a5*PVO - a6*ie;


sys(8,1) = ex - at/0.001;
% if (ex > 0)
%    sys(8,1) = 0;
% elseif (ex == 0) 
%     sys(8,1)= - at/0.001;
% end

%b = at - Ath ;

if at > Ath 
   sys(9,1) = 0;    
elseif at > Ath 
   sys(9,1) = k;
else
   sys(9,1)= -ggly/T1 >0;  
end 
% convert from minutes to hours
sys = sys*60;
% end mdlDerivatives

%
%=============================================================================
% mdlUpdate
% Handle discrete state updates, sample time hits, and major time step
% requirements.
%=============================================================================
%
function sys=mdlUpdate(t,y,u)

sys = [];

% end mdlUpdate

%
%=============================================================================
% mdlOutputs
% Return the block outputs.
%=============================================================================
%
function sys=mdlOutputs(t,y,u)

y1 = y(1);

sys = [y1];

% end mdlOutputs

%
%=============================================================================
% mdlGetTimeOfNextVarHit
% Return the time of the next hit for this block.  Note that the result is
% absolute time.  Note that this function is only used when you specify a
% variable discrete-time sample time [-2 0] in the sample time array in
% mdlInitializeSizes.
%=============================================================================
%
function sys=mdlGetTimeOfNextVarHit(t,y,u)

sampleTime = 1;    %  Example, set the next hit to be one second later.
sys = t + sampleTime;

% end mdlGetTimeOfNextVarHit

%
%=============================================================================
% mdlTerminate
% Perform any end of simulation tasks.
%=============================================================================
%
function sys=mdlTerminate(t,y,u)

sys = [];

% end mdlTerminate
