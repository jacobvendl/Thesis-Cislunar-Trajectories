%Jake Vendl
%MS Thesis

function [sunVec] = sunVector(yr,mo,d,h,mn,s,sun,earth,moon)

%this function finds the vector from the Sun to the Earth-Moon system, for
%purposes of determining lighting constraints in cislunar space

%get JD vector
for i=1:length(sun.SolarBarycenterToSun)
    JDdata(i,1) = sun.SolarBarycenterToSun{i,1};
end

%find the index of the positions closest to the requested julian date
JD = toJD(yr,mo,d,h,mn,s);
index = find(abs(JD - JDdata) <0.01);

for i=1:length(sun.SolarBarycenterToSun)
    sunPos(i,:) = [sun.SolarBarycenterToSun{i,5} sun.SolarBarycenterToSun{i,6} sun.SolarBarycenterToSun{i,7}];
    earthPos(i,:) = [earth.SolarBarycenterToEarth{i,5} earth.SolarBarycenterToEarth{i,6} earth.SolarBarycenterToEarth{i,7}];
    moonPos(i,:) = [moon.SolarBarycenterToMoon{i,5} moon.SolarBarycenterToMoon{i,6} moon.SolarBarycenterToMoon{i,7}];
end

%find Earth-Moon rotating frame by first establishing z-axis, normal to
%motion of primaries

%find vector from Earth to Moon at time being considered
EarthToMoon = (moonPos(index,:)-earthPos(index,:))/norm((moonPos(index,:)-earthPos(index,:))); %local x axis

%look at the current day to establish Earth-Moon plane of motion
for i=1:24
     EtoM(i,:) = moonPos(d*24+i,:) - earthPos(d*24+i,:);
end

%define plane of motion
normalToPlane = cross(EtoM(1,:),EtoM(24,:))/norm(cross(EtoM(1,:),EtoM(24,:)));
rightHandTriad = cross(normalToPlane,EarthToMoon);

Xem = [1 0 0];
Yem = [0 1 0];
Zem = [0 0 1];

Xs = EarthToMoon;
Ys = rightHandTriad;
Zs = normalToPlane;

DCM = [dot(Xem,Xs) dot(Xem,Ys) dot(Xem,Zs);
       dot(Yem,Xs) dot(Yem,Ys) dot(Yem,Zs);
       dot(Zem,Xs) dot(Zem,Ys) dot(Zem,Zs)]';
    
%finally we can move the sun to earth vector into the right frame
SunToEarth = earthPos(index,:)-sunPos(index,:);
sunVec = DCM*SunToEarth';
sunVec = sunVec./norm(sunVec);

end


