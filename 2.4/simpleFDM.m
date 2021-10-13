m = 80;
h = 1/m;
x = 0:h:1;
% f(x)=exp(x);
% uture(x)=exp(x) + (-5-exp(0))*(x - 1) + 1 - exp(1);
a=8-exp(1);
b=1;

u=zeros(length(x),1); 

A=(-2*eye(length(x)-2)+diag(ones(1,length(x)-3),1)+diag(ones(1,length(x)-3),-1))/h^2;
%設定A矩陣

F=exp(x);
F(2)=exp(1/m)-a/(h^2);
F(end-1)=exp(1-1/m)-b/(h^2);
F2=F';
F2(1,:)=[];
F2(end,:)=[];
U = A\F2;
U2 = [a;U;b];


plot(x,U2,'.',x,exp(x) + (-5-exp(0))*(x - 1) + 1 - exp(1))
title('Solution with 81 grid points')
xlabel('Distance x')
ylabel('u(x)')

ana=exp(x) + (-5-exp(0))*(x - 1) + 1 - exp(1);
error=abs(U2'-ana);
l_2norm = sqrt((1/m)*sum(error.*error));

hval = [1/10, 1/20, 1/40, 1/80];
E = [1.29E-04, 3.22E-05, 8.04E-06, 2.01E-06];
h = hval';
E2 = E';
ntest = length(h);
loglog(h,E2,'o-')
axis([.5*min(h) 1.5*max(h)  .5*min(E) 1.5*max(E)])
title('log-log plot of errors vs. h')

Ap = ones(ntest,2);
Ap(:,2) = log(h);
bp = log(E2);
Kp = Ap\bp; % K + p*log(h) = log(E2), E2 = exp(K)*h.^p
K = Kp(1);
p = Kp(2);
disp(sprintf('Least squares fit gives E(h) = %g * h^%g',exp(K),p))

% add graph of this line to loglog plot:
hold on
err1 = exp(K)*h.^p;
loglog(h,err1,'r')
legend('errors', 'least squares fit','Location','SouthEast')
hold off
