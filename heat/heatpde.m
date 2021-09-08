x = linspace(0,1,20);
t = linspace(0,2,5);
%選擇網格
m = 0;
sol = pdepe(m,@pdex1pde,@pdex1ic,@pdex1bc,x,t);
%求解
u = sol(:,:,1);
%提取第1個解分量
% surf(x,t,u)
% title('Numerical solution computed with 20 mesh points')
% xlabel('Distance x')
% ylabel('Time t')
%繪圖(數值解)
% surf(x,t,exp(-t)'*sin(pi*x))
% title('True solution plotted with 20 mesh points')
% xlabel('Distance x')
% ylabel('Time t')
%繪圖(解析解)
plot(x,u(end,:),'o',x,exp(-t(end))*sin(pi*x))
title('Solution at t = 2')
legend('Numerical, 20 mesh points','Analytical','Location','South')
xlabel('Distance x')
ylabel('u(x,2)')
% 比較t=2的數值解和解析解