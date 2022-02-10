function Plot_BEMIO(hydro,varargin)
% Plots the added mass, radiation damping, radiation IRF, excitation force magnitude, excitation force phase, and excitation IRF for each body in the heave, surge and pitch degrees of freedom.
% 
% Plot_BEMIO(hydro)
%     hydro – data structure
% 
% See ‘...WEC-Sim\examples\BEMIO...’ for examples of usage.

% p = waitbar(0,'Plotting BEMIO results…');  % Progress bar

%% Added Mass
Plot_AddedMass(hydro,varargin)

%% Radiation Damping
Plot_RadiationDamping(hydro,varargin)

%% Radiation IRFs
Plot_RadiationIRF(hydro,varargin)

%% Excitation Force Magnitude
Plot_ExcitationMagnitude(hydro,varargin)

%% Excitation Force Phase
Plot_ExcitationPhase(hydro,varargin)

%% Excitation IRFs
Plot_ExcitationIRF(hydro,varargin)

end

