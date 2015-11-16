function dy = EP(t,RV)
% y = [x y vx vy m]
global mu Thrust Isp
x = RV(1);
y = RV(2);

vx = RV(3);
vy = RV(4);

m = RV(5);

dy = zeros(5,1);


g = 9.8/1000; %m/s^2

r = sqrt(x^2 + y^2);
v = sqrt(vx^2 + vy^2);

dy(1) = vx;
dy(2) = vy;

dy(3) = -(mu/(r^3))*x+(Thrust/m)*(vx/v);
dy(4) = -(mu/(r^3))*y+(Thrust/m)*(vy/v);

dy(5) = -(Thrust/(g*Isp));

