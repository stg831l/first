x=1:0.00001:5;
y=x.^2.4+sin(x).*exp(x)+8./(1+x);
plot(x,abs(y))