% Note that this function currently only works for one dimensional seam operations.
% For example, you can insert 100 horizontal seams or 100 vertical seams
% but not at the same time.

% Output has been changed to ignore total cost and only returns output
% image matrix

function [imOut] = intelligentResizeOOR(im,v,h,W,mask,maskWeight)
    
    % alert user to only insert in one dimension
    if (v<0 && h<0)
        fprintf('Function can only insert seams in one dimension\n');
        return
    end
    im4 = cat(3, im, mask);
    im4OOR = cat(3, im, mask);
    F = [-1 0 1];
    
    % keep track of seam to be removed
    E = computeEng(im4, F, W, maskWeight);
    EOOR = computeEng(im4, F, W, maskWeight);
   
    if h>0
        while h>0
            h=h-1;
            
            % get removal seam OOR
            [seam, im4OOR, ~] = reduceHeight(im4OOR,EOOR);
            EOOR = computeEng(im4OOR, F, W, maskWeight);
            [~,im4] = increaseHeightOOR(im4,seam);
            E = computeEng(im4, F, W, maskWeight);
            if v>0
                v=v-1;
                
                [seam, im4OOR, ~] = reduceWidth(im4OOR,EOOR);
                EOOR = computeEng(im4OOR, F, W, maskWeight);
                
                [~,im4] = increaseWidthOOR(im4,seam);
                E = computeEng(im4, F, W, maskWeight);
            elseif v<0
                v=v+1;
                [~,im4,~] = reduceWidth(im4,E);
                E = computeEng(im4, F, W, maskWeight);
            else
                continue;
            end
        end
    else
        while h<0
            h=h+1;
            [~,im4,~] = reduceHeight(im4,E);
            E = computeEng(im4, F, W, maskWeight);
            if v>0
                v=v-1;
                
                [seam, im4OOR, ~] = reduceWidth(im4OOR,EOOR);
                EOOR = computeEng(im4OOR, F, W, maskWeight);
                
                [~,im4] = increaseWidthOOR(im4,seam);
                E = computeEng(im4, F, W, maskWeight);
            elseif v<0
                v=v+1;
                [~,im4,~] = reduceWidth(im4,E);
                E = computeEng(im4, F, W, maskWeight);
            else
                continue;
            end
        end
    end
    
    if v~=0
        if v>0
            while v>0
                v=v-1;
                
                [seam, im4OOR, ~] = reduceWidth(im4OOR,EOOR);
                EOOR = computeEng(im4OOR, F, W, maskWeight);
                
                [~,im4] = increaseWidthOOR(im4,seam);
                E = computeEng(im4, F, W, maskWeight);
            end
        else
            while v<0
                v=v+1;
                [~,im4,~] = reduceWidth(im4,E);
                E = computeEng(im4, F, W, maskWeight);
            end
        end
    end
    imOut = im4(:,:,1:3); 

end