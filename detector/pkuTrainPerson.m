% train ACF detector for pku dataset
%% extract training and testing images and ground truth
% matlabpool OPEN
cd(fileparts(which('pkuTrainPerson.m'))); dataDir='../../../train_merge/';
classType = 'person';

%% set up opts for training detector (see acfTrain)
opts=acfTrain(); 
opts.modelDs=[52 20]; 
opts.modelDsPad=[52 20];
% opts.modelDsPad=[64 32];  %person class model size
% opts.nPos=20000;
opts.nNeg=15000; opts.nAccNeg=25000;

opts.posGtDir=[dataDir 'posGt']; opts.nWeak=[32 128 512 2048];
opts.pBoost.pTree.maxDepth=5; opts.pBoost.discrete=0;
opts.pBoost.pTree.fracFtrs=1/16;
opts.pPyramid.pChns.pGradHist.softBin=1; opts.pJitter=struct('flip',1);
opts.pPyramid.pChns.shrink=2; 
opts.posImgDir=[dataDir 'pos']; opts.pJitter=struct('flip',1);
opts.negImgDir=[dataDir 'neg-' classType]; 
pLoad={'lbls',{classType}};
opts.pLoad = [pLoad 'hRng',[40 inf], 'wRng',[15 50] ];
opts.name=['models/AcfPku-' classType '-debug-train'];
% opts.winsSave=1;

%% train detector (see acfTrain)
detector = acfTrain( opts );

pkuDetectWhole;

