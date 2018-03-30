% increases height of the image
% Instead of taking in energy matrix, directly adds a seam.

function [seam,im4Out] = increaseHeightOOR(im4,OORseam) 
    [s1,s2,s3] = size(im4);
    for i=1:4
        tmp(:,:,i) = transpose(im4(:,:,i));
    end
    
    [seam,tmp] = increaseWidthOOR(tmp,OORseam);
    im4Out = zeros(s1+1,s2,s3);
    for i=1:4
        im4Out(:,:,i) = transpose(tmp(:,:,i));
    end
end