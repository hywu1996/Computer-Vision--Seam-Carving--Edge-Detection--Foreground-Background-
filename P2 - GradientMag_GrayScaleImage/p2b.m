% Apply function, computeEngGrad to image ’face.jpg’

F = [ 1 2 0 -2 -1 ];

im = imread('face.jpg');
im = double(im);

outIm = computeEngGrad(im, F);

s = (sum(outIm(:)));

fprintf('Sum of absolute values in the eng image: %.0f\n', s);

outIm = stretch(outIm);

imwrite(uint8(outIm),'faceEngG.jpg');

