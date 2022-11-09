function [vec_gcd, vec_lcm] = P4(v)
    validateattributes(v, {'numeric'}, {'nonzero'});
    v = abs(v);
    v1 = v;
    if isempty(v)
        vec_gcd = v;
        vec_lcm = v;
    else
        while numel(v1) > 1
            g = gcd_recursion(v1(1), v1(2));
            v1 = v1(3:end); 
            v1 = [v1 g];
        end
        vec_gcd = v1(1);
        vec_lcm = lcm_compute(v);
    end
end

function [a, b] = max_and_min(x, y)
    if nargin == 2
        a = max(x, y);
        b = min(x, y);
    else % nargin == 1
        a = max(x(:));
        b = min(x(:));
    end
end
function g = gcd_recursion(a, b)
    [a1, b1] = max_and_min(a, b);
    if b1 == 0
        g = a1; 
        return;
    end
    g = gcd_recursion(b1, mod(a1,b1));
end

function l = lcm_compute(v)
    mul = [];
    for i = 1 : numel(v) - 1
        for j = i + 1 : numel(v)
            g = gcd_recursion(v(i), v(j));
            for k = 1 : numel(v)
                if mod(v(k),g) == 0
                    v(k) = v(k) / g;
                end
            end
            mul = [mul g];
        end
    end
    l = prod(mul) * prod(v);
end



