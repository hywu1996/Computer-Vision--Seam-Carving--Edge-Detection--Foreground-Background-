% increases width of the image by n pixels using seam carving.
% Instead of taking in energy matrix, directly adds a seam.

function [seam,im4Out] = increaseWidthOOR(im4,OORseam)
    seam = OORseam;
    im4Out =  addSeamV(im4, seam);
end