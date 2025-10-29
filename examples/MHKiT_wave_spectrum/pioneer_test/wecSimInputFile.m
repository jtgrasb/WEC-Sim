%% Simulation Data
simu = simulationClass();                    % Initialize Simulation Class
simu.simMechanicsFile = 'OSWEC.slx';    % Specify Simulink Model File
simu.mode      = 'normal';                   % Specify Simulation Mode ('normal','accelerator','rapid-accelerator')
simu.explorer  = 'on';                       % Turn SimMechanics Explorer (on/off)
simu.startTime = 0;                          % Simulation Start Time [s]
simu.endTime   = 10;                       % Simulation End Time [s]
simu.rampTime  = 0.05*simu.endTime;          % Wave Ramp Time [s]
simu.solver    = 'ode23t';                   % simu.solver = 'ode4' for fixed step & simu.solver = 'ode45' for variable step 
simu.dt        = 0.05; 					  	 % Simulation time-step [s]
simu.cicEndTime = 30;

%% Wave Information 
% % Full directional waves
% waves = waveClass('spectrumImportFullDir');
% waves.spectrumFile = ('fullDirSpectrum.mat');

% waves = waveClass('spectrumImportFullDir');
% waves.direction = -74.4436; 
% waves.spectrumFile = 'dirSpectrumOOI.mat';
% waves.freqDepDirection.nBins = 10; % for example
% waves.freqDepDirection.spreadRange = 2; % for example
% waves.waterDepth = 30;
% waves.phaseSeed = 1;

load dirSpectrumOOI.mat
spectrumDataOOI = dataWaveSnip;
directionalBinCenters = -180:2:180;

[frequencies, spectrum, spread, directions] = convertOOIToIEC(spectrumDataOOI, directionalBinCenters,1);

save 'fullDirSpectrum.mat' spectrum spread frequencies directions

waves = waveClass('spectrumImportFullDir');
waves.spectrumFile = ('fullDirSpectrum.mat');

%% Body Data
% Flap
body(1) = bodyClass('hydroData/oswec.h5');      % Initialize bodyClass for Flap
body(1).geometryFile = 'geometry/flap.stl';     % Geometry File
body(1).mass = 127000;                          % User-Defined mass [kg]
body(1).inertia = [1.85e6 1.85e6 1.85e6];       % Moment of Inertia [kg-m^2]

% Base
body(2) = bodyClass('hydroData/oswec.h5');      % Initialize bodyClass for Base
body(2).geometryFile = 'geometry/base.stl';     % Geometry File
body(2).mass = 999;                             % Placeholder mass for a fixed body
body(2).inertia = [999 999 999];                % Placeholder inertia for a fixed body

%% PTO and Constraint Parameters
% Fixed
constraint(1)= constraintClass('Constraint1');  % Initialize ConstraintClass for Constraint1
constraint(1).location = [0 0 -10];             % Constraint Location [m]

% Rotational PTO
pto(1) = ptoClass('PTO1');                      % Initialize ptoClass for PTO1
pto(1).stiffness = 0;                           % PTO Stiffness Coeff [Nm/rad]
pto(1).damping = 12000;                         % PTO Damping Coeff [Nsm/rad]
pto(1).location = [0 0 -8.9];                   % PTO Location [m]

