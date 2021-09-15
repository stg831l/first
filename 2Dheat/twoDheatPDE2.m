clear all
a=0.5;
u_xy0=inline('0','x','y');
u_xyt=inline('x^2*cos(pi*y)-y^2*cos(pi*x)','x','y','t');
f=inline('0','x','y','t');
D=[0,2*pi,0,2*pi];
T=500;
Mx=100;
My=100;
N=100;
ox=(D(2)-D(1))/Mx;
x=D(1)+[0:Mx]*ox;
oy=(D(4)-D(3))/My;
y=D(3)+[0:My]*oy;
ot=T/N;
t=[0:N]*ot;
%初始化 u
for j=1:Mx+1;
    for i=1:My+1;
        u(i,j)=u_xy0(x(j),y(i));
    end
end
rx=a*ot/(ox*ox);
ry=a*ot/(oy*oy);
rx1=1+2*rx;
rx2=1-2*rx;
ry1=1+2*ry;
ry2=1-2*ry;
for j=1:Mx-1;
    A(j,j)=ry1;
    if j>1
        A(j-1,j)=-ry;
        A(j,j-1)=-ry;
    end
end
%A为y方向隐式时的系数矩阵
for i=1:My-1;
    B(i,i)=rx1;
    if i>1;
        B(i-1,i)=-rx;
        B(i,i-1)=-rx;
    end
end
%B为x方向隐式时的系数矩阵
for k=1:N
    t=k*ot;u_1=u;
    %for m=1:Mx+1;

        %for n=1:My+1;
            %v(n,m)=feval(f,x(m),y(n),t);
        %end
    %end
    u_1=u;
    for i=1:My+1
        u(i,1)=feval(u_xyt,x(1),y(i),t);
        u(i,Mx+1)=feval(u_xyt,x(Mx+1),y(i),t);
    end
    for j=1:My+1;
        u(1,j)=feval(u_xyt,x(j),y(1),t);
        u(My+1,j)=feval(u_xyt,x(j),y(My+1),t);
    end
    if mod(k,2)==0;
        for i=2:My;
            jj=2:Mx;
            bx=[ry*u(i,1),zeros(1,Mx-3),ry*u(i,My+1)]+rx*(u_1(i-1,jj)+u_1(i+1,jj))+rx2*u_1(i,jj)+ot*u_1(i,jj);
            opts.UT = true; opts.TRANSA = true;
            u(i,jj)=linsolve(A,bx',opts)';
        end
    else
        for j=2:Mx
            ii=2:My;
            by=[rx*u(1,j);zeros(My-3,1);rx*u(Mx+1,j)]+ry*(u_1(ii,j-1)+u_1(ii,j-1))+ry2*u_1(ii,j)+ot*u_1(ii,j);
            opts.UT = true; opts.TRANSA = true;
            u(ii,j)=linsolve(B,by,opts);
        end
    end
end
mesh(x,y,u);
xlabel('x');
zlabel('温度T')