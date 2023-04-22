clc
clear all %#ok<CLALL> 
close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% DashBoard %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a=1;
b=1;
nx=100;
ny=50;
dx=a/nx;
dy=b/ny;
x=0:dx:a;
y=0:dy:b;

%%%%%%%%%%%%% Analytical Solution %%%%%%%%%%%%

U=zeros(ny+1,nx+1);

for i=1:ny+1
    for j=1:nx+1
        U(i,j)= sin(x(j))./sin(a).*sinh(y(i))./sinh(b);
    end
end

%%%%%%%%%%%%%%%% Normalize %%%%%%%%%%%%%%%%%%%%%
Umax   = max(U,[],'all');
UnormA  = U./Umax;

%%%%%%%%%%%%% Numerical Solution %%%%%%%%%%%%%%%


U=zeros(ny+1,nx+1);
pr=1/(2*(dx^2+dy^2));

%%%%%%%%%%%%%Boundary conditions%%%%%%%%%%%%%%%%%%

U(1,:)=0;
U(ny+1,:)=sin(x)/sin(a);
U(:,1)=0;
U(:,nx+1)=sinh(y)/sinh(b);
iter=1000;
for k=1:iter
 for i=2:ny
    for j=2:nx
        U(i,j)=pr*(dx^2*(U(i+1,j)+U(i-1,j))+dy^2*(U (i,j+1)+U(i,j-1)));
    end
 end

end
Umax   = max(U,[],'all');
UnormN  = U/Umax;
Error = UnormA-UnormN;
subplot(2,2,1);
contourf(UnormA,200,'LineColor','non')
title('Analytical Solution')
xlabel('x')
ylabel('y')
colormap(jet(256))
colorbar
subplot(2,2,2);
contourf(UnormN,200,'LineColor','non')
title('Numerical Solution')
xlabel('x')
ylabel('y')
colormap(jet(256))
colorbar

subplot(2,2,[3,4]);
contourf(Error,200,'LineColor','non')
title('Error')
xlabel('x')
ylabel('y')
colormap(jet(256))
colorbar
writematrix(UnormN,'2_Dlapalcedata.xls')













