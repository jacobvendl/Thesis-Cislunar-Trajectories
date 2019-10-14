function plotZeroVolumeSurface(X0,mu,tol)

    x0 = X0(1);
    y0 = X0(2);
    z0 = X0(3);
    xDot0 = X0(4);
    yDot0 = X0(5);
    zDot0 = X0(6);
    
    C = (x0^2 + y0^2) + 2*(1-mu)/((x0+mu)^2 + y0^2 + z0^2)^0.5... 
        + 2*mu/((x0-1+mu)^2 + y0^2 + z0^2)^0.5 - (xDot0^2+yDot0^2+zDot0^2);
    
    %now set velocity = 0 and solve for possible positions which satisfy
    %the equation
    xTest = -1:0.01:1;
    yTest = -1:0.01:1;
    zTest = -1:0.01:1;
    
    count=1;
    for i=1:length(xTest)
        for j=1:length(yTest)
            for k=1:length(zTest)
                x = xTest(i);
                y = yTest(j);
                z = zTest(k);
                d1 = sqrt((x+mu)^2+y^2+z^2);
                d2 = sqrt((x-1+mu)^2+y^2+z^2);
                eqnResult = (x^2+y^2) + 2*(1-mu)/d1 +2*mu/d2;
                if abs(C-eqnResult)<tol
                    xPlot(count) = x;
                    yPlot(count) = y;
                    zPlot(count) = z;
                    count=count+1;
                end
            end
        end
    end
    
    %now plot the surface
    figure; hold on; grid on; grid minor;
    %plot3(surfPoints(:,1),surfPoints(:,2),surfPoints(:,3),'b.')
    plot3(xPlot,yPlot,zPlot,'b.')
    axis equal;
    title(sprintf('Zero Velocity Surface w/ x0=[%.2f %.2f %.2f %.2f %.2f %.2f]',X0))
    
    
end