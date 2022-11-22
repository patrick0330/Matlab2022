classdef Vec3
    properties
        x = 0;
        y = 0;
        z = 0;
    end
    methods
        function obj = Vec3(a, b ,c)
            if nargin == 0
                obj.x = 0;
                obj.y = 0;
                obj.z = 0;
            elseif isscalar(a) && isscalar(b) && isscalar(c)
                obj.x = a;
                obj.y = b;
                obj.z = c;
            elseif ~isscalar(a) && ~isscalar(b) && ~isscalar(c)
                obj(1, numel(a)) = Vec3;
                for i = 1:numel(a)
                    obj(i).x = a(i);
                    obj(i).y = b(i);
                    obj(i).z = c(i);
                end
                obj = reshape(obj, size(a));
                disp(obj(1));
            else
                error('Input error');
            end
        end
        
        function vec_len = norm(v)
            if numel(v) == 1
                vec_len = sqrt(power(v.x, 2) + power(v.y, 2) + power(v.z, 2));                
            else
                vec_len = zeros(1, numel(v));
                for i = 1 : numel(v)
                    vec_len(i) = sqrt(power(v(i).x, 2) + power(v(i).y, 2) + power(v(i).z, 2));
                end
            end
            vec_len = reshape(vec_len, size(v));
        end
        function vec_zero = iszero(v)
            vec_zero = zeros(1, numel(v));
            for i = 1 : numel(v)
                vec_zero(i) = v(i).x == 0 && v(i).y == 0 && v(i).z == 0;
            end
            vec_zero = reshape(vec_zero, size(v));
        end
        function vec_norm = normalize(v)
            if all(iszero(v))
                error('Zero vector detected');
            end
%             disp(size(v, 1));
%             disp(size(v, 2));
            vec_norm(size(v, 1), size(v, 2)) = Vec3;
            for i = 1 : numel(v)
                vec_norm(i).x = v(i).x / (sqrt(power(v(i).x, 2) + power(v(i).y, 2) + power(v(i).z, 2)));
                vec_norm(i).y = v(i).y / (sqrt(power(v(i).x, 2) + power(v(i).y, 2) + power(v(i).z, 2)));
                vec_norm(i).z = v(i).z / (sqrt(power(v(i).x, 2) + power(v(i).y, 2) + power(v(i).z, 2)));
            end
        end
        function vec_prod = inner_prod(v1, v2)
            vec_prod = zeros(1, numel(v1));
%             disp(size(v1));
%             disp(size(v2));
            if all(size(v1) == size(v2))         
                for i = 1 : numel(v1)
                    vec_prod(i) = v1(i).x * v2(i).x + v1(i).y * v2(i).y + v1(i).z * v2(i).z;
                end
                vec_prod = reshape(vec_prod, size(v1));
