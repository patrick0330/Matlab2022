classdef SparsePoly
    properties(SetAccess = private) % set properties private
        degree
        coefficient
    end
    methods
        function obj = SparsePoly(deg, coef)
            if nargin == 0 % if no input args -> zero poly
                obj.degree = 0;
                obj.coefficient = 0;
            else 
                if numel(deg) ~= numel(coef) % check if deg and coef have the same size
                    error("Degree and coefficient must have same size.");
                end
                validateattributes(deg, {'numeric'}, {'decreasing', 'nonempty'});
                validateattributes(coef, {'numeric'}, {'nonempty'});
                if numel(deg) == 1 && deg(1) ~= 0 && coef(1) == 0
                    error('Coeffcient must be nonzero');
                end
                obj.degree = deg;
                obj.coefficient = coef;
            end
        end
        function obj = plus(obj1, obj2)            
            if isscalar(obj1) && ~isscalar(obj2) % scalar to array 
                obj(1,numel(obj2)) = SparsePoly;
                for i = 1 : numel(obj2) % iterate through obj2
                    obj(i) = poly_add(obj1, obj2(i));
                end
                obj = reshape(obj,size(obj2));
            elseif ~isscalar(obj1) && isscalar(obj2) % array to scalar
                obj(1,numel(obj1)) = SparsePoly;
                for i = 1 : numel(obj1) % iterate through obj1
                    obj(i) = poly_add(obj1(i), obj2);
                end
                obj = reshape(obj,size(obj1));
            else % array to array
                obj(1,numel(obj1)) = SparsePoly;              
                for i = 1 : numel(obj1) % iterate through obj1
                    obj(i) = poly_add(obj1(i), obj2(i));
                end
                obj = reshape(obj,size(obj1));
            end
            
        end        
        function obj = minus(obj1, obj2)           
            if isscalar(obj1) && ~isscalar(obj2) % scalar to array 
                obj(1,numel(obj2)) = SparsePoly;
                for i = 1 : numel(obj2) % iterate through obj2
                    obj2(i).coefficient = obj2(i).coefficient .* -1;
                    obj(i) = poly_add(obj1, obj2(i));
                end
                obj = reshape(obj,size(obj2));
            elseif ~isscalar(obj1) && isscalar(obj2) % array to scalar
                obj(1,numel(obj1)) = SparsePoly;
                obj2.coefficient = obj2.coefficient .* -1;
                for i = 1 : numel(obj1) % iterate through obj1
                    obj(i) = poly_add(obj1(i), obj2);
                end
                obj = reshape(obj,size(obj1));
            else % array to array
                obj(1,numel(obj1)) = SparsePoly;              
                for i = 1 : numel(obj1) % iterate through obj1
                    obj2(i).coefficient = obj2(i).coefficient .* -1;
                    obj(i) = poly_add(obj1(i), obj2(i));
                end
                obj = reshape(obj,size(obj1));
            end
        end 
        
        function obj = times(obj1, obj2)            
            if isscalar(obj1) && ~isscalar(obj2) % scalar to array 
                obj(1,numel(obj2)) = SparsePoly;
                for i = 1 : numel(obj2) % iterate through obj2
                    obj(i) = poly_mul(obj1, obj2(i));
                end
                obj = reshape(obj,size(obj2));
            elseif ~isscalar(obj1) && isscalar(obj2) % array to scalar
                obj(1,numel(obj1)) = SparsePoly;
                for i = 1 : numel(obj1) % iterate through obj1
                    obj(i) = poly_mul(obj1(i), obj2);
                end
                obj = reshape(obj,size(obj1));
            else % array to array
                obj(1,numel(obj1)) = SparsePoly;              
                for i = 1 : numel(obj1) % iterate through obj1
                    obj(i) = poly_mul(obj1(i), obj2(i));
                end
                obj = reshape(obj,size(obj1));
            end
            
        end
        
        function res = eval(obj, x)
            validateattributes(x(:), {'numeric'}, {'nonempty'});
            x = sort(x);
            res = cell(size(obj, 1), size(obj, 2));
            
             % calculate y with x values
            for i = 1 : numel(obj)   
                res{i} = zeros(1, numel(x));
                for j = 1 : numel(x)
                    for k = 1 : numel(obj(i).degree)
                        res{i}(j) = res{i}(j) + x(j) ^ obj(i).degree(k) * obj(i).coefficient(k);
                    end
                end
            end         
            
        end
        function res = plot(obj, x)
            validateattributes(x(:), {'numeric'}, {'nonempty'});
            x = sort(x);
            y = eval(obj, x);
            hold on
            for i = 1 : numel(y)
                res = plot(x, y{i});
            end
            hold off
        end
        function disp(obj)
            if size(obj, 1) > 1 || size(obj, 2) > 1
                fprintf("SparsePoly array (size %dx%d)\n", size(obj, 1), size(obj, 2))
            elseif obj.degree(1) == 0 && numel(obj.degree) == 1 % if zero poly is displayed
                fprintf("%d\n", obj.coefficient);
            else % normal poly                
                fprintf("%dx^%d", obj.coefficient(1),obj.degree(1));
                
                for i = 2:numel(obj.coefficient)
                    if obj.degree(i) == 0 % deal with the constant term
                        if obj.coefficient(i) > 0 % deal with the + and - 
                            fprintf("+%d", obj.coefficient(i));
                        else 
                            fprintf("%d", obj.coefficient(i));
                        end
                    else % other terms
                        if obj.coefficient(i) > 0 % deal with the + and - 
                        fprintf("+%dx^%d", obj.coefficient(i),obj.degree(i));
                        else
                            fprintf("%dx^%d", obj.coefficient(i),obj.degree(i));
                        end
                    end
                end                
                fprintf("\n");
            end
        end
        
        function add_res = poly_add(obj1, obj2)
            add_res = SparsePoly;
            % initaialize an vector to store result            
            poly1 = obj1;
            poly2 = obj2;                   
            add_res.degree = [];
            add_res.coefficient = [];
            found = false; % check if same degree found in iterations
