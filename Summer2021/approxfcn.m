function G = approxfcn(F,range)
    %APPROXFCN Approximation funciton.

    num_inputs = size(range,1);
    max_table_elements = 10000;
    max_table_dim = 100;
    table_dim =min(floor(max_table_elements^(1/num_inputs)),...
        max_table_dim);
    
    %   Compute the input grid values.
    inputs = cell(1,num_inputs);
    grid = cell(1,num_inputs);
    for k = 1:num_inputs
        grid{k} = linspace(range(k,1),range(k,2),table_dim);
    end

    if num_inputs > 1
        [ inputs{:} ] = ndgrid(grid{:});
    else
        inputs = grid;
    end

    %   Initialize the lookup table.
    table = zeros(size(inputs{1}));

    %   Initialize waitbar.
    bar = waitbar(0,'working...');

    %   Initialize cell array used to pass inputs to F.
    Zk = cell(1,num_inputs);
    L = numel(inputs{1});
    %   Update the progress bar at 2% intervals.
    for p = 1:L
        for k = 1:num_inputs
            Zk{k} = inputs{k}(p);
        end
        table(p) = F(Zk{:});
        if (rem(p,waitbar_update_interval) == 0)
            %   Update the progress bar
            waitbar(P/L);
        end
    end
    close(bar)

    G = @tableLookupFcn;

        %-------------------------------------------------------------%
        function out = tableLookupFcn(varargin)
            if num_inputs > 1
                out = interpn(grid{:},table,varargin{:});
            else
                out = interp1(grid{1},table,varargin{1});
            end
        end
    end
