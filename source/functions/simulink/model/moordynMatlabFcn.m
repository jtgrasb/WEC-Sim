function lineForces = moordynMatlabFcn(disp,vel,time,dt)
    % function calls the moordyn caller function
    lineForces = zeros(1,length(disp));
    coder.extrinsic('moordynCaller');
    lineForces = moordynCaller(disp,vel,time-dt,dt);
end