% Demo for Edge Boxes (please see readme.txt first).

matlabpool open
%% load pre-trained edge detection model and set opts (see edgesDemo.m)
model=load('models/forest/modelBsds'); model=model.model;
model.opts.multiscale=0; model.opts.sharpen=2; model.opts.nThreads=4;

%% set up opts for edgeBoxes (see edgeBoxes.m)
opts = edgeBoxes;
opts.alpha = .65;     % step size of sliding window search
opts.beta  = .75;     % nms threshold for object proposals
opts.minScore = .01;  % min score of boxes to detect
opts.maxBoxes = 500;  % max number of boxes to detect

dataDir = '../../../PKU2015/new_eval';
cameras = {'dongcemen_6_1280x720_30_2' 'dongnanmen_1_1280x720_30_2' ...
    'weiminghudong_7_1280x720_30_2' 'yaoganqian_5_1280x720_30_2'};
%% detect Edge Box bounding box proposals (see edgeBoxes.m)
for i=1:length(cameras)
    camera = cameras{i};
    imgDir = fullfile(dataDir,camera);
    imNms = bbGt('listFilesPku',imgDir,'jpg');
    fprintf('Edge boxes for %s ',camera);
    tic, bbs=edgeBoxes(imNms,model,opts); toc
    savePath = fullfile('bbs',['new_eval-' camera '-edgebox-500-car.mat']);
    save(savePath,'bbs');
end

matlabpool close

