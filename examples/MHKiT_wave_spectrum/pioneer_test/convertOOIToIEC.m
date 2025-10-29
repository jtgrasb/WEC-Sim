function [frequenciesIEC, spectrumIEC, spreadIEC, directionsIEC] = convertOOIToIEC(spectrumDataOOI, directionalBinCenters, plotFlag)

    directionalBinCenters = wrapTo180(directionalBinCenters);
    if any(directionalBinCenters == 180) && any(directionalBinCenters == -180)
        warning('Directions include both -180 and 180. Removing -180 to avoid duplicate directions.')
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
    directionsIEC = directionalBinCenters(:);
    frequenciesIEC = frequenciesOOI;
    spectrumIEC = spectrumOOI;
    
    % for spread, we need to apply gaussian distribution but maintain directions
    for ii = 1:length(frequenciesOOI)
        % convert it to radians for IEC spread calculation
        spreadOOIRad = deg2rad(spreadOOI(ii));
        directionsRad = deg2rad(wrapTo180(directionalBinCenters - wrapTo180(directionsOOI(ii))));
        spreadIEC(ii,:) = (1./(spreadOOIRad.*sqrt(2*pi))) .* exp(-(directionsRad.^2) ./ (2.*spreadOOIRad.^2));
        checkSum = trapz(deg2rad(directionalBinCenters),spreadIEC(ii,:));
        if checkSum < 0.95 % if this is true, then less than 95% of the initial energy at this frequency is contained over the considered directions.
            warning('Number of spread bins inadequate at frequency number %i. Directional approximation weak. \n \r', ii);
        end
    end

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
        legend('spectrum','approx. mean direction','Location','northwest')
    end

end