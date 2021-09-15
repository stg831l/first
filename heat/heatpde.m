clear
x = linspace(0,1,21);
t = linspace(0,2,5);
%選擇網格
m = 0;
sol = pdepe(m,@pdex1pde,@pdex1ic,@pdex1bc,x,t);
%求解
u = sol(:,:,1);
%提取第1個解分量
ana=exp(-t(end))*sin(pi*x);
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
xlabel('Distance x')
ylabel('u(x,2)')
error=abs(u(end,:)-ana);
log_error=log(error(end:end));
logh=log(1/20);
p=log_error/logh;
%計算誤差精準度
% 比較t=2的數值解和解析解