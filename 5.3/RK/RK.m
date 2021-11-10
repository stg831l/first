%dy/dt=y
%f(y,t)=y
%Y1=yn
%Y2=yn+(1/2)*k*yn
%Y3=yn+(1/2)*(yn+(1/2)*yn*k)*k
%Y4=yn+((1/2)*(yn+(1/2)*yn*k)*k)*k
%yn+(k/6)*(Y1+2*Y2+2*Y3+Y4)
T=2;
m=10;
h=T/m;
t=0:h:T;
% f(y,t) = y;
% dy/dt = y;
% yture(t) = exp(t);
y0=1; %初始條件
y=zeros(1,length(t));
y(1)=y0;
for n=1:length(t)-1
    y(n+1) = y(n)+y(n)*h+1/2*y(n)*h^2+1/6*y(n)*h^3+1/24*y(n)*h^4;
end

plot(t,y,t,exp(t))

ana=exp(t);
error=abs(y-ana);
l_2norm = sqrt((1/m)*sum(error.*error));