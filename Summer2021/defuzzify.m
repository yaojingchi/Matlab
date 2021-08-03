function out = defuzzify(Qa,vrange)
    %DEFUZZIFY Output of fuzzy systm.

    v1 = vrange(1);
    v2 = vrange(2);

    v = linspace(v1,v2,100);
    Qv = Qa(v);
    out = sum(v.*Qv)/sum(Qv);
    if isnan(out)
        %   If Qv is zero everywhere, out will be NaN. Arbitrarily choose
        %   output to be the midpoint of vrange.
        out = mean(vrange);
    end
    