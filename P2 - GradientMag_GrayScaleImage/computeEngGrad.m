function eng = computeEngGrad(im,F)
    [imR,imC,imZ] = size(im);
    imG = zeros(imR, imC);
    
    for i=1:imR
        for j=1:imC
            s = 0;
            for k=1:3
                s = s + im(i,j,k);
            end
            avg = s/3;
            imG(i,j) = avg;
        end
    end
    
    eng = sqrt(abs(applyFilter(imG,F)).^2+abs(applyFilter(imG,transpose(F))).^2);
    
end