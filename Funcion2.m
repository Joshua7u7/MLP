function [S] = Funcion2(v2,W,s,a,t)

[x,y] = size(W);
F = zeros(x);

if v2==1
    for i=1:x
        for j=1:x
            if i==j
                F(i,j) = 1;
            end
        end
    end
    S=-2*F*(t-a);
end

if v2==2
    for i=1:x
        for j=1:x
            if i==1 && j==1
                F(i,j) = a(1)*(1-a(1));
            end
            if i==2 && j==2
                F(i,j) =a(2)*(1-a(2));
            end
            if i==3 && j==3
                F(i,j) = a(3)*(1-a(3));
            end
            if i==4 && j==4
                F(i,j) = a(4)*(1-a(4));
            end
        end
    end
    S = F*W'*s;
end
if v2==3
    for i=1:x
        for j=1:x
            if i==1 && j==1
                F(i,j) = 1-a(1)^2;
            end
            if i==2 && j==2
                F(i,j) = 1-a(2)^2;
            end
            if i==3 && j==3
                F(i,j) = 1-a(3)^2;
            end
            if i==4 && j==4
                F(i,j) = 1-a(4)^2;
            end
        end
    end
    S=F*W'*s;
end


end

