function img = pkuImRead(filename,mask)

if(nargin<=1), 
    noMask=1;
else
    noMask=0;
end
    
originIm = imread(filename);

if(noMask),
    img = originIm;
    return;
end

[h,w,c] = size(originIm);
[mh,mw] = size(mask);
img = uint8(zeros(h,w,c));

assert((h==mh)&(w==mw),'the mask is not same height or width with the image');

if(c==1)
    img = mask.*originIm;
elseif(c==3)
    for i=1:3,
        img(:,:,i) = originIm(:,:,i).*mask;
    end
else
    fprintf('Channel for image %s is wrong\n',filename);
end

end