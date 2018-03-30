
function [M,P] = seamV_DP(E)
    M = zeros(size(E));
    P = zeros(size(E));
    
    maxCol = size(E,2);
    maxRow = size(E,1);
    
    for c = 1:maxCol
        M(1,c) = E(1,c);
        P(1,c) = -1;
    end

    for r = 1:maxRow
        for c = 1:maxCol
            option1=Inf;
            option2=Inf;
            option3=Inf;
            if r>1&&c>1
                option1 = M(r-1,c-1);
            end
            if r>1
                option2 = M(r-1,c);
            end
            if r>1&&c<maxCol
                option3 = M(r-1,c+1);
            end
            if option1<=option2 && option1<=option3
                if r>1&&c>1
                    M(r,c)= E(r,c) + M(r-1,c-1);
                    P(r,c)=c-1;
                end
            elseif option2<=option1 && option2<=option3
                if r>1
                    M(r,c)= E(r,c) + M(r-1,c);
                    P(r,c)= c;
                end
            else
                if r>1&&c<maxCol
                    M(r,c)= E(r,c) + M(r-1,c+1);
                    P(r,c)= c+1;
                end
            end
        end
    end
end