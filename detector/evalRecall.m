function [recall,precision] = evalRecall( gtDir,boxes,classType)
%EVALRECALL evaluate the recall for detector
%   @param gtDir : the directory stores the ground truth notations
%   @param boxes : the detection result a 1 x n cell
%   @param classType : the evaluate class 'person' or 'car'
%   @return recall : the recall value
%   @return precision : the precision for the detect boxes

gtFs = bbGt('listFilesPku',gtDir,'txt');
n = length(gtFs);
gt0 = cell(1,n);
for i=1:n, [~,gt0{i}]=bbGt('bbLoad',gtFs{i},{'lbls',classType}); end

%load detection result ,this is a cell array with each element store nx4
%detection bounding box
dt0 = boxes;
dtN = length(dt0);
assert(dtN==n,'the ground truth is not same with the detection');
[gt,dt] = bbGt('evalRes',gt0, dt0, .6, 0 );
gtAll = cat(1,gt{:});
gtDetected = sum(gtAll(:,5)==1);
recall = gtDetected/size(gtAll,1);

dtAll = cat(1,dt{:});
dtTr = sum(dtAll(:,6)==1);
winNum = size(dtAll,1);
precision = dtTr/winNum;

end

