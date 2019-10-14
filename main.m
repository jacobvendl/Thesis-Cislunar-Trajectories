%Jake Vendl
%MS Thesis
%started Sep 30th, 2019

clear all; close all; clc

m1 = 5.972e24;
m2 = 7.3476e22;

mu = m2/(m1+m2);

tmax = 10;
time = linspace(0,tmax,tmax*10000);

tol = 1e-3;

x0 = [0.723268 0 0.25 0 0.198019 0]; %halo orbit IC's
plotZeroVolumeSurface(x0,mu,tol)

[time,output] = ode45(@(t,x) circular_RTBP(t,x,mu), time,x0);

figure; hold on; grid on; grid minor; 
plot3(-mu,0,0,'go','MarkerSize',8,'MarkerFaceColor','g')
plot3(1-mu,0,0,'ko','MarkerSize',4,'MarkerFaceColor','k')
plot3(x0(1),x0(2),x0(3),'g*')
plot3(output(:,1),output(:,2),output(:,3),'b-')
plot3(output(end,1),output(end,2),output(end,3),'r*')
axis([-1 1.5 -1 1])
axis equal
title('Cislunar motion in a rotating frame')
xlabel('x'); ylabel('y'); zlabel('z');
legend('Earth','Moon','s/c starting location','s/c path','s/c ending location')



