F = [ -1 -3 -1 ; 0 0 0 ; 1 3 1 ];

A = imread('swan.png');
A = double(A);

outIm = applyFilter(A, F);

s = (sum(abs(outIm(:))));

fprintf('Sum of absolute values in the output image: %.0f\n', s);

outIm = stretch(outIm);

imwrite(uint8(outIm),'swanFiltered.png');

