clear
dx=0.05;
Lx=1;
x=0:dx:Lx;
dy=0.05;
Ly=1;
y=0:dy:Ly;
A=(-2*eye(length(x))+diag(ones(1,length(x)-1),1)+diag(ones(1,length(x)-1),-1));
A2=(-2*eye(length(y))+diag(ones(1,length(y)-1),1)+diag(ones(1,length(y)-1),-1));
dt=0.0001;
t=0:dt:1;
[Y,X]=meshgrid(y,x);
U0=exp(-10*((X-1/2).^2+(Y-1/2).^2));
U=U0;
a=1;
for n=1:length(t)-1
    U=U+a^2*(1/dx^2*A*U+1/dy^2*U*A2)*dt;
    surf(X,Y,U)
    axis([x(1) x(end) y(1) y(end) -0.1 1])
end

