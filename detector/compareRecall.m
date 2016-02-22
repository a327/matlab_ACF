camera = 'weiminghudong_7_1280x720_30_2';
edgeBoxes = load(['bbsFiles/eval/car/eval-' camera '-edgebox-1000-car.mat' ]);
edgeBoxes = edgeBoxes.bbs;
selectN = 500;
for i=1:length(edgeBoxes),
    edgeBoxes{i} = edgeBoxes{i}(1:min(end,selectN),:);
end
[edgeBoxRecall,edgeBoxPrecision] = evalRecall(['../../../PKU2015/eval/' camera '/posTxt'],edgeBoxes,'car');

% acfBoxes = load(['bbsFiles/eval/car/eval-' camera '-car-nopad.mat' ]);
% acfBoxes = acfBoxes.boxes;
% [acfRecall,acfPrecision] = evalRecall(['../../../PKU2015/eval/' camera '/posTxt'],acfBoxes,'car');