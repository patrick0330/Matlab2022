n = 7;
r = 2.5;
A = zeros(n);
x = [floor(n / 2): -1 : 1 0 1:floor(n / 2)];
y = x(:);
[X,Y] = meshgrid(x,y);
D = sqrt(X .^ 2 + Y .^ 2);
A = D < r;
disp(A);

n = 5;
v = [];
for i = 1:n
    if isempty(v)
        v = [v 1];
    else
        v = [v 0] + [0 v];
    end    
    disp(v);
end

v = [3 5 2 2 3 7 1];
v = sort(v);
compare_v = ([v 0] == [0 v]);
compare_v = ~compare_v;
compare_v = compare_v(1:end - 1);
% compare_v = compare_v(2:end);
v = v(compare_v);
disp(v);

