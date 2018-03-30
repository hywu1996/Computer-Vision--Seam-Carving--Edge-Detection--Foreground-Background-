
function [seam,im4Out,c] = reduceWidth(im4,E)
    [M,P] = seamV_DP(E);
    [seam,c] = bestSeamV(M,P);
    im4Out=removeSeamV(im4,seam);
end