
pYaw = body(1).yaw.option;
A = waves.amplitude;
w = waves.omega;
dofGRD = body(1).hydroForce.hf1.fExt.dofGrd;
dirGRD = body(1).hydroForce.hf1.fExt.dirGrd;
wGRD = body(1).hydroForce.hf1.fExt.wGrd;
qDofGRD = body(1).hydroForce.hf1.fExt.qDofGrd;
qWGRD = body(1).hydroForce.hf1.fExt.qWGrd;
fEHRE = body(1).hydroForce.hf1.fExt.fEHRE;
fEHIM = body(1).hydroForce.hf1.fExt.fEHIM;
fEHMD = body(1).hydroForce.hf1.fExt.fEHMD;
phaseRand = waves.phase;
dw = waves.dOmega;
time = 0;
directions = waves.fullDirectionalSpectrum.directions;
Disp = zeros(6,1);
intThresh = body(1).yaw.threshold;
prevYaw = zeros(length(waves.fullDirectionalSpectrum.directions),1);
prevCoeffMD = zeros(length(waves.fullDirectionalSpectrum.directions),length(waves.omega),6);
prevCoeffRE = zeros(length(waves.fullDirectionalSpectrum.directions),length(waves.omega),6);
prevCoeffIM = zeros(length(waves.fullDirectionalSpectrum.directions),length(waves.omega),6);

[Fext,relYawLast,coeffsLastMD,coeffsLastRE,coeffsLastIM] = irregExcFullDirF(pYaw,A,w,dofGRD,dirGRD,wGRD,qDofGRD,qWGRD,fEHRE,fEHIM, fEHMD, phaseRand,dw,time, directions, Disp, intThresh, prevYaw, prevCoeffMD, prevCoeffRE, prevCoeffIM);
