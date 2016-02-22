
% camera = 'weiminghudong_7_1280x720_30_2';
bbs = load('bbsFiles/train_merge_new/train_merge_new-pos-edgebox-500-car.mat');
carBB = bbs.bbs;
selectN = 500;
for i=1:length(carBB),
    carBB{i} = carBB{i}(1:min(end,selectN),:);
end

bbs = load('bbsFiles/train_merge_new/pku-train_merge_new-person.mat');
personBB = bbs.boxes;
n = length(personBB);
boxes = cell(1,n);

imgDir = '../../../train_merge_new/pos';
imgNames = bbGt('listFilesPku',imgDir,'jpg');
for i=1:n
    img = imread(imgNames{i});
    [height,width,~] = size(img);
    persons = max(floor(personBB{i}(:,1:4)),1);
    cars = max(floor(carBB{i}(:,1:4)),1);
    bbOne = [cars(:,:);persons(:,:)];
    
%     bbOne = persons;
    bbOne(:,3) = min(width,bbOne(:,1)+bbOne(:,3));
    bbOne(:,4) = min(height,bbOne(:,2)+bbOne(:,4));
    boxes{i} = bbOne;
end

save('bbsFiles/train_merge_new/train_merge_new-acf-edge500.mat','boxes');