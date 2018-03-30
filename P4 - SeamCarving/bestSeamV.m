function [seam,c] = bestSeamV(M,P)
    leng = size(M,1);
    seam = zeros(leng,1);
    index = -1;
    for i=leng:-1:1
        if i==leng
            elem = find(M(i,:)==min(M(i,:)));
            index = elem(1);
            seam(i) = index;
            c = min(M(i,:));
        else
            seam(i) = P(i+1,index);
            index = seam(i);
        end
    end
end
% 
% function [seam,c] = bestSeamV(M,P)
%     M_lastrow = M(size(M,1),:);
%     c = min(M_lastrow);
%     c_index = find(M_lastrow == min(M_lastrow));
%     c_index = min(c_index);
%     
%     seam = zeros (size(M,1),1);
%     seam(size(M,1)) = c_index;
%     for i = size(P,1):-1:2
%         seam(i-1) = P(i,seam(i));
%     end
% end