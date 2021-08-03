function y = sinfun2(M)
    x = 0:M - 1;
    y = zeros(1, numel(x));

    for k = 1:numel(x)
        y(k) = sin((k) / (100 * pi));
    end
