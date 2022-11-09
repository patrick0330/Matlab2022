function P2(v)
    s = textscan(v, '%s', 'delimiter', ',. ');
    word = s{1};
%     disp(class(string(word{1})));
    word_count = [];
    for i = 1:numel(word)
        A(i).word = word{i};
        A(i).len = strlength(word{i});      
        if isempty(find(word_count(:) == strlength(word{i}), 1))
            word_count = [word_count ; strlength(word{i})];
        end
    end
    word_count = sort(word_count);
    for i = 1 : numel(word_count)
        fprintf("len=%d ", word_count(i));
        for j = 1 : numel(A)
            if A(j).len == word_count(i)
                fprintf("%s ", A(j).word);
            end
        end
        fprintf("\n");
    end
end