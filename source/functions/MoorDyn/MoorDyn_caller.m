% function to return any items of interest to coupling from MoorDyn at
% every time step
function FLines = MoorDyn_caller(system, X,XD,Time,CoupTime)
    [t_out, FLines] = MoorDynM_Step(system, X, XD, Time, CoupTime);
end