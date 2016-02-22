% train ACF detector for pku dataset
%% extract training and testing images and ground truth
% matlabpool OPEN
cd(fileparts(which('pkuTrainCar.m'))); dataDir='../../../train_merge/';
classType = 'car';

%% set up opts for training detector (see acfTrain)
opts=acfTrain(); 
opts.modelDs=[96 124]; 
opts.modelDsPad=[96 124];
% opts.modelDs=[52 20]; 
% opts.modelDsPad=[52 20];
% opts.modelDsPad=[108 136]; %car class model size
% opts.nNeg=15000; opts.nAccNeg=25000;
opts.nNeg=500;

opts.posGtDir=[dataDir 'debugGt']; opts.nWeak=[32 128 512 2048];
opts.pBoost.pTree.maxDepth=5; opts.pBoost.discrete=0;
opts.pBoost.pTree.fracFtrs=1/16;
opts.pPyramid.pChns.pGradHist.softBin=1; opts.pJitter=struct('flip',1);
opts.pPyramid.pChns.shrink=4; 
opts.posImgDir=[dataDir 'debug']; opts.pJitter=struct('flip',1);
opts.negImgDir=[dataDir 'neg-' classType]; 
pLoad={'lbls',{classType}};
opts.pLoad = pLoad ;%'hRng',[70 120], 'wRng',[80 inf]];
opts.name=['models/AcfPku-' classType '-debug-train'];
% opts.winsSave=1;

%% train detector (see acfTrain)
detector = acfTrain( opts );

