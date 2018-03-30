%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% INPUT: 
%        im: input image  in double format 
%        scribbleMask: 
%               scribbleMask(i,j) = 2 means pixel(i,j) is a foreground seed
%               scribbleMask(i,j) = 1 means pixel(i,j) is a background seed
%               scribbleMask(i,j) = 0 means pixel(i,j) is not a seed
%        lambda: parameter for graph cuts
%        numClusters: parameter for kmeans
%        inftCost: parameter for infinity cost constraints
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% OUTPUT:   segm is the segmentation mask of the  same size as input image im
%           segm(i,j) = 1 means pixel (i,j) is the foreground
%           segm(i,j) = 0 means pixel (i,j) is the background
%
%           eng_finish: the energy of the computed segmentation
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [segm,eng_finish]  = segmentGC(im,scribbleMask,lambda,numClusters,inftyCost)

    [row,col,~] = size(im);
    FGind = find(scribbleMask==2);
    BGind = find(scribbleMask==1);
    FG = zeros(row*col,1);
    BG = zeros(row*col,1);
    
    % numClusters set to value larger than 0?
    if numClusters ~= 0
        % colour channels
        R = im(:,:,1);
        G = im(:,:,2);
        B = im(:,:,3);
        
        colourClusters = kmeans([R(:) G(:) B(:)] , numClusters);
        totalcluster = reshape(colourClusters, row, col);
        FGhist = hist(transpose(totalcluster(FGind)), 1:numClusters) + 1;
        BGhist = hist(transpose(totalcluster(BGind)), 1:numClusters) + 1;
        FG_datacost = -log(FGhist/sum(FGhist));
        BG_datacost = -log(BGhist/sum(BGhist));
        
        for i=1:row*col
            BG(i) = BG_datacost(totalcluster(i));
            FG(i) = FG_datacost(totalcluster(i));
        end
    end
    
    FG(BGind) = inftyCost;
    BG(FGind) = inftyCost;
   
    numEdges = 2*((row-1)*col + (col-1)*row);
    avgIm = mean(im,3);
    sigma2 = 0;
    
    for i = 1:row
        for j = 1:col
            if i==1
                sigma2 = sigma2 + (im(i,j) - im(i+1,j))^2;
                if j==1
                    sigma2 = sigma2 + (im(i,j) - im(i,j+1))^2;
                elseif j==col
                    sigma2 = sigma2 + (im(i,j) - im(i,j-1))^2;
                else
                    sigma2 = sigma2 + (im(i,j) - im(i,j+1))^2;
                    sigma2 = sigma2 + (im(i,j) - im(i,j-1))^2;
                end
            elseif i==row
                sigma2 = sigma2 + (im(i,j) - im(i-1,j))^2;    
                if j==1
                    sigma2 = sigma2 + (im(i,j) - im(i,j+1))^2;
                elseif j==col
                    sigma2 = sigma2 + (im(i,j) - im(i,j-1))^2;
                else
                    sigma2 = sigma2 + (im(i,j) - im(i,j+1))^2;
                    sigma2 = sigma2 + (im(i,j) - im(i,j-1))^2;
                end
            else
                sigma2 = sigma2 + (im(i,j) - im(i-1,j))^2;    
                sigma2 = sigma2 + (im(i,j) - im(i+1,j))^2;
                if j==1
                    sigma2 = sigma2 + (im(i,j) - im(i,j+1))^2;
                elseif j==col
                    sigma2 = sigma2 + (im(i,j) - im(i,j-1))^2;
                else
                    sigma2 = sigma2 + (im(i,j) - im(i,j+1))^2;
                    sigma2 = sigma2 + (im(i,j) - im(i,j-1))^2;
                end
            end   % endif   
        end    % col
    end      % row
    
    sigma2 = sigma2/numEdges;
    W = zeros(numEdges, 3);
    Wi = 1;
    for i = 1:row
        for j = 1:col
            fp = avgIm(i,j);
            
            if i==1
                fq = avgIm(i+1,j);
                Wpq = lambda*exp(-((fp - fq)^2)/(sigma2*2));
                W(Wi,:) = [sub2ind(size(avgIm),i,j) sub2ind(size(avgIm),i+1,j) Wpq];
                Wi = Wi+1;
                if j==1
                    fq = avgIm(i,j+1);
                    Wpq = lambda*exp(-((fp - fq)^2)/(sigma2*2));
                    W(Wi,:) = [sub2ind(size(avgIm),i,j) sub2ind(size(avgIm),i,j+1) Wpq];
                    Wi = Wi+1;
                elseif j==col
                    fq = avgIm(i,j-1);
                    Wpq = lambda*exp(-((fp - fq)^2)/(sigma2*2));
                    W(Wi,:) = [sub2ind(size(avgIm),i,j) sub2ind(size(avgIm),i,j-1) Wpq];
                    Wi = Wi+1;
                else
                    fq = avgIm(i,j+1);
                    Wpq = lambda*exp(-((fp - fq)^2)/(sigma2*2));
                    W(Wi,:) = [sub2ind(size(avgIm),i,j) sub2ind(size(avgIm),i,j+1) Wpq];
                    Wi = Wi+1;
                    
                    fq = avgIm(i,j-1);
                    Wpq = lambda*exp(-((fp - fq)^2)/(sigma2*2));
                    W(Wi,:) = [sub2ind(size(avgIm),i,j) sub2ind(size(avgIm),i,j-1) Wpq];
                    Wi = Wi+1;
                end
            elseif i==row
                fq = avgIm(i-1,j);
                Wpq = lambda*exp(-((fp - fq)^2)/(sigma2*2));
                W(Wi,:) = [sub2ind(size(avgIm),i,j) sub2ind(size(avgIm),i-1,j) Wpq];
                Wi = Wi+1;
                if j==1
                    fq = avgIm(i,j+1);
                    Wpq = lambda*exp(-((fp - fq)^2)/(sigma2*2));
                    W(Wi,:) = [sub2ind(size(avgIm),i,j) sub2ind(size(avgIm),i,j+1) Wpq];
                    Wi = Wi+1;
                elseif j==col
                    fq = avgIm(i,j-1);
                    Wpq = lambda*exp(-((fp - fq)^2)/(sigma2*2));
                    W(Wi,:) = [sub2ind(size(avgIm),i,j) sub2ind(size(avgIm),i,j-1) Wpq];
                    Wi = Wi+1;
                else
                    fq = avgIm(i,j+1);
                    Wpq = lambda*exp(-((fp - fq)^2)/(sigma2*2));
                    W(Wi,:) = [sub2ind(size(avgIm),i,j) sub2ind(size(avgIm),i,j+1) Wpq];
                    Wi = Wi+1;
                    
                    fq = avgIm(i,j-1);
                    Wpq = lambda*exp(-((fp - fq)^2)/(sigma2*2));
                    W(Wi,:) = [sub2ind(size(avgIm),i,j) sub2ind(size(avgIm),i,j-1) Wpq];
                    Wi = Wi+1;
                end
            else
                fq = avgIm(i+1,j);
                Wpq = lambda*exp(-((fp - fq)^2)/(sigma2*2));
                W(Wi,:) = [sub2ind(size(avgIm),i,j) sub2ind(size(avgIm),i+1,j) Wpq];
                Wi = Wi+1;
                
                fq = avgIm(i-1,j);
                Wpq = lambda*exp(-((fp - fq)^2)/(sigma2*2));
                W(Wi,:) = [sub2ind(size(avgIm),i,j) sub2ind(size(avgIm),i-1,j) Wpq];
                Wi = Wi+1;
                
                if j==1
                    fq = avgIm(i,j+1);
                    Wpq = lambda*exp(-((fp - fq)^2)/(sigma2*2));
                    W(Wi,:) = [sub2ind(size(avgIm),i,j) sub2ind(size(avgIm),i,j+1) Wpq];
                    Wi = Wi+1;
                elseif j==col
                    fq = avgIm(i,j-1);
                    Wpq = lambda*exp(-((fp - fq)^2)/(sigma2*2));
                    W(Wi,:) = [sub2ind(size(avgIm),i,j) sub2ind(size(avgIm),i,j-1) Wpq];
                    Wi = Wi+1;
                else
                    fq = avgIm(i,j+1);
                    Wpq = lambda*exp(-((fp - fq)^2)/(sigma2*2));
                    W(Wi,:) = [sub2ind(size(avgIm),i,j) sub2ind(size(avgIm),i,j+1) Wpq];
                    Wi = Wi+1;
                    
                    fq = avgIm(i,j-1);
                    Wpq = lambda*exp(-((fp - fq)^2)/(sigma2*2));
                    W(Wi,:) = [sub2ind(size(avgIm),i,j) sub2ind(size(avgIm),i,j-1) Wpq];
                    Wi = Wi+1;
                end
            end
            
        end
    end
    
    [labels,~,eng_finish] = solveMinCut(transpose(BG),transpose(FG),W);
    segm = reshape(labels,row,col);

end