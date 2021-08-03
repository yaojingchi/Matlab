function F = fuzzysysfcn(inmf,outmf,vrange,op)
    %FUZZYSYSFCN  Fuzzy system function.

    if nargin < 4
        op = @min;
    end

    %   The kambda funtions are independant of the inputs Z1,Z2,Z3...
    %   ZN,so they can be computed in addvance.
    L = lambdafcns(inmf,op);

    F = @fuzzyOutput;
        %-------------------------------------------------------%
        function out = fuzzyOutput(varargin)
            Z = varargin;
            %   The implication functions and aggregation functions
            %   have to be compued separately for each input value.
            %   Therefore we have to loop over each input value y determine
            %   the corresponding output value. Zk id a cell array that will
            %   be used to pass scalar values for each input (Z1,Z2,...ZN)
            %   to IMPLFCNS.
            Zk = cell(1,numel(Z));
            %   Initialize the array of putput values to be the same size 
            %   as the first input, Z{1}.
            out = zeros(size(Z{1}));
            for k = 1:numel(Z{1})
                for p = 1:numel(Zk)
                    Zk{p} = Z{p}(k);
                end
                Q = implfcns(L,outmf,Zk{:});
                Qa = aggfcn(Q);
                out(k) = defuzzify(Qa,vrange);
            end
        end
    end
