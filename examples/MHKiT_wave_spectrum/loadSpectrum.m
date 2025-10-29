clear all
close all
clc

omnidirectionalSpectrum = ncread("omnidirectional_spectrum.nc","__xarray_dataarray_variable__"); % m^2/Hz
spread = ncread("spread.nc","__xarray_dataarray_variable__"); % 1/Hz/deg
spread_no_neg = ncread("spread_no_neg.nc","__xarray_dataarray_variable__"); % 1/Hz/deg
frequency = ncread("spread.nc","frequency"); % Hz
direction = ncread("spread.nc","direction"); % deg

% make frequency uniform
frequencyUniform = 0.01:0.01:0.5;
omnidirectionalSpectrum = interp1(frequency,omnidirectionalSpectrum,frequencyUniform,'linear','extrap');
spread = interp1(frequency,spread',frequencyUniform,'linear','extrap');
spread_no_neg = interp1(frequency,spread_no_neg',frequencyUniform,'linear','extrap');
spread = spread';
spread_no_neg = spread_no_neg';

% waves = waveClass('spectrumImportFullDir');
% waves.direction = waveDirs(waveNum); 
% waves.spectrumFile = (waveFiles(waveNum));
% waves.freqDepDirection.nBins = 10; % for example
% waves.freqDepDirection.spreadRange = 2; % for example
% waves.waterDepth = 30;
% waves.phaseSeed = 1;

% create full directional spectrum (m^2/Hz/deg)
S = spread.*omnidirectionalSpectrum; % S(f,theta) = D(f,theta)*S(f)
S_no_neg = spread_no_neg.*omnidirectionalSpectrum;

directionRad = direction*pi/180;
dTheta = directionRad(2) - directionRad(1);
checkS = zeros(length(frequency),1);
% check whether total energy remains the same
for ii = 1:length(frequencyUniform)
    checkS(ii) = sum(S(:,ii))*dTheta;
end

figure()
plot(frequencyUniform,omnidirectionalSpectrum')
hold on
plot(frequencyUniform,checkS,'--')
xlabel('freq (Hz)')
ylabel('spectrum (m^2/Hz)')
legend('omin-directional spectrum','check spectrum')

omega = frequencyUniform*2*pi;
dOmega = omega(2) - omega(1);

ts = 0:.01:100;
s = RandStream('Threefry', 'Seed', 1);  % Global fixed seed
s.Substream = 1;           % Substream based on phaseSeed
RandStream.setGlobalStream(s);         % Set globally
phase = 2*pi*rand(length(direction),length(frequencyUniform));

% how to calculate wave elevation based on full directional spectrum?
for ii = 1:length(ts)
    waveElevation(ii) = sum(sqrt(2*S*dOmega*dTheta).*cos(repmat(omega,[length(direction),1]).*ts(ii) + phase),'all');
    waveElevation2(ii) = sum(sqrt(2*S*dOmega*dTheta).*real(exp(sqrt(-1).*(repmat(omega,[length(direction),1]).*ts(ii) + phase))),'all');
    waveElevation_no_neg(ii) = sum(sqrt(2*S_no_neg*dOmega*dTheta).*cos(repmat(omega,[length(direction),1]).*ts(ii) + phase),'all');
end

figure()
plot(ts,waveElevation);
hold on
plot(ts,waveElevation2,'--');
plot(ts,waveElevation_no_neg,'-.');
xlabel('time (s)')
ylabel('wave elevation at origin (m)')
legend('WEC-Sim method','Paper method','No neg spread')

% save in WEC-Sim format
spectrum = omnidirectionalSpectrum';
spread = spread_no_neg';
frequencies = frequencyUniform';
directions = direction; % degrees
 
save 'fullDirSpectrum.mat' spectrum spread frequencies directions