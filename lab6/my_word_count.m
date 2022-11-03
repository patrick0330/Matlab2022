function [word, count] = my_word_count(fn)
    fid = fopen(fn,'rt');
    s = textscan(fid, '%s', 'delimiter', ',. ');
    a = s{1};
    fclose(fid);
    a = lower(a);
    word = unique(a);
    for i = 1:numel(word)
        check = strcmp(word{i}, a);
        count(i) = sum(check);       
    end
    [count, idx] = sort(count, 'descend');
%     fprintf("%s ", word{:});
%     fprintf("\n");
    word = word(idx);
%     fprintf("%s ", word{:});
    if(nargout == 0)
        for i = 1:numel(word)
            fprintf("%s %d\n", word{i}, count(i));
        end
    end
    
%     fprintf("%s\n",word{1:end});
end
