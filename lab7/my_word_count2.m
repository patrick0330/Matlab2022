function A = my_word_count2(fn, sort_mode)
    fid = fopen(fn,'rt');
    s = textscan(fid, '%s', 'delimiter', ',. ');
    a = s{1};
    fclose(fid);
    a = lower(a);
    word = unique(a);
    for i = 1:numel(word)
        check = strcmp(word{i}, a);
        A(i).word = word{i};
        A(i).len = strlength(word{i});        
        A(i).count = sum(check);     
    end
    switch sort_mode
        case 'word+'
            T = struct2table(A);
            sortedT = sortrows(T, 'word');
            A = table2struct(sortedT);            
        case 'word-'
            T = struct2table(A);
            sortedT = sortrows(T, 'word', 'descend');
            A = table2struct(sortedT);  
        case 'len+'
            T = struct2table(A);
            sortedT = sortrows(T, 'len');
            A = table2struct(sortedT);  
        case 'len-'
            T = struct2table(A);
            sortedT = sortrows(T, 'len', 'descend');
            A = table2struct(sortedT);  
        case 'count+'
            T = struct2table(A);
            sortedT = sortrows(T, 'count');
            A = table2struct(sortedT);  
        case 'count-'
            T = struct2table(A);
            sortedT = sortrows(T, 'count', 'descend');
            A = table2struct(sortedT);  
        otherwise
            error('Unknown Command');
    end
    
    if(nargout == 0)
        for i = 1:numel(A)
            disp(A(i));
        end
    end
    
end