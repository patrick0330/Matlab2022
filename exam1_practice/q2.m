function ans2 = q2(n)
    v = [0 : floor(n / 2) - 1  floor(n / 2) floor(n / 2) - 1: -1 :0];
    v1 = repmat(v, n, 1);
    v2 = repmat(v(:), 1, n);
    v3 = min(v1, v2);
   	ans2 = v3;
end