function annoShow( imagePath,boxes )
%YMLSHOW to show the yml bounding box in imgPath
%   @param imagePath : the path for the whole image
%   @param boxes : a n x 5 or n x 6 matix with each row as boundingbox
%                   [type left top right bottom confidence],the confidence
%                   value is optional

if(ischar(imagePath) && ~exist(imagePath,'file'))
    fprintf('%s or is not a file\n',imagePath);
    return;
end

imshow(imagePath);
hold on;

% classes = {'person' 'car'};
% boxes = loadYmlAnnotation(ymlPath,classes);
n = size(boxes,1);
for i = 1:n
    l = boxes(i,1);
    t = boxes(i,2);
    width = boxes(i,3);
    height = boxes(i,4);
    rectangle('position',[l t width height],'EdgeColor','r', 'LineWidth', 3);

end
hold off;

end

