function imOut = addSeamV(im4,seam)
    leng = size(im4,1);
    imOut = zeros(leng,size(im4,2)+1,3);
    for i=1:leng
        for channel=1:4
            vec = im4(i,:,channel);
            vec = [vec(1:seam(i)-1) vec(seam(i)) vec(seam(i):end)];
            imOut(i,:,channel) = vec;
        end
    end
end