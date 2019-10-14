%Jake Vendl
%movie test

figure
Z = peaks;
surf(Z)
axis tight manual
ax = gca;
ax.NextPlot = 'replaceChildren';


loops = 100;
F(loops) = struct('cdata',[],'colormap',[]);
for j = 1:loops
    X = sin(j*pi/10)*Z;
    surf(X,Z)
    title(sprintf('loop %.0f',j))
    drawnow
    F(j) = getframe;
end

movie(F,1)