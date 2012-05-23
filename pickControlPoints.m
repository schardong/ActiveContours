function [X, Y, n] = pickControlPoints()
%pickControlPoints Picks the control points for the spline and returns them
%   Detailed explanation goes here
hold on
X = [];
Y = [];
n = 0;
disp('Left mouse button picks points.')
disp('Right mouse button picks last point.')
bt = 1;
while bt == 1
    n = n + 1;
    [X(n), Y(n), bt] = ginput(1);
    if bt ~= 1
        X(n) = X(1);
        Y(n) = Y(1);
        return;
    end
    plot(X(n), Y(n), 'ro');
end
hold off
return;
end

