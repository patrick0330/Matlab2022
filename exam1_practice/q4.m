function q4(im, v)
    a = imread(im);
    a = im2double(a);
    if v(3) < v(1) || v(4) < v(2) || v(1) > 360 || v(2) > 240
        imwrite(a, "output.jpg");
    elseif v(4) > 240 || v(3) > 360
        if v(4) > 240
            v(4) = 240;
        end
        if v(3) > 360
            v(3) = 360;
        end
        a(v(2):v(4), v(1):v(3), :) = 1 - a(v(2):v(4), v(1):v(3), :);
        imwrite(a, "output.jpg");
    else        
        a(v(2):v(4), v(1):v(3), :) = 1 - a(v(2):v(4), v(1):v(3), :);
        imwrite(a, "output.jpg");
    end
    image(a);
end