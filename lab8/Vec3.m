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
            else
                error('Input error');
            end
        end
        
        function vec_len = norm(v)
            vec_len = sqrt(power(v.x, 2) + power(v.y, 2) + power(v.z, 2));
        end
        
        function vec_prod = inner_prod(v1, v2)
            vec_prod = v1.x * v2.x + v1.y * v2.y + v1.z * v2.z;
        end
        
        function disp(v)
            fprintf("(%d, %d, %d)\n", v.x, v.y, v.z);
        end
        
        function v = plus(v1, v2)
            v = Vec3(v1.x + v2.x, v1.y + v2.y, v1.z + v2.z);
        end
        
        function v = minus(v1, v2)
            v = Vec3(v1.x - v2.x, v1.y - v2.y, v1.z - v2.z);
        end
        
    end
            
end