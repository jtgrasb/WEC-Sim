function FLines  = MoorDyn_matlab_FCN(system, X,XD,Time,CoupTime)

    FLines = zeros(1,6);
    coder.extrinsic('MoorDyn_caller');
    
    FLines = MoorDyn_caller(system, X,XD,Time-CoupTime,CoupTime);
end