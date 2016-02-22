matlabpool OPEN
classType = 'car';
% classifierModel = ['models/AcfPku-' classType '-wholeTrainDetector.mat'];
classifierModel = ['models/AcfPku-' classType '-nopad-trainDetector.mat'];

dataDir = '../../../train_merge/whole/pos';
detector = load(classifierModel);
detector = detector.detector;

fprintf('testing detector %s ',classifierModel);
pNms = struct('type',{'maxg'},'overlap',.65,'ovrDnm','union');
pModify=struct('cascThr',-1,'cascCal',0,'pNms',pNms );
detector=acfModify(detector,pModify);


imgNms = bbGt('listFilesPku',dataDir,'jpg');
tic
boxes = acfDetect( imgNms, detector );
toc
boxesSavePath = ['bbsFiles/pku-train_merge' '-' classType '.mat'];
save(boxesSavePath,'boxes');

gtPath = '../../../train_merge/whole/posGt';
recall = evalRecall(gtPath,boxes,classType);
fprintf('recall on %s is %f\n',dataDir,recall);
% I=imread(imgNms{1});figure(1); im(I); bbApply('draw',bbs{1});

matlabpool CLOSE