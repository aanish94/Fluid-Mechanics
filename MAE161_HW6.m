clc; clear all; close all;

global mu Thrust Isp
Thrust = 30/1000;
Isp = 2000;
mu = 398600; %(km^3/s^2)

r1 = 6571; %(km)
v1 = sqrt(mu/r1);

r2 = 42162.8; %(km)
v2 = sqrt(mu/r2);

mo = 2000; %kg

ro = [r1 0];
vo = [0 v1];

yo = [ro vo mo];


r_cur = r1;
duration = 388000;

% while r_cur < r2
%     [T,Y] = ode45(@EP,[0 duration],yo);
%
%
%     r_cur = sqrt(Y(end,1)^2+Y(end,2)^2);
%     duration = duration + 1000;
% end
rgb = [22 147 165]./255;
rgb2 = [239 72 53]./255;

[T,Y] = ode45(@EP,[0 duration],yo);
plot(Y(:,1),Y(:,2),'color',[rgb],'LineWidth',1);

axis tight
grid off
axis square

hYLabel = ylabel('x');
hXLabel = xlabel('y');
hTitle = title('Spiral - LEO to GEO');

set( gca                       , ...
    'FontName'   , 'Helvetica' );
set([hXLabel, hYLabel,hTitle], ...
    'FontName'   , 'AvantGarde');
set([hXLabel, hYLabel,hTitle]  , ...
    'FontSize'   , 22          );

set(gca, ...
    'Box'         , 'off'     , ...
    'TickDir'     , 'out'     , ...
    'TickLength'  , [.02 .02] , ...
    'XMinorTick'  , 'on'      , ...
    'YMinorTick'  , 'on'      , ...
    'YGrid'       , 'on'      , ...
    'XColor'      , [.3 .3 .3], ...
    'YColor'      , [.3 .3 .3]);

set(gcf,'color','w');
print -painters -dpdf -r600 leo_geo.pdf
