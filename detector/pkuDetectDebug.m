
classifierModel = 'models/AcfPku-person-nopad-trainDetector.mat';
detector = load(classifierModel);
detector = detector.detector;

pNms = struct('type',{'maxg'},'overlap',.65,'ovrDnm','min');
pModify=struct('cascThr',0.8,'cascCal',0,'pNms',pNms );
detector=acfModify(detector,pModify);

% imgNms = '..\..\..\PKU2015\train\dongcemen_6_1280x720_30_2\pos\0000076.jpg';
% boxes = acfDetect( imgNms, detector );

imNms = '40.jpg';
tic,boxes = acfDetect(imNms,detector);toc
im(imread(imNms));
bbApply('draw',boxes);