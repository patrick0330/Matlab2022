function ans3 = P3(vx, vy, vz)
    validateattributes(vx,{'numeric'},{'scalar'});
    validateattributes(vy,{'numeric'},{'scalar'});
    validateattributes(vz,{'numeric'},{'scalar'});
    g = 9.8;
    t = 2 * vz / g;
    tt = 0:t / 99:t;
    disp(tt);
    px = vx .* tt;
    py = vy .* tt;
    pz = vz .* tt - 0.5 * g .* power(tt, 2);
    hold on
    view(45, 45);
    ans3 = plot3(px, py, pz);
    plot3(px, py, zeros(1,100));
    hold off
end
