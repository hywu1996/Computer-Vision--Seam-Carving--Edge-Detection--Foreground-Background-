function [totalCost,imOut] = intelligentResize(im,v,h,W,mask,maskWeight)
    im4 = cat(3, im, mask);
    F = [-1 0 1];
    totalCost = 0;
    E = computeEng(im4, F, W, maskWeight);
    
    if h>0
        while h>0
            h=h-1;
            [~,im4,cost] = increaseHeight(im4,E);
            totalCost = totalCost + cost;
            E = computeEng(im4, F, W, maskWeight);
            if v>0
                v=v-1;
                [~,im4,cost] = increaseWidth(im4,E);
                totalCost = totalCost + cost;
                E = computeEng(im4, F, W, maskWeight);
            elseif v<0
                v=v+1;
                [~,im4,cost] = reduceWidth(im4,E);
                totalCost = totalCost + cost;
                E = computeEng(im4, F, W, maskWeight);
            else
                continue;
            end
        end
    else
        while h<0
            h=h+1;
            [~,im4,cost] = reduceHeight(im4,E);
            totalCost = totalCost + cost;
            E = computeEng(im4, F, W, maskWeight);
            if v>0
                v=v-1;
                [~,im4,cost] = increaseWidth(im4,E);
                totalCost = totalCost + cost;
                E = computeEng(im4, F, W, maskWeight);
            elseif v<0
                v=v+1;
                [~,im4,cost] = reduceWidth(im4,E);
                totalCost = totalCost + cost;
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
                [~,im4,cost] = increaseWidth(im4,E);
                totalCost = totalCost + cost;
                E = computeEng(im4, F, W, maskWeight);
            end
        else
            while v<0
                v=v+1;
                [~,im4,cost] = reduceWidth(im4,E);
                totalCost = totalCost + cost;
                E = computeEng(im4, F, W, maskWeight);
            end
        end
    end
    imOut = im4(:,:,1:3); 
end