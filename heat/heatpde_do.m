clear
a=1;
dx=0.05;
x=0:dx:1;
dt=0.0005;
t=0:dt:1;
u=zeros(length(x),length(t));
u(:,1)=sin(pi*x); 
%隨意設置的初始條件
m1=0+0*t;
m2=0+0*t; 
%隨意設置的邊界條件
A=-2*eye(length(x))+diag(ones(1,length(x)-1),1)+diag(ones(1,length(x)-1),-1);
%設定A矩陣
for n=1:length(t)-1
    u(:,n+1)=u(:,n)+a^2*dt/dx^2*A*u(:,n);
    u(1,n+1)=m1(n+1);
    u(end,n+1)=m2(n+1);
end
plot(x,u(:,end),'o',x,exp(-pi^2*t(end))*sin(pi*x))
title('Solution at t = 1')
xlabel('Distance x')
ylabel('u(x,1)')
ana=exp(-pi^2*t(end))*sin(pi*x);
error=abs(u(:,end)'-ana);
l_2norm = sqrt((1/20)*sum(error.*error));