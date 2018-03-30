

function [seam,im4Out,c] = reduceHeight(im4,E)
    [s1,s2,s3] = size(E);
    E = transpose(E);
    tmp = zeros(s2,s1,s3);
    for i=1:4
        tmp(:,:,i) = transpose(im4(:,:,i));
    end
    
    [seam,tmp,c] = reduceWidth(tmp,E);
    im4Out = zeros(s1-1,s2,s3);
    for i=1:4
        im4Out(:,:,i) = transpose(tmp(:,:,i));
    end
end