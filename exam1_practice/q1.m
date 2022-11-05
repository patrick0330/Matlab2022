function ans1 = q1(m)
    x = 1 : m;
    x1 = 1 : m;
    x2 = x1 + 1;
    x1 = 1 ./ x1;
    x2 = 1 ./ x2;
    x3 = x1 .* x2;
    y = cumsum(x3);
    ans1 = plot(x, y, "-o");
end