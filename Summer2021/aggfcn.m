function Qa = aggfcn(Q)
    %AGGFCN Aggregation function for a fuzzy system.

    Qa = @aggregate;

    function q = aggregate(v)
        q = Q{1}(v);
        for i = 2:numel(Q)
            q = max(q,Q{i}(v));
        end
    end
end
