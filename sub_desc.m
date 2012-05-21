function v=sub_desc(A,b)
    v=zeros(size(b));
    [m,n]=size(A);
    
    for i=1:n
    v(i)=(b(i)-A(i,:)*v)/A(i,i);
    end
end
