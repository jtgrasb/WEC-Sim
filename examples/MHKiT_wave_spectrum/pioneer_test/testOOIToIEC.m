clear all
close all
clc

load dirSpectrumOOI.mat
spectrumDataOOI = dataWaveSnip;
directionalBinCenters = -180:2:180;

[frequenciesIEC, spectrumIEC, spreadIEC, directionsIEC] = convertOOIToIEC(spectrumDataOOI, directionalBinCenters,1);

%%


directionalBinCenters = wrapTo180(directionalBinCenters);
if any(directionalBinCenters == 180) && any(directionalBinCenters == -180)
    warning(['Directions include both -180 and 180. Removing -180 to avoid duplicate directions.'])
    directionalBinCenters(directionalBinCenters == -180) = [];
end
if length(unique(mod(directionalBinCenters + 180, 360) - 180)) < length(directionalBinCenters)
    error('Duplicate directions were found.')
end

frequenciesOOI = spectrumDataOOI(:,1);
spectrumOOI = spectrumDataOOI(:,2);
directionsOOI = spectrumDataOOI(:,3);
spreadOOI = spectrumDataOOI(:,4);

% convert to IEC: 
directionsIEC = directionalBinCenters;
frequenciesIEC = frequenciesOOI;
spectrumIEC = spectrumOOI;

% for spread, we need to apply gaussian distribution but maintain directions
for ii = 1:length(frequenciesOOI)
    % energyDistribution(ii,:) = (1./(spreadOOI(ii).*sqrt(2*pi))) .* exp(-(wrapTo180(directionalBinEdges - wrapTo180(directionsOOI(ii))).^2) ./ (2.*spreadOOI(ii).^2));
    % checkSum = trapz(directionalBinEdges,energyDistribution(ii,:));
    % if checkSum < 0.95 % if this is true, then less than 95% of the initial energy at this frequency is contained over the considered directions.
    %     warning('Number of spread bins inadequate at frequency number %i. Directional approximation weak. \n \r', ii);
    % end
    % energyDistribution(ii,:) =  energyDistribution(ii,:) ./ checkSum; % scales to 1 so no energy loss in included directions (bad approx if warning is flagged)
    % spreadWeights(ii,:) = diff(cumtrapz(directionalBinEdges,energyDistribution(ii,:)));
    % % sum(spreadWeights(ii,:))

    % convert it to radians for IEC
    spreadOOIRad = deg2rad(spreadOOI(ii));
    directionsRad = deg2rad(wrapTo180(directionalBinCenters - wrapTo180(directionsOOI(ii))));
    energyDistribution(ii,:) = (1./(spreadOOIRad.*sqrt(2*pi))) .* exp(-(directionsRad.^2) ./ (2.*spreadOOIRad.^2));
    checkSum = trapz(deg2rad(directionalBinCenters),energyDistribution(ii,:));
    if checkSum < 0.95 % if this is true, then less than 95% of the initial energy at this frequency is contained over the considered directions.
        warning('Number of spread bins inadequate at frequency number %i. Directional approximation weak. \n \r', ii);
    end
end

figure()
plot(deg2rad(directionalBinCenters),energyDistribution(1,:))
hold on
plot(deg2rad(directionalBinCenters),energyDistribution(22,:))
xline(deg2rad(wrapTo180(directionsOOI(1))),'--')
xline(deg2rad(wrapTo180(directionsOOI(22))),'--')
xlabel('direction (rad)')
ylabel('spread (1/Hz/rad)')
legend('dir weights 1','dir weights 22','mean dir 1','mean dir 22')

spreadIEC = energyDistribution;
spectrumFullDir = spectrumIEC.*spreadIEC;
meanDirection = sum(directionsOOI.*spectrumOOI)/sum(spectrumOOI);

if plotFlag == 1
    [plotDirs,plotFreqs] = meshgrid(directionsIEC,frequenciesIEC);

    figure()
    polarscatter(deg2rad(plotDirs(:)),plotFreqs(:),2,spectrumFullDir(:),'filled')
    hold on
    polarplot(deg2rad([meanDirection meanDirection]), [0 max(plotFreqs(:))], 'k--'); % 
    c = colorbar;
    c.Label.String = 'Spectrum (m^2/Hz/deg)';
    title('Elevation variance spectrum');
    legend('spectrum','approx. mean direction')
end