clear all
close all
clc
x1(0)=4;
x2(0)=1;
f =@(x1,x2)(0.001*(x1^4 + x2^4) + 3*x1 + 2*x2 +6);
delfx =@(x1)(0.004*x1^3 + 3);
delfy =@(x2)(0.004*x2^3 + 2);
thresh =1*10^-5;
kmax = 100;
ii =1;
deltaf(ii) =1;
x1(ii) = x10;
x2(ii) = x20;
fval(ii) =f(x1(ii),x2(ii));
while (ii<=kmax) && (deltaf(ii)>=thresh)
    a =(x1(ii)^2 + 9*x2(ii)^2)/(2*x1(ii)^2 + 54*x2(ii)^2);
    temp = -a*[delfx(x1(ii));delfy(x2(ii));
        fval(ii) =f(x1(ii),x2(ii));
        deltaf(ii) =abs(fval(ii) -fval(ii-1);
end
figure;
[X1,X2] =meshgrid(-5:0.02:5);
Z = 0.001*(x1.^4 + x2.^4) + 3*x1 + 2*x2 +6;
contour(X1,X2,Z);
hold on
h1 =plot(x1(1),x2(1),'ro','MarkerFaceColor','r');
a
temp=-a*[delfx(x1(1));delfy(x2(1))];
h2 =line([x1(1) x(1)