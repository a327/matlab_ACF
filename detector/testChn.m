pChns = chnsCompute();
I = chnsCompute(lena,pChns);
p=pChns.pGradMag; nm='gradient magnitude';
full=0; if(isfield(p,'full')), full=p.full; end
M=gradientMag(I ,p.colorChn,p.normRad,p.normConst,full);