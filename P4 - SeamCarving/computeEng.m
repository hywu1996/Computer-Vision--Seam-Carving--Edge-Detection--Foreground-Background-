
function eng = computeEng(im4,F,W,maskW)
    eng = computeEngGrad(im4(:, :, 1 : 3), F)+computeEngColor(im4(:, :, 1 : 3), W)+maskW*im4(:, :, 4);
end