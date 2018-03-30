load q5.mat

im = imread('face.jpg');
im = double(im);


[segm,eng_finish] = segmentGC(im,scribblesFace,50,50,1000);

fprintf('Final Energy (face.jpg): %.0f\n', eng_finish);

imwrite(uint8(255*segm),'faceL.png');

im = imread('lift.jpg');
im = double(im);


[segm,eng_finish] = segmentGC(im,scribblesLift,50,50,1000);

fprintf('Final Energy (lift.jpg): %.0f\n', eng_finish);

imwrite(uint8(255*segm),'liftL.png');