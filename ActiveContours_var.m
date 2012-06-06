axis([0 1 0 1])
hold on
ratio = [1 2];
areas = [];

[Xc Yc n] = pickControlPoints();

%Construction of the initial curve.
rPoints = spline(1:n, [Xc; Yc], 1:0.1:n);
plot3(rPoints(1, :), rPoints(2, :), zeros(1, (n - 1) * 10 + 1),'b-');
[geom, ~, ~] = polygeom(rPoints(1, :), rPoints(2, :));
centroid = [geom(2) geom(3)];
plot(geom(2), geom(3), 'x');
constArea = geom(1);

len = zeros(1, n);
i = 1;
while i <= n
    len(i) = norm([Xc(i) Yc(i)] - centroid);
    i = i + 1;
end

it = 1;
while ratio(it+1) > 0.1 && abs(ratio(it + 1) - ratio(it)) > 0.05
    i = 1;
    len = zeros(1, n);
    %Calculates the distance between each contol point and the centroid.
    while i <= n
        len(i) = norm([Xc(i) Yc(i)] - centroid);
        i = i + 1;
    end
    i = 1;
    while i <= n
        currPoint = ([Xc(i) Yc(i)] - centroid) / norm([Xc(i) Yc(i)] ...
                                                      - centroid) * ...
            std(len) * 0.5;
        if len(i) < mean(len)
            Xc(i) = Xc(i) + currPoint(1);
            Yc(i) = Yc(i) + currPoint(2);
            plot3(Xc(i), Yc(i), it * 0.2, 'go');
        else
            Xc(i) = Xc(i) - currPoint(1);
            Yc(i) = Yc(i) - currPoint(2);
            plot3(Xc(i), Yc(i), it * 0.2, 'go');
        end
        i = i + 1;
    end
    
    %Reconstructing the curve.
    rPoints = spline(1:n, [Xc; Yc], 1:0.5:n);
    [geom, ~, ~] = polygeom(rPoints(1, :), rPoints(2, :));
    areas(it) = geom(1);
    it = it + 1;
    ratio(it + 1) = (((geom(4) * geom(4)) / geom(1)) / (4 * pi)) - 1;
end

z = zeros(1, (n - 1) * 10 + 1);
z(1, :) = it * 0.2;
rPoints = spline(1:n, [Xc; Yc], 1:0.1:n);
plot3(rPoints(1, :), rPoints(2, :), z, 'bx');
hold off