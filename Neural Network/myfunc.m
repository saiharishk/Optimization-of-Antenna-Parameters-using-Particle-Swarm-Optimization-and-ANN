function [f] = myfunc(x,n,m,o,net,inputs,targets)  
k=0;
for i=1:n
     for j=1:m
        k=k+1;
        xi(i,j)=x(k);
     end
end
 m=k;
for i=1:n
    for j=1:n
        for v=1:n
            k=k+1;
            xl1(i,j)=x(k);
        end
    end 
    m=m+1;
    xb1(i,1)=x(m+15);%n replaces with 15 
end
for i=1:n
    for j=1:n
        for v=1:n
            k=k+1;
            xl2(i,j)=x(k);
        end
    end 
end
for v=1:n
     k=k+1;
     xb2(i,1)=x(k+15);
end
for v=1:n
     k=k+1;
     xb3(i,1)=x(k+15);
end
for i=1:o
     k=k+1;
     xb4(i,1)=x(k);
end
net.Iw{1,1}=xi;
net.Lw{2,1}=xl1;
net.Lw{3,2}=xl2;
net.b{1,1}=xb1;
net.b{2,1}=xb2;
net.b{3,1}=xb3;
net.b{4,1}=xb4;%new bias vector is added
f=sum((net(inputs)-targets).^2)/length(inputs); 