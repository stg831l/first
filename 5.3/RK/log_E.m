hval = [2/10, 2/20, 2/40, 2/80, 2/160];
E = [1.67E-04, 1.13E-05, 7.38E-07, 4.71E-08, 2.98E-09];
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