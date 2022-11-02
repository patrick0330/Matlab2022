x = 3:100; y = sin(.05*x + .002*x.^2) .* (1 - x.*x/20000);

% calculate local max 
left_compare_max = [false, y(1:end - 1) <= y(2:end)];
right_compare_max = [y(1:end - 1) >= y(2:end) false];
local_max_bool = right_compare_max & left_compare_max;
local_max_x = x(local_max_bool);
local_max_y = y(local_max_bool);

% calculate local min
left_compare_min = [false, y(1:end - 1) >= y(2:end)];
right_compare_min = [y(1:end - 1) <= y(2:end) false];
local_min_bool = right_compare_min & left_compare_min;
local_min_x = x(local_min_bool);
local_min_y = y(local_min_bool);

% calculate Monotonically increasing and Monotonically decreasing
increasing_left_end = [x(1),local_min_x];
increasing_right_end = [local_max_x x(end)];
decreasing_left_end = local_max_x;
decreasing_right_end = local_min_x;

% print result
fprintf("Local Maximums:\n");
fprintf("(%d,%.2f)\n",[local_max_x;local_max_y]);

fprintf("Local Minimums:\n");
fprintf("(%d,%.2f)\n",[local_min_x;local_min_y]);

fprintf("Monotonically increasing segments:\n");
fprintf("%d - %d\n",[increasing_left_end;increasing_right_end]);

fprintf("Monotonically decreasing segments:\n");
fprintf("%d - %d\n",[decreasing_left_end;decreasing_right_end]);

% plot result
%  3-18 38-51 63-72 81-89 97-100
% 18-38 51-63 72-81 89-97 
hold on 
plot(x,y, '-b')
plot(x,y, '.b')
plot(local_max_x, local_max_y, 'squarem')
plot(local_min_x, local_min_y, 'diamondr')
hold off
