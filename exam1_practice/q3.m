function ans3 = q3(w)
    x_lim = [-10 10];
    y_lim = [-10 10];
    line_1x = [w(1,1) w(1,3)];
    line_1y = [w(1,2) w(1,4)];
    
    line_2x = [w(2,1) w(2,3)];
    line_2y = [w(2,2) w(2,4)];
    
    line_3x = [w(3,1) w(3,3)];
    line_3y = [w(3,2) w(3,4)];
    
    line_4x = [w(4,1) w(4,3)];
    line_4y = [w(4,2) w(4,4)];
    
    hold on
    axis([-10 10 -10 10]);  
    ans3 = plot(line_1x, line_1y, '.');        
    plot(line_2x, line_2y, '.');   
    plot(line_3x, line_3y, '.');    
    plot(line_4x, line_4y, '.');
    if w(1,1) == w(1,3)
        plot(line_1x, y_lim);
    else
        slope1 = (w(1,4) - w(1,2)) / (w(1,3) - w(1,1));
        v1 = (x_lim - w(1,1)) * slope1 + w(1,2);
        plot(x_lim, v1);
    end    
    
    if w(2,1) == w(2,3)
        plot(line_2x, y_lim);
    else
        slope2 = (w(2,4) - w(2,2)) / (w(2,3) - w(2,1));
        v2 = (x_lim - w(2,1)) * slope2 + w(2,2);
        plot(x_lim, v2)
    end
    
    if w(3,1) == w(3,3)
        plot(line_3x, y_lim);
    else
        slope3 = (w(3,4) - w(3,2)) / (w(3,3) - w(3,1));
        v3 = (x_lim - w(3,1)) * slope3 + w(3,2);
        plot(x_lim, v3)
    end   
    
    if w(4,1) == w(4,3)
        plot(line_4x, y_lim);
    else
        slope4 = (w(4,4) - w(4,2)) / (w(4,3) - w(4,1));
        v4 = (x_lim - w(4,1)) * slope4 + w(4,2);
        plot(x_lim, v4)
    end    
    hold off
    % y - y0 = m(x - x0) 
  
end