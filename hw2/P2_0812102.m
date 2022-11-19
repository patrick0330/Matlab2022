function poly_out = P2_0812102(op, poly1, poly2)
    % check op is valid
    valid_strings = ["add", "subtract", "multiply", "plot", "eval"];
    op = convertCharsToStrings(op);
    valid_string = validatestring(op, valid_strings);
    
%     disp(isempty(find(ismember(poly1(:,:),[2 1], 'rows'), 1)));
    switch valid_string
        case "add"
            % check if degree is numeric, nonnegative and in decreasing order
            % check coeffcient is numeric
            validateattributes(poly1(:, 1), {'numeric'}, {'nonnegative','decreasing'});
            validateattributes(poly1(:, 2), {'numeric'}, {});
            validateattributes(poly2(:, 1), {'numeric'}, {'nonnegative','decreasing'});
            validateattributes(poly2(:, 2), {'numeric'}, {});
            
            % check if coeffcient is zero except [0 0]
            if numel(poly1(:,1)) > 1 && ~isempty(find(poly1(:,2) == 0, 1))
                error('Coeffcient must be nonzero');
            elseif numel(poly1(:,1)) == 1 && ~isequal(poly1(1,:), [0 0])
                error('Coeffcient must be nonzero');
            end
            if numel(poly2(:,1)) > 1 && ~isempty(find(poly2(:,2) == 0, 1))
                error('Coeffcient must be nonzero');
            elseif numel(poly2(:,1)) == 1 && ~isequal(poly2(1,:), [0 0])
                error('Coeffcient must be nonzero');
            end
            poly_out = poly_add(poly1, poly2);
        case "subtract"
            % check if degree is numeric, nonnegative and in decreasing order
            % check coeffcient is numeric
            validateattributes(poly1(:, 1), {'numeric'}, {'nonnegative','decreasing'});
            validateattributes(poly1(:, 2), {'numeric'}, {});
            validateattributes(poly2(:, 1), {'numeric'}, {'nonnegative','decreasing'});
            validateattributes(poly2(:, 2), {'numeric'}, {});
            
            % check if coeffcient is zero except [0 0]
            if numel(poly1(:,1)) > 1 && ~isempty(find(poly1(:,2) == 0, 1))
                error('Coeffcient must be nonzero');
            elseif numel(poly1(:,1)) == 1 && ~isequal(poly1(1,:), [0 0])
                error('Coeffcient must be nonzero');
            end
            if numel(poly2(:,1)) > 1 && ~isempty(find(poly2(:,2) == 0, 1))
                error('Coeffcient must be nonzero');
            elseif numel(poly2(:,1)) == 1 && ~isequal(poly2(1,:), [0 0])
                error('Coeffcient must be nonzero');
            end
            
            poly_out = poly_subtract(poly1, poly2);
        case "multiply"
            % check if degree is numeric, nonnegative and in decreasing order
            % check coeffcient is numeric
            validateattributes(poly1(:, 1), {'numeric'}, {'nonnegative','decreasing'});
            validateattributes(poly1(:, 2), {'numeric'}, {});
            validateattributes(poly2(:, 1), {'numeric'}, {'nonnegative','decreasing'});
            validateattributes(poly2(:, 2), {'numeric'}, {});
            
            % check if coeffcient is zero except [0 0]
            if numel(poly1(:,1)) > 1 && ~isempty(find(poly1(:,2) == 0, 1))
                error('Coeffcient must be nonzero');
            elseif numel(poly1(:,1)) == 1 && ~isequal(poly1(1,:), [0 0])
                error('Coeffcient must be nonzero');
            end
            if numel(poly2(:,1)) > 1 && ~isempty(find(poly2(:,2) == 0, 1))
                error('Coeffcient must be nonzero');
            elseif numel(poly2(:,1)) == 1 && ~isequal(poly2(1,:), [0 0])
                error('Coeffcient must be nonzero');
            end
            
            poly_out = poly_mul(poly1, poly2);
        case "eval"
            % check if degree is numeric, nonnegative and in decreasing order
            % check coeffcient is numeric
            validateattributes(poly1(:, 1), {'numeric'}, {'nonnegative','decreasing'});
            validateattributes(poly1(:, 2), {'numeric'}, {});
            validateattributes(poly2(:), {'numeric'}, {'nonempty'});
            
             % check if coeffcient is zero except [0 0]
            if numel(poly1(:,1)) > 1 && ~isempty(find(poly1(:,2) == 0, 1))
                error('Coeffcient must be nonzero');
            elseif numel(poly1(:,1)) == 1 && ~isequal(poly1(1,:), [0 0])
                error('Coeffcient must be nonzero');
            end
            
            poly_out = poly_eval(poly1, poly2);
        case "plot"
            validateattributes(poly1(:, 1), {'numeric'}, {'nonnegative','decreasing'});
            validateattributes(poly1(:, 2), {'numeric'}, {});
            validateattributes(poly2(:), {'numeric'}, {'nonempty'});
            
             % check if coeffcient is zero except [0 0]
            if numel(poly1(:,1)) > 1 && ~isempty(find(poly1(:,2) == 0, 1))
                error('Coeffcient must be nonzero');
            elseif numel(poly1(:,1)) == 1 && ~isequal(poly1(1,:), [0 0])
                error('Coeffcient must be nonzero');
            end            
            poly_out = poly_plot(poly1, poly2);
        otherwise
            error('Unknown op');
    end

