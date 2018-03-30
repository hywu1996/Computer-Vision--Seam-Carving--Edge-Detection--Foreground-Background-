function outIm= applyFilter(im,F)
    [imM, imN] = size(im);
    [Frows,Fcols] = size(F);
    padLR = (Fcols-1)/2;
    padTB = (Frows-1)/2;
    padim = padarray(im, [padTB padLR], 0);
    outIm = zeros(imM,imN);
    
    for m = padTB+1:imM+padTB
        for n = padLR+1:imN+padLR
            sum = 0;
            Fm = 1;
            Fn = 1;
            for i = m-padTB:m+padTB
                for j = n-padLR:n+padLR;
                    sum = sum + F(Fm,Fn)*padim(i,j);
                    Fn = Fn + 1;
                end
                Fm = Fm + 1;
                Fn = 1;
            end
            
            outIm(m-padTB,n-padLR) = sum;
            
        end        
    end

end