%                 fprintf("hello\n");
            elseif numel(v1) > 1 && numel(v2) == 1
                for i = 1 : numel(v1)                    
                    vec_prod(i) = v1(i).x * v2.x + v1(i).y * v2.y + v1(i).z * v2.z;
                end   
                vec_prod = reshape(vec_prod, size(v1));
            elseif numel(v1) == 1 && numel(v2) > 1
                vec_prod = zeros(1, numel(v2));
                for i = 1 : numel(v2)                    
                    vec_prod(i) = v1.x * v2(i).x + v1.y * v2(i).y + v1.z * v2(i).z;
                end 
                vec_prod = reshape(vec_prod, size(v2));
            end
        end
        function vec_prod = cross_prod(v1, v2)
            vec_prod(1, numel(v1)) = Vec3;
            if all(size(v1) == size(v2))         
                for i = 1 : numel(v1)
                    A = [v1(i).x v1(i).y v1(i).z];
                    B = [v2(i).x v2(i).y v2(i).z];
                    C = cross(A, B);
                    vec_prod(i) = Vec3(C(1), C(2), C(3));
                end            
                vec_prod = reshape(vec_prod, size(v1));
            elseif numel(v1) > 1 && numel(v2) == 1
                B = [v2.x v2.y v2.z];
                for i = 1 : numel(v1)                    
                    A = [v1(i).x v1(i).y v1(i).z];
                    C = cross(A, B);
                    vec_prod(i) = Vec3(C(1), C(2), C(3));
                end   
                vec_prod = reshape(vec_prod, size(v1));
            elseif numel(v1) == 1 && numel(v2) > 1
                vec_prod(1, numel(v2)) = Vec3;
                A = [v1.x v1.y v1.z];
                for i = 1 : numel(v2)   
                    B = [v2(i).x v2(i).y v2(i).z];
                    C = cross(A, B);
                    vec_prod(i) = Vec3(C(1), C(2), C(3));
                end 
                vec_prod = reshape(vec_prod, size(v2));
            end
        end
        function disp(v)            
            if size(v, 1) == 1 && size(v, 2) == 1
                fprintf("(%d, %d, %d)\n", v.x, v.y, v.z);
            else
                for i = 1 : size(v, 1)
                    for j = 1 : size(v, 2)
                        fprintf("(%d, %d, %d) ", v(i, j).x, v(i, j).y, v(i, j).z);
                    end
                    fprintf("\n");
                end
            end
            
        end
        
        function v = plus(v1, v2)
            v(1, numel(v1)) = Vec3;
            if all(size(v1) == size(v2))         
                for i = 1 : numel(v1)
                    v(i).x = v1(i).x + v2(i).x;
                    v(i).y = v1(i).y + v2(i).y;
                    v(i).z = v1(i).z + v2(i).z;
                end            
                v = reshape(v, size(v1));
            elseif numel(v1) > 1 && numel(v2) == 1
                for i = 1 : numel(v1)
                    v(i).x = v1(i).x + v2.x;
                    v(i).y = v1(i).y + v2.y;
                    v(i).z = v1(i).z + v2.z;
                end   
                v = reshape(v, size(v1));
            elseif numel(v1) == 1 && numel(v2) > 1
                v(1, numel(v2)) = Vec3;
                for i = 1 : numel(v2)
                    v(i).x = v1.x + v2(i).x;
                    v(i).y = v1.y + v2(i).y;
                    v(i).z = v1.z + v2(i).z;
                end
                v = reshape(v, size(v2));
            end
        end
        
        function v = minus(v1, v2)
            v(1, numel(v1)) = Vec3;
            if all(size(v1) == size(v2))         
                for i = 1 : numel(v1)
                    v(i).x = v1(i).x - v2(i).x;
                    v(i).y = v1(i).y - v2(i).y;
                    v(i).z = v1(i).z - v2(i).z;
                end   
                v = reshape(v, size(v1));
            elseif numel(v1) > 1 && numel(v2) == 1
                for i = 1 : numel(v1)
                    v(i).x = v1(i).x - v2.x;
                    v(i).y = v1(i).y - v2.y;
                    v(i).z = v1(i).z - v2.z;
                end   
                v = reshape(v, size(v1));
            elseif numel(v1) == 1 && numel(v2) > 1
                v(1, numel(v2)) = Vec3;
                for i = 1 : numel(v2)
                    v(i).x = v1.x - v2(i).x;
                    v(i).y = v1.y - v2(i).y;
                    v(i).z = v1.z - v2(i).z;
                end 
                v = reshape(v, size(v2));
            end
        end
        function v = eq(v1, v2)
            v = zeros(1, numel(v1));
            if all(size(v1) == size(v2))         
                for i = 1 : numel(v1)
                    v(i) = v1(i).x == v2(i).x && v1(i).y == v2(i).y && v1(i).z == v2(i).z;
                end   
                v = reshape(v, size(v1));
            elseif numel(v1) > 1 && numel(v2) == 1
                for i = 1 : numel(v1)
                    v(i) = v1(i).x == v2.x && v1(i).y == v2.y && v1(i).z == v2.z;
                end  
                v = reshape(v, size(v1));
            elseif numel(v1) == 1 && numel(v2) > 1
                for i = 1 : numel(v1)
                    v(i) = v1.x == v2(i).x && v1.y == v2(i).y && v1.z == v2(i).z;
                end
                v = reshape(v, size(v2));
            end
        end
        
    end
            
end