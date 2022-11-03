n=100; [x,y]=meshgrid(-n:2:n,-n:2:n); % the grid points
z1=sin((x-.002*x.*x)/n*5).^2+1;
z2=sin((x+2*y)/n*2).^2+.5;
t1=80; w1=t1*t1./((x-20).^2+(y-40).^2+t1*t1);
z=z1.*z2.*w1*1000+rand(size(z1))*.1; % values of the grid points

left_compare = [false(101,1) z(:,1:end - 1) < z(:,2:end)];
right_compare = [z(:,1:end - 1) > z(:,2:end) false(101,1)];
up_compare = [false(1,101); z(1:end - 1,:) < z(2:end,:)];
down_compare = [z(1:end - 1,:) > z(2:end,:);false(1,101)];

rd_dia_compare = [z(1:end - 1,1:end - 1) > z(2:end, 2:end) false(100,1)];
rd_dia_compare = [rd_dia_compare ; false(1,101)];
lu_dia_compare = [false(100,1) z(1:end - 1,1:end - 1) < z(2:end, 2:end)];
lu_dia_compare = [false(1,101) ; lu_dia_compare];
ru_dia_compare = [z(2:end,1:end - 1) > z(1:end - 1,2:end) false(100,1)];
ru_dia_compare = [false(1,101);ru_dia_compare];
ld_dia_compare = [false(100,1) z(2:end,1:end - 1) < z(1:end - 1,2:end)];
ld_dia_compare = [ld_dia_compare;false(1,101)];
result = up_compare & down_compare & left_compare & right_compare & rd_dia_compare & ru_dia_compare & ld_dia_compare & lu_dia_compare;

subplot(1,3,1)
contour(x,y,z)
local_max = num2str(round(z(result)));
text(x(result),y(result),local_max)
subplot(1,3,2)
surf(x,y,z)
text(x(result),y(result),z(result),local_max);
subplot(1,3,3)
mesh(x,y,z)
text(x(result),y(result),z(result),local_max);