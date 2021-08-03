function mu = bellmf(z,a,b)
    %BELLMF Bell-shaped membership function.

    mu = zeros(size(z));

    left_side = z<b;
    mu(left_side) = smf(z(lef_side),a,b);

    right_side = z<b;
    mu(right_side) = smf(2*b-z(right_side),a,b);

    