%             fprintf("Begin of a new run\n");
            while(true)   
%                 fprintf("deg1 ");
%                 fprintf("%d ", poly1.degree);
%                 fprintf("\n");
%                 fprintf("coef1 ");
%                 fprintf("%d ", poly1.coefficient);
%                 fprintf("\n");
%                 fprintf("deg2 ");
%                 fprintf("%d ", poly2.degree);
%                 fprintf("\n");
%                 fprintf("coef2 ");
%                 fprintf("%d ", poly2.coefficient);
%                 fprintf("\n");
                if(isempty(poly1.degree))
                    break;
                end
                if(isempty(poly2.degree))
                    break;
                end
                % check if the degree are equal
                for i = 1 : numel(poly2.degree)
                    if poly1.degree(1) == poly2.degree(i)  
                        found = true; 
                        % if the result not equal 0, add to res 
                        if poly1.coefficient(1) + poly2.coefficient(i) ~= 0
                            add_res.degree = [add_res.degree, poly1.degree(1)];
                            add_res.coefficient = [add_res.coefficient, poly1.coefficient(1) + poly2.coefficient(i)];
                        end
                        poly1.degree = [poly1.degree(1:0), poly1.degree(2:end)];
                        poly2.degree = [poly2.degree(1:i - 1), poly2.degree(i + 1:end)];
                        poly1.coefficient = [poly1.coefficient(1:0), poly1.coefficient(2:end)];
                        poly2.coefficient = [poly2.coefficient(1:i - 1), poly2.coefficient(i + 1:end)];
                        break;
                    end
                    
                end

                % if no same degree term found, pop from poly1
                if ~found
                    if poly1.coefficient(1) ~= 0%                       
                        add_res.degree = [add_res.degree, poly1.degree(1)];
                        add_res.coefficient = [add_res.coefficient, poly1.coefficient(1)];
                    end
                    poly1.degree = [poly1.degree(1:0), poly1.degree(2:end)];
                    poly1.coefficient = [poly1.coefficient(1:0), poly1.coefficient(2:end)];
                else 
                    found = false;
                end        
            end
            % push the remain terms to res
%             disp(poly2)
            for i = 1 : numel(poly1.degree)
                if poly1.coefficient(i) ~= 0
                    add_res.degree = [add_res.degree, poly1.degree(i)];
                    add_res.coefficient = [add_res.coefficient, poly1.coefficient(i)];
                end
            end
            
            for i = 1 : numel(poly2.degree)
                if poly2.coefficient(i) ~= 0
                    add_res.degree = [add_res.degree, poly2.degree(i)];
                    add_res.coefficient = [add_res.coefficient, poly2.coefficient(i)];
                end
            end            
            
            % check if add_res isempty
            if isempty(add_res.degree)
                add_res.degree = 0;
                add_res.coefficient = 0;
            end
            [add_res.degree,sort_order] = sort(add_res.degree,'descend');
            add_res.coefficient = add_res.coefficient(sort_order);
        end
        
        function mul_res = poly_mul(obj1, obj2)
             % initaialize an vector to store result
            mul_res = SparsePoly; 
            poly1 = obj1;
            poly2 = obj2;
            mul_res.degree = [];
            mul_res.coefficient = [];
            while(true)        
                if(isempty(poly1.degree))
                    break;
                end
                for i = 1 : numel(poly2.degree)
                    deg = poly1.degree(1) + poly2.degree(i);
                    coef = poly1.coefficient(1) * poly2.coefficient(i);
                    % check if deg is in res
                    % not in res
                    if(isempty(find(mul_res.degree(:) == deg, 1)) == true && coef ~= 0)
                        mul_res.degree = [mul_res.degree, deg];
                        mul_res.coefficient = [mul_res.coefficient, coef];
                    else
                        pos = find(mul_res.degree(:) == deg);
                        mul_res.coefficient(pos) =  mul_res.coefficient(pos) + coef;
                        % if the coeffcient is zero, remove from res
                        if mul_res.coefficient(pos) == 0
                            mul_res.degree = [mul_res.degree(1:pos - 1), mul_res.degree(pos + 1:end)];
                            mul_res.coefficient = [mul_res.coefficient(1:pos - 1), mul_res.coefficient(pos + 1:end)];
                        end
                    end
                end

                % remove from vector
                poly1.degree = [poly1.degree(1:0), poly1.degree(2:end)];
                poly1.coefficient = [poly1.coefficient(1:0), poly1.coefficient(2:end)];
            end
            % check if mul_res isempty
            if isempty(mul_res.degree)
                mul_res.degree = 0;
                mul_res.coefficient = 0;
            end
            [mul_res.degree,sort_order] = sort(mul_res.degree,'descend');
            mul_res.coefficient = mul_res.coefficient(sort_order);
        end
    end

end