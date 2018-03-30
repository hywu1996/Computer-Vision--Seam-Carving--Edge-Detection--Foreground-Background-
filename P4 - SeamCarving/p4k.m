%% Apply function, intelligentResize to image ’cat.png’ and 'face.jpg'

% v = -20; 
% h = -20; 
% W = [ 1, -2, 1];
% 
% im = imread('cat.png');
% im = double(im);
% 
% mask = zeros(size(im,1),size(im,2));
% maskW = 0;
% 
% [totalCost,imOut ] = intelligentResize(im,v,h,W,mask,maskW);
% 
% 
% fprintf('Total Cost of All Seams (cat.png): %.0f\n',totalCost);
% 
% imwrite(uint8(imOut),'catResized.png');
% 
% 
% imf = imread('face.jpg');
% imf = double(imf);
% fmask = imread('faceMask.png');
% fmask = double(fmask);
% maskWeight = -100;
% [totalCost,imOut ] = intelligentResize(imf,v,h,W,fmask,maskWeight);
% 
% fprintf('Total Cost of All Seams (face.jpg): %.0f\n',totalCost);
% 
% imwrite(uint8(imOut),'faceResized.png');

%% Apply function to pigs.jpg

v = 50; 
h = 50; 
W = [ 2, -3, 2];

im = imread('pigs.png');
im = double(im);

size(im)

mask = zeros(size(im,1),size(im,2));
maskW = 0;

[~,imOut ] = intelligentResize(im,v,h,W,mask,maskW);

size(imOut)

imwrite(uint8(imOut),'pigsResized.png');
