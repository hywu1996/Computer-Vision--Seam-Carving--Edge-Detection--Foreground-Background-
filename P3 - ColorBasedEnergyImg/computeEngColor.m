function eng = computeEngColor(im,W)
    R = im(:,:,1);
    G = im(:,:,2);
    B = im(:,:,3);
 
    eng = W(1).*R + W(2).*G + W(3).*B;
end