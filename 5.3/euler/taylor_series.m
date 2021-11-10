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
    y(n+1)=y(n)+y(n)*h+y(n)*(h^2/2);
    
end

plot(t,y,t,exp(t))

ana=exp(t);
error=abs(y-ana);
l_2norm = sqrt((1/m)*sum(error.*error));