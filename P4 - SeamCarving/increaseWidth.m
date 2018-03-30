% increases width of the image by n pixels using seam carving

function [seam,im4Out,c] = increaseWidth(im4,E)
    [M,P] = seamV_DP(E);
    [seam,c] = bestSeamV(M,P);
    im4Out =  addSeamV(im4, seam);
end