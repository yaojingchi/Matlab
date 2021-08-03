function y = sinfun1(M)
    x = 0:M - 1;

    for k = 1:numel(x)
        y = sin(x(k) / (100 * pi));
    end
