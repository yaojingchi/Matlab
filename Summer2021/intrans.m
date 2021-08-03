function g = intrans(f, method, varargin)
    %INTRANS Performs intensity(gray-level) transformations.
    error(nargchk(2, 4, nargin))

    if strcmp(method, 'log')
        %   The log transform handles image classes ifferently than the
        %   other transforms, so let the logTransform function handle that
        %   and then return.
        g = logTransform(f, varargin{:});
        return;
    end

    %   If f os floating point, check to see if it is in the range [0 1].
    %   If it is not, ofrce it to be using function mat2gray.
    if isfloat(f) && (max(f(:)) > 1 || min(f(:)) < 0)
        f = mat2gray(f);
    end

    [f, revertclass] = tofloat(f); % Store class of f for use later.

    %   Perform the intensity transformation specified.
    switch method
        case 'neg'
            g = imcomplement(f);

        case 'gamma'
            g = gammaTransform(f, varargin{:});

        case 'stretch'
            g = stretchTransform(f, varargin{:});

        case 'specifird'
            g = spcfiedTransform(f, varargin{:});

        otherwise
            error('Unknown enhancement method.')
    end

    %   Convert to the class of the input image.
    g = revertclass(g);

    %--------------------------------------------------------------------------------%
    function g = gammaTransform(f, gamma)
        g = imadjust(f, [], [], gamma);

        %--------------------------------------------------------------------------------%
        function g = stretchTransform(f, varargin)

            if isempty(varargin)
                %   Use defaults.
                m = mean2(f);
                E = 4.0;
            elseif length(varargin) == 2
                m = varargin{1};
                E = varargin{2};
            else
                error('Incorrect number of inputs for the stretch method.')
            end

            g = 1 ./ (1 + (m ./ f).^E);

            %--------------------------------------------------------------------------------%
            function g = spcfiedTransform(f, txfun)
                %   f is floating point with values in the range [0 1].
                txfun = txfun(:); %  Force it to be a column vextor.

                if any(txfun) > 1 || any(txfun) <= 0
                    error('All elements of txfun must be in the range [0 1].')
                end

                T = txfun;
                x = linspace(0, 1, numel(T));
                g = interp1(X, T, f);
                %--------------------------------------------------------------------------------%
                function g = logTransform(f, varargin)
                    [f, revertclass] = tofloat(f);

                    if numel(varargin) >= 2

                        if strcmp(varargin{2}, 'uint8')
                            revertclass = @im2uint8;
                        elseif strcmp(varargin{2}, 'uint16')
                            revertclass = @im2uint16;
                        else
                            error('Unsupported CLASS option for "log"method.')
                        end

                    end

                    if numel(varargin) < 1
                        %   Set default for C.
                        C = 1;
                    else
                        C = varargin{1};
                    end

                    g = C * (log(1 + f));
                    g = revertclass(g);
