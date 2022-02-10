clear all;clc; close all
%% From hydro structure (before h5)

WAMIT_hydro = struct();
WAMIT = 'C:\Users\kmruehl\Documents\GitHub\WEC-Sim\WEC-Sim\examples\BEMIO\WAMIT\RM3\rm3.out';

WAMIT_hydro = Read_WAMIT(WAMIT_hydro,WAMIT,[]);
WAMIT_hydro = Radiation_IRF(WAMIT_hydro,20,[],[],[],[]);
% % WAMIT_hydro = Radiation_IRF_SS(WAMIT_hydro,[],[]);
WAMIT_hydro = Excitation_IRF(WAMIT_hydro,20,[],[],[],[]);
% Write_H5(WAMIT_hydro)


% clc; clear all; close all;
AQWA_hydro = struct();
AQWA_AH1 = 'C:\Users\kmruehl\Documents\GitHub\WEC-Sim\WEC-Sim\examples\BEMIO\AQWA\RM3\RM3.AH1';
AQWA_LIS = 'C:\Users\kmruehl\Documents\GitHub\WEC-Sim\WEC-Sim\examples\BEMIO\AQWA\RM3\RM3.LIS';

AQWA_hydro = Read_AQWA(AQWA_hydro, AQWA_AH1, AQWA_LIS);
AQWA_hydro = Radiation_IRF(AQWA_hydro,150,[],[],[],[]);
% % AQWA_hydro = Radiation_IRF_SS(AQWA_hydro,[],[]);
AQWA_hydro = Excitation_IRF(AQWA_hydro,150,[],[],[],[]);
% Write_H5(AQWA_hydro)


Plot_AddedMass(WAMIT_hydro)
Plot_AddedMass(AQWA_hydro)
Plot_AddedMass(WAMIT_hydro,AQWA_hydro)
Plot_RadiationDamping(WAMIT_hydro,AQWA_hydro)

Plot_BEMIO(WAMIT_hydro,AQWA_hydro)

%% from h5 file

% WAMIT = 'rm3.h5';
% WAMIT = 'C:\Users\kmruehl\Documents\GitHub\WEC-Sim\WEC-Sim\examples\BEMIO\WAMIT\RM3\rm3.h5';
% % h5disp(WAMIT)
% WAMIT_body1 = readBEMIOH5(WAMIT,1);
% WAMIT_body2 = readBEMIOH5(WAMIT,2);
% 
% AQWA = 'C:\Users\kmruehl\Documents\GitHub\WEC-Sim\WEC-Sim\examples\BEMIO\AQWA\RM3\rm3.h5';
% % h5disp(AQWA)
% AQWA_body1 = readBEMIOH5(AQWA,1);
% AQWA_body2 = readBEMIOH5(AQWA,2);
% 
% 
% Plot_BEMIO(WAMIT_body1)
% hold on
% Plot_BEMIO(AQWA_body1)

