axis([0 1 0 1])
hold on
idealRatio = 4 * pi;
ratio = 1;
oldRatio = 0;
area = 0;

[Xc Yc n] = pickControlPoints();

%Construction of the initial curve.
rPoints = spline(1:n, [Xc; Yc], 1:0.1:n);
plot(rPoints(1, :), rPoints(2, :), 'b-');
[geom, ~, ~] = polygeom(rPoints(1, :), rPoints(2, :));
centroid = [geom(2) geom(3)];
plot(geom(2), geom(3), 'x');
constArea = geom(1);

%Move the control points closer to a circle.
while abs(ratio - idealRatio) > 0.5% || abs(ratio - oldRatio) > 0.01
    %centroid = [geom(2) geom(3)];
    i = 1;
    bigLen = 0;
    bigIdx = 0;
    smlLen = 1;
    smlIdx = 0;
    %Search for the farthest and the closest points from the centroid.
    while i <= n
        len = norm([Xc(i) Yc(i)] - centroid);
        if len > bigLen
            bigLen = len;
            bigIdx = i;
        end
        if len < smlLen
            smlLen = len;
            smlIdx = i;
        end
        i = i + 1;
    end
    
    %Move the farthest point closer to the centroid.
    currPoint = centroid - [Xc(bigIdx) Yc(bigIdx)];
    distanceToMove = norm(currPoint) * 0.1;
    currPoint = currPoint * distanceToMove;
    Xc(bigIdx) = Xc(bigIdx) + currPoint(1);
    Yc(bigIdx) = Yc(bigIdx) + currPoint(2);
    plot(Xc(bigIdx), Yc(bigIdx), 'go');
    
    %Move the closest point farther away from the centroid.
    currPoint = [Xc(smlIdx) Yc(smlIdx)] - centroid;
    distanceToMove = norm(currPoint) * 0.1;
    currPoint = currPoint * distanceToMove;
    Xc(smlIdx) = Xc(smlIdx) + currPoint(1);
    Yc(smlIdx) = Yc(smlIdx) + currPoint(2);
    plot(Xc(smlIdx), Yc(smlIdx), 'go');
    
    %Reconstructing the curve.
    rPoints = spline(1:n, [Xc; Yc], 1:0.1:n);
    plot(rPoints(1, :), rPoints(2, :), 'b-');
    [geom, ~, ~] = polygeom(rPoints(1, :), rPoints(2, :));
    %plot(geom(2), geom(3), 'x');
    area = geom(1);
    oldRatio = ratio;
    ratio = (geom(4) * geom(4)) / area;
end

hold off