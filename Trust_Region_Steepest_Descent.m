clear all 
close all
clc
%Defining grid
l=-20;
m=20;
del=0.5;
[x1p,x2p]=meshgrid(l:del:m,l:del:m);
%Defining the function
f=0.001*(x1p.^4 +x2p.^4) +3*x1p + 2*x2p + 6;
%Plotting the function
plot3(x1p,x2p,f,'cyan');
xlabel('x1');
ylabel('x2');
zlabel('f(x1,x2)');
grid on;
hold on;
%Defining the intital points
x0(1,1)=l+(m-l)*rand(1);
x0(2,1)=l+(m-l)*rand(1);
x=x0;
%Initializing Gradient vector
g=zeros(2,1);
%Initializing Tracking Array 
trackx1=[];
trackx2=[];
gtrack=[];
%Total no of iterations
kmax=100;
eps=0.00001;
for k=1:kmax
    %Defining Gradient Vector
    g(1,1)= 0.004*x(1)^3 + 3;
    g(2,1)= 0.004*x(2)^3 + 2;
    %Calculating the gain Factor
    h=-g;
    xtemp=x+h;
    ztemp=0.001*(x(1)^4 +x(2)^4) +3*x(1) + 2*x(2) + 6;
    ztemp2=0.001*(xtemp(1)^4 +xtemp(2)^4) +3*xtemp(1) + 2*xtemp(2) + 6;
    q0=ztemp;
    qh=ztemp + (h'*g);
    r= (ztemp - ztemp2)/(q0 - qh);
    %Updating h in case r in not appropriate
    while r <= 0.25 || r >= 0.75
        if r >= 0.75
            h=2*h;
            xtemp=x+h;
            ztemp=0.001*(x(1)^4 +x(2)^4) +3*x(1) + 2*x(2) + 6;
            ztemp2=0.001*(xtemp(1)^4 +xtemp(2)^4) +3*xtemp(1) + 2*xtemp(2) + 6;
            q0=ztemp;
            qh=ztemp + (h'*g);
            r= (ztemp - ztemp2)/(q0 - qh);
        end
        if r<= 0.25
            h=h/3;
            xtemp=x+h;
            ztemp=0.001*(x(1)^4 +x(2)^4) +3*x(1) + 2*x(2) + 6;
            ztemp2=0.001*(xtemp(1)^4 +xtemp(2)^4) +3*xtemp(1) + 2*xtemp(2) + 6;
            q0=ztemp;
            qh=ztemp + (h'*g);
            r= (ztemp - ztemp2)/(q0 - qh);
        end
    end
    %Tracking x1, x2, f and ||g||inf
    trackx1(k,1)=x(1);
    trackx2(k,1)=x(2);
    gtrack(k,1)= max(g(1,1),g(2,1));
    ftrack(k,1)=0.001*(x(1)^4 +x(2)^4) +3*x(1) + 2*x(2) + 6;
    %Setting the tolerance condition using Norm inf to break away from loop
    if abs(max(g(1,1),g(2,1)))<eps
        break
    end
    %Updating x
    x=x+h;
end
%Plotting the path taken i.e f(x1,x2) k
plot3(trackx1,trackx2,ftrack,'k.');
fprintf('Final Value of x1 and x2 is (%f,%f)\n',x(1),x(2));
fprintf('Number of Iterations taken %d\n',k);
figure;
%Plotting ||g||inf vs k
plot(gtrack,'r*');
grid on;
xlabel('k');
ylabel('||g||inf');
fprintf('Minimum Function value is %f \n',ftrack(k));


