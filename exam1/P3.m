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
    pz = vy .* tt - 0.5 * g .* power(tt, 2);
    hold on
    ans3 = plot(tt, px);
    plot(tt, py);
    plot(tt, pz);
    hold off
end