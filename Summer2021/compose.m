function h = compose(f,g)
    h= @composeFcn;
    function y = composeFcn(x)
        y = f(g(x));
    end
end