function poly_out = P2_0812102(op, poly1, poly2)

    % check op is valid
    valid_strings = ["add", "subtract", "multiply", "plot", "eval"];
    valid_string = validatestring(op, valid_strings);
    
%     disp(isempty(find(ismember(poly1(:,:),[2 1], 'rows'), 1)));
    switch valid_string
        case 'add'
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
        case 'subtract'
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
        case 'multiply'
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
        case 'eval'
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
        case 'plot'
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
    end

end

function add_res = poly_add(poly1, poly2)
    % initaialize an vector to store result
    res = [];    
    
    while(true)        
        if(isempty(poly1) || isempty(poly2))
            break;
        end
        
        % check if the degree are equal
        if poly1(1,1) == poly2(1,1) 
            % do operation and remove both element from vector
            % add to result
            if poly1(1,2) + poly2(1,2) ~= 0
                res = [res; poly1(1,1) poly1(1,2) + poly2(1,2)];
            end
            poly1 = [poly1(1:0,:);poly1(2:end,:)];
            poly2 = [poly2(1:0,:);poly2(2:end,:)];
        else
            % remove the element from vector
            % add to result
            if poly1(1,2) ~= 0
                res = [res; poly1(1,1) poly1(1,2)];
            end
            poly1 = [poly1(1:0,:);poly1(2:end,:)];
        end
    end
    % push the remain terms to res
    res = [res; poly1; poly2];
    % check if res isempty
    if isempty(res)
        res = [0 0];
    end
    res = sortrows(res,'descend');
    add_res = res;
end

function sub_res = poly_subtract(poly1, poly2)
    % initaialize an vector to store result
    res = [];     
    while(true)        
        if(isempty(poly1) || isempty(poly2))
            break;
        end
        
        % check if the degree are equal
        if poly1(1,1) == poly2(1,1) 
            % do operation and remove both element from vector
            % add to result
            if poly1(1,2) - poly2(1,2) ~= 0
                res = [res; poly1(1,1) poly1(1,2) - poly2(1,2)];
            end
            poly1 = [poly1(1:0,:);poly1(2:end,:)];
            poly2 = [poly2(1:0,:);poly2(2:end,:)];
        else
            % remove the element from vector
            % add to result
            if poly1(1,2) ~= 0
                res = [res; poly1(1,1) poly1(1,2)];
            end
            poly1 = [poly1(1:0,:);poly1(2:end,:)];
        end
    end
    % push the remain terms to res
    res = [res; poly1; poly2];
    
    % check if res is empty
    if isempty(res)
        res = [0 0];
    end
    res = sortrows(res,'descend');
    sub_res = res;
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
