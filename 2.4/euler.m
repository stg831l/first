clear
T=2;
N=160;
dt=T/N;
t=0:dt:T;

y0=1; %初始條件
y=zeros(1,length(t));
y(1)=y0;
for n=1:length(t)-1
    y(n+1)=y(n)+y(n)*dt;
    
end

plot(t,y,t,exp(t))