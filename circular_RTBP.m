%Jake Vendl
%MS Thesis

function dXdt = circular_RTBP(t,X,mu)

x = X(1);
y = X(2);
z = X(3);
vx = X(4);
vy = X(5);
vz = X(6);

r1 = sqrt((x+mu)^2 + y^2 + z^2);
r2 = sqrt((x+mu-1)^2 + y^2 + z^2);

g1 = x-(1-mu)*(x+mu)/r1^3 - mu*(x+mu-1)/r2^3;
g2 = y-(1-mu)*y/r1^3 - mu*y/r2^3;
g3 = -(1-mu)*z/r1^3 - mu*z/r2^3;

h1 = 2*vy;
h2 = -2*vx;

dvx = g1 + h1; 
dvy = g2 + h2;
dvz = g3;

dx = vx;
dy = vy;
dz = vz;

dXdt = [dx dy dz dvx dvy dvz]';

end