end

function add_res = poly_add(poly1, poly2)
    % initaialize an vector to store result
    res = [-1 -1];    
    add_res = [];
    found = false;
    while(true)        
        if(isempty(poly1) || isempty(poly2))
            break;
        end
        % check if the degree are equal
        for i = 1 : numel(poly2(:,1))
            if poly1(1, 1) == poly2(i, 1)
                found = true; 
                % if the result not equal 0, add to res 
                if poly1(1,2) + poly2(i, 2) ~= 0
                    res = [res; poly1(1,1) poly1(1,2) + poly2(i,2)];
                end
                poly1 = [poly1(1:0,:);poly1(2:end,:)];
                poly2 = [poly2(1:i - 1,:);poly2(i + 1:end,:)];
                break;
            end
        end
        
        % if no same degree term found, pop from poly1
        if ~found
            res = [res; poly1(1,1) poly1(1,2)];
            poly1 = [poly1(1:0,:);poly1(2:end,:)];
        else 
            found = false;
        end        
    end
    % push the remain terms to res
    res = [res; poly1; poly2];
    
    for i = 1 : numel(res(:, 1))
        if res(i, 2) ~= 0 && res(i, 1) ~= -1
            add_res = [add_res;res(i, 1) res(i, 2)];
        end
    end
    % check if res isempty
    if isempty(add_res)
        add_res = [0 0];
    end
    add_res = sortrows(add_res,'descend');
end

function sub_res = poly_subtract(poly1, poly2)
   poly2(:, 2) = poly2(:, 2) .* -1;
   sub_res = poly_add(poly1, poly2);
end

function mul_res = poly_mul(poly1, poly2)
     % initaialize an vector to store result
    res = [-1 -1];     
    while(true)        
        if(isempty(poly1))
            break;
        end
        
        for i = 1 : size(poly2,1) 
            deg = poly1(1,1) + poly2(i,1);
            coef = poly1(1,2) * poly2(i,2);
            % check if deg is in res
            % not in res
            if(isempty(find(res(:, 1) == deg, 1)) == true && coef ~= 0)
                res = [res; deg coef];
            else
                row = find(res(:, 1) == deg);
                res(row, 2) = res(row, 2) + coef;
                % if the coeffcient is zero, remove from res
                if res(row, 2) == 0
                    res = [res(1:row - 1,:);res(row + 1:end,:)];
                end
            end
        end
        
        % remove from vector
        poly1 = [poly1(1:0,:);poly1(2:end,:)];
%         disp(res);
    end
    % [-1 -1] case
    if res(1,1) == -1 && numel(res(:, 1)) == 1
        res(1,:) = [0 0];
    else
        res = res(2:end,:);
    end
    res = sortrows(res,'descend');
    mul_res = res;
end



function eva_res = poly_eval(poly1, x)
    x = sort(x);
    y = zeros(1, numel(x));
    % calculate y with x values
    for i = 1 : numel(x)
        for j = 1 : size(poly1, 1)
            y(i) = y(i) + x(i) ^ poly1(j, 1) * poly1(j, 2);
        end
    end
    eva_res = y;
end

function plot_res = poly_plot(poly1, x)
    x = sort(x);
    % use eval function to get y result 
    y =  poly_eval(poly1, x);
    plot_res = plot(x, y);
end