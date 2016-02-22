% set the camera and the class type
matlabpool OPEN
% cameras = {'dongcemen_6_1280x720_30_2' 'dongnanmen_1_1280x720_30_2' 'hongsilounorth_13_1920x1080_30_1' ...
%     'hongsilouwest_14_1920x1080_30_1' 'weiminghubeieast_11_1920x1080_30_1' 'weiminghubeiwest_12_1920x1080_30_1' ...
%     'weiminghudong_7_1280x720_30_2' 'yaoganqian_5_1280x720_30_2'};

cameras = {'dongcemen_6_1280x720_30_2' 'weiminghudong_7_1280x720_30_2'...
          'dongnanmen_1_1280x720_30_2' 'yaoganqian_5_1280x720_30_2'};
recall = zeros(length(cameras),1);
classType = 'car';
detectorModel = ['models/AcfPku-' classType '-nopad-trainDetector.mat'];

for i=1:length(cameras)
    camera = cameras{i};
    dataDir = ['../../../PKU2015/new_eval/' camera];% '/pos'];
    fprintf('testing for %s type %s ',camera,classType);
    detector = load(detectorModel);
    detector = detector.detector;
    pNms = struct('type',{'maxg'},'overlap',.65,'ovrDnm','union');
    pModify=struct('cascThr',-1,'cascCal',0,'pNms',pNms);
    detector=acfModify(detector,pModify);
    boxesSavePath = ['bbsFiles/new_eval-' camera '-' classType '.mat'];
    imgNms = bbGt('listFilesPku',dataDir,'jpg');
    tic
    boxes = acfDetect( imgNms, detector );
    toc
    save(boxesSavePath,'boxes');
%     gtPath = ['../../../PKU2015/eval/' camera '/posTxt'];
%     recall(i) = evalRecall(gtPath,boxes,classType);
%     fprintf('recall for camera %s is %f saving boxes in %s\n',camera,recall(i),boxesSavePath);
end

matlabpool CLOSE
