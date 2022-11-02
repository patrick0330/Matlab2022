v = [3 7 5 2];
fprintf("%d/%d+%d/%d=%d/%d\n", v(1), v(2), v(3), v(4), v(4) * v(1) + v(2) * v(3), v(2) * v(4));

ans1 = 1:1000;
ans1 = 1 ./ ans1;
ans1 = sum(ans1);
disp(ans1);

ans2 = cumprod(1:100);
ans2 = 1 ./ ans2;
ans2 = sum(ans2);
ans2 = ans2 + 1;
disp(ans2);
disp(exp(1));

n = 5;

ans3 = zeros(n);
ans3(:, 1) = 1;
ans3(1, :) = 1;
ans3(:, end) = 1;
ans3(end, :) = 1;
disp(ans3);

ans4 = zeros(n);
ans4(1:n + 1:end) = 1:5;
disp(ans4);

x = 1:3;
y = 1:5;
X = repmat(x, numel(y), 1);
Y = repmat(y(:), 1, numel(x));
disp(X);
disp(Y);