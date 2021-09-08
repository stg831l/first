clear
a=1;
dx=0.01;
x=0:dx:1;
dt=0.00005;
t=0:dt:1;
u=zeros(length(x),length(t));
u(:,1)=0; %隨意設置的初始條件
f=5*exp(-20*(x-1/2).^2); %熱源

m1=0+0.0*sin(t);
m2=0-0.0*sin(t); 
%隨意設置的邊界條件
A=-2*eye(length(x))+diag(ones(1,length(x)-1),1)+diag(ones(1,length(x)-1),-1);
%設定A矩陣
for n=1:length(t)-1
    u(:,n+1)=u(:,n)+(a^2/dx^2*A*u(:,n)+f')*dt;
    u(1,n+1)=m1(n+1);
    u(end,n+1)=m2(n+1);
    plot(x,u(:,n+1))
    axis([x(1) x(end) 0 1])
    getframe; 
end
% [T,X]=meshgrid(t,x);
% surf(X,T,u);
% shading interp %給圖上色
% hold on
