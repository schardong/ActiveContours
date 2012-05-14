axis([0 1 0 1])
hold on
% Initially, the list of points is empty.
Xc = [];
Yc = [];
n = 0;
idealRatio = 1 / (4 * pi);  %Area / Perimeter^2
ratio = 1;
% Loop, picking up the points.
disp('Left mouse button picks points.')
disp('Right mouse button picks last point.')
but = 1;
while but == 1
    n = n + 1;
    [Xc(n), Yc(n), but] = ginput(1);
    if but ~= 1
        Xc(n) = Xc(1);
        Yc(n) = Yc(1);
        break;
    end
    plot(Xc(n), Yc(n), 'ro');
end
% Interpolate with a spline curve and finer spacing.
pp = spline(1:n, [Xc; Yc]);
rPoints = ppval(pp, 1:0.1:n);
polyarea(rPoints(1, :), rPoints(2, :));
[geom, ~, ~] = polygeom(rPoints(1, :), rPoints(2, :));
ratio = geom(1) / (geom(4)*geom(4));

% Plot the interpolated curve.
plot(rPoints(1, :), rPoints(2, :), 'b-');
hold off