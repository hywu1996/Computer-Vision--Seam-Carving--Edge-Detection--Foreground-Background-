% Apply function, computeEngGrad to image ’cat.png’

W = [-3 1 -3];

im = imread('cat.png');
im = double(im);

outIm = computeEngColor(im, W);

s = (sum(outIm(:)));

fprintf('Sum of absolute values in the eng image: %.0f\n', s);

outIm = stretch(outIm);

imwrite(uint8(outIm),'catEngC.png');

