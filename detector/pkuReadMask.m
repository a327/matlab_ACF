function mask = pkuReadMask(maskPath)
%PKUREADMASK read the mask image 
%   @param maskPath : the path for the mask
%   @return mask    : the background pixel is 0 and the foreground as 1
maskI = imread(maskPath);
[h,w,c] = size(maskI);

if(c==3)
    maskI = rgb2gray(maskI);
end

mask = uint8(zeros(h,w));
for i=1:h,
    for j=1:w,
        if(maskI(i,j)>0)
            mask(i,j)=1;
        else
            mask(i,j)=0;
        end
    end
end

end

