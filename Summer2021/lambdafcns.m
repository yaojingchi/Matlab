function L = lambdafcns(inmf,op)
    %LAMBDAFCNS Lambda functions for a set of suzzy rules.

    if nargin < 2
        %   Set default operator for combining rule antecedents.
        op =@min;
    end

    num_rules = size(inmf,1);
    L = cell(1,num_rules);

    for i = 1:num_rules
        %   Each output lambda function calls rulesStrength() function
        %   with i ( to dientify which row of the rules matrix shoule be
        %   used), followed by all the Z input arguments (which are passed 
        %   along via varargin).

        L{i} = @(varargin) ruleStrength(i,varargin{:});
    end

    %---------------------------------------------------------------------%
    function lambda = ruleStrength(i,varargin)
        %   lambda = ruleStrength(i,Z1,Z2,Z3,...)
        Z = varargin;
        %   Initialize lambda as the output of the first membership
        %   function of the k-th rule.
        memberfcn = inmf{i,1};
        lambda = memberfcn(Z{1});
        for j = 2:numel(varargin)
            memberfcn = inmf{i,j};
            lambda = op(lambda,memberfcn(Z{j}));
        end
    end
end