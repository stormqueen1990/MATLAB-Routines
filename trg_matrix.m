function [trg] = trg_matrix(A)
sz = size(A);

if sz(1) == sz(2) && sz(1) ~= 1
    for i = 1:sz(1)
        if A(i, i) == 0 && (i + 1 < size(2))
            cl = A(i,:);
            lin = i + 1;
            while lin < size(2)
                if A(lin, i) ~= 0
                    A(i,:) = A(lin,:);
                    A(lin,i) = cl;
                    break
                end
            end
        elseif A(i, i) > 1
            A(i,:) = A(i,:) * (1/A(i,i));
        elseif i > 1
            A(i,:) = A(i,:) - (A(i - 1,:) * (1/A(i,:)));
        end
    end
end 

trg = A;