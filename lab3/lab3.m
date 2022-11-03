xi = -10:2:10; yi = -.03*xi.^2 + .1*xi + 2 + 1*(rand(1,length(xi))-.5);
new_xi = xi(:);
for i = 1:2
    new_xi(:,i) = xi.^(i - 1);
end
ans1 = new_xi \ yi(:);
y = new_xi * ans1;
subplot(1,3,1);
hold on
plot(new_xi(:,2),y)
plot(xi,yi,'o')
for i = 1:11
    plot([new_xi(i,2),xi(i)],[y(i),yi(i)]);
end
title('Polynomial deg = 1')
y_d = y - yi(:);
y_d = y_d .^2;
rms = sqrt(sum(y_d)/11);
rms_d1 = sprintf('rms = %f',rms);
text(4,0,rms_d1);
hold off


new_xi = xi(:);
for i = 1:3
    new_xi(:,i) = xi.^(i - 1);
end
ans2 = new_xi \ yi(:);
y = new_xi * ans2;
subplot(1,3,2)
hold on
plot(new_xi(:,2),y)
plot(xi,yi,'o')
for i = 1:11
plot([new_xi(i,2),xi(i)],[y(i),yi(i)])
end
title('Polynomial deg = 2')
y_d = y - yi(:);
y_d = y_d .^2;
rms = sqrt(sum(y_d)/11);
rms_d2 = sprintf('rms = %f',rms);
text(4,0,rms_d2)
hold off

new_xi = xi(:);
for i = 1:4
new_xi(:,i) = xi.^(i - 1);
end
ans3 = new_xi \ yi(:);
y = new_xi * ans3;
subplot(1,3,3)
hold on
plot(new_xi(:,2),y)
plot(xi,yi,'o')
for i = 1:11
plot([new_xi(i,2),xi(i)],[y(i),yi(i)])
end
title('Polynomial deg = 3')
y_d = y - yi(:);
y_d = y_d .^2;
rms = sqrt(sum(y_d)/11);
rms_d3 = sprintf('rms = %f',rms);
text(4,0,rms_d3)
hold off