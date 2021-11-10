m = 39;
h = 1/(m+1);
x = linspace(0,1,m+2);
y = linspace(0,1,m+2);

[X,Y] = meshgrid(x,y);
X = X';
Y = Y';

Iint = 2:m+1;
Jint = 2:m+1;
Xint = X(Iint,Jint);
Yint = Y(Iint,Jint);

f = @(x,y) 1.25*exp(x+y/2);
rhs = f(Xint,Yint);
utrue = exp(X+Y/2);
usoln = utrue;

rhs(:,1) = rhs(:,1) - usoln(Iint,1)/h^2;
rhs(:,m) = rhs(:,m) - usoln(Iint,m+2)/h^2;
rhs(1,:) = rhs(1,:) - usoln(1,Jint)/h^2;
rhs(m,:) = rhs(m,:) - usoln(m+2,Jint)/h^2;

F = reshape(rhs,m*m,1);

I = speye(m);                       %m*m的單位稀疏矩陣
e = ones(m,1);                      %[1 1 1 1 ... 1]'
T = spdiags([e -4*e e],[-1 0 1],m,m);%將e放到對角線向上1 向下1 的位置，-4放到對角線上
S = spdiags([e e],[-1 1],m,m);      %將e向量放到對角線向上1 向下1 的位置
A = (kron(I,T) + kron(S,I)) / h^2;  %kron(I,T)生成對角線都是T的稀疏矩陣
                                    %kron(S,I)生成對角線向上1 向下1 的位置都是矩陣I的稀疏矩陣
%設定A矩陣

uvec = A\F;

usoln(Iint,Jint) = reshape(uvec,m,m);



error=abs(usoln-utrue);
E = sum(sum(error.*error));
l_2norm = sqrt((1/length(uvec))*sum(sum(error.*error)));