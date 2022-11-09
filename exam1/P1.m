function P1(n)
    validateattributes(n , {'numeric'}, {'positive'});
    if n ~= round(n)
        error('input n should be an integer');
    end
    counter = [1 0 ; 2 0 ; 3 0 ; 4 0 ; 5 0 ; 6 0];
    percent = [0 0 0 0 0 0];
    rand_num = mod(round(rand() * 10), 6) + 1;
    for i = 1: n
        rand_num = mod(round(rand() * 10), 6) + 1;
        counter(rand_num, 2) = counter(rand_num, 2) + 1;
    end
    disp(counter);
    percent(:) = counter(:, 2) ./ n;
    
    fprintf("%d count= %d (%.2f)\n", counter(1, 1), counter(1, 2), percent(1));
    fprintf("%d count= %d (%.2f)\n", counter(2, 1), counter(2, 2), percent(2));
    fprintf("%d count= %d (%.2f)\n", counter(3, 1), counter(3, 2), percent(3));
    fprintf("%d count= %d (%.2f)\n", counter(4, 1), counter(4, 2), percent(4));
    fprintf("%d count= %d (%.2f)\n", counter(5, 1), counter(5, 2), percent(5));
    fprintf("%d count= %d (%.2f)\n", counter(6, 1), counter(6, 2), percent(6));
end