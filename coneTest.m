clear all; close all; clc

m1 = 5.972e24;
m2 = 7.3476e22;
mu = m2/(m1+m2);
earthPos = [-mu 0 0];
moonPos = [1-mu 0 0];

sun = load('SBToSun.mat');
earth = load('SBToEarth.mat');
moon = load('SBToMoon.mat');

%make time vector in JD, then convert to 2*pi scale
count = 1;
for d = 1:29
    for h = 1:24
        JD(count,1) = toJD(2020,1,d,h,0,0);
        sunVec(count,:) = sunVector(2020,1,d,h,0,0,sun,earth,moon)'; %TODO - VECTORIZE THE FUNCTION
        %to take in an array of julian dates and calculate
        %sun vector for each date
        count=count+1;
    end
end
tmax = 2*pi; %29.5 days
time = linspace(0,tmax,length(JD));
x0 = [0.723268 0 0.25 0 0.198019 0];
[time,output] = ode45(@(t,x) circular_RTBP(t,x,mu), time,x0);

for i=1:length(output)
    vecToEarth(i,:) = earthPos - output(i,1:3);
    vecToMoon(i,:) = moonPos - output(i,1:3);
end

figure; hold on; grid on; grid minor
plot3(output(:,1),output(:,2),output(:,3),'b-')
plot3(-mu,0,0,'go','MarkerSize',8,'MarkerFaceColor','g')
plot3(1-mu,0,0,'ko','MarkerSize',4,'MarkerFaceColor','k')
legend('s/c path','Earth','Moon')

%%
f =figure; hold on; grid on; grid minor
plot3(-mu,0,0,'go','MarkerSize',8,'MarkerFaceColor','g')
plot3(1-mu,0,0,'ko','MarkerSize',4','MarkerFaceColor','k')
axis([-1 1.5 -1 1 -0.5 0.5])

x = output(1,1);
y = output(1,2);
z = output(1,3);
p1 = plot3(x,y,z,'b.');
p2 = plot3(output(1,1),output(1,2),output(1,3),'b-','LineWidth',2);
sunCone = Cone([x;y;z],[x+sunVec(1,1)/2;y+sunVec(1,2)/2;z+sunVec(1,3)/2],[0 tand(10)],20,'r',0,1);
earthCone = Cone([x;y;z],([x;y;z]+earthPos')/2,[0 tand(3)],10,[0 0.5 0],0,1);
moonCone = Cone([x;y;z],([x;y;z]+moonPos')/2,[0 tand(2)],10,[0.25 0.25 0.25],0,1);
[yr,day] = toGregorian(JD(1));
title(sprintf('s/c position - Jan %.0f, 2020',day))
legend('Earth','Moon','s/c position','s/c path','Sun exclusion cone','Earth exclusion cone','Moon exclusion cone')
view(-110,23)
M(1) = getframe(f);
delete(sunCone); delete(earthCone); delete(moonCone);
for i=2:length(output)
    x = output(i,1);
    y = output(i,2);
    z = output(i,3);
    p1 = plot3(x,y,z,'b.','HandleVisibility','off');
    p2 = plot3(output(1:i,1),output(1:i,2),output(1:i,3),'b-','LineWidth',2,'HandleVisibility','off');
    sunCone = Cone([x;y;z],[x+sunVec(i,1)/2;y+sunVec(i,2)/2;z+sunVec(i,3)/2],[0 tand(10)],20,'r',0,1);
    earthCone = Cone([x;y;z],([x;y;z]+earthPos')/2,[0 tand(3)],10,[0 0.5 0],0,1);
    moonCone = Cone([x;y;z],([x;y;z]+moonPos')/2,[0 tand(2)],10,[0.25 0.25 0.25],0,1);
    [yr,day] = toGregorian(JD(i));
    title(sprintf('s/c position - Jan %.0f, 2020',day))
    legend('Earth','Moon','s/c position','s/c path','Sun exclusion cone','Earth exclusion cone','Moon exclusion cone')
    view(-110-100/length(output)*i,23)
    M(i) = getframe(f);
    delete(p1);
    delete(sunCone); delete(earthCone); delete(moonCone);
end

%%
video = VideoWriter('jan2020.avi', 'Uncompressed AVI');
video.FrameRate = 60;
open(video)
writeVideo(video, M);
close(video);

