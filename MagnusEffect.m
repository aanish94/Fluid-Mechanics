clc; clear all; close all;

% MAE 150A: Homework #4
% Aanish Patel Sikora
% 804028077

%%%%%%%%%%%%%%%%%%%%%%% OPTIONAL QUESTION #6 %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%% Uniform Flow + Doublet + Potential Vortex


%%%%%%%%%%%%%%%%%%%%%%% Initialize Problem Variables %%%%%%%%%%%%%%%%%%%%%%
R = 1.5;   % Radius
U_inf = 1.5; % Free-stream Velocity
T = 0.5*4*pi; % Circulation

% Case 1: T < 4*pi*U*R
% Case 2: T = 4*pi*U*R
% Case 3: T > 4*pi*U*R

tht_s = asind((T)/(4*pi*U_inf*R)); % Stagnation Point Angle
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Custom Colors
rgb = [22 147 165]./255;
rgb2 = [239 72 53]./255;

%Function Used to draw Arrow
drawArrow = @(x,y,props) quiver( x(1),y(1),x(2)-x(1),y(2)-y(1),0, props{:});

% Define Grid
c = -R*2;
b = R*2;
n = R*500;
[x,y] = meshgrid(c:(b-c)/n:b,c:(b-c)/n:b);

% No Flow in circle of Radius R
for i=1:length(x);
    for k=1:length(x);
        if sqrt(x(i,k).^2+y(i,k).^2)<R;
            x(i,k)=0;
            y(i,k)=0;
        end
    end
end

% Convert (X,Y) To Polar
r_var = sqrt(x.^2+y.^2);
tht_var = atan2(y,x);

% Defition of StreamFunction
phi = U_inf.*sin(tht_var).*r_var.*(1-(R^2./(r_var.^2)))-T*log(r_var./R)/(2*pi);

%%%%%%%%%%%%%%%%%%%%%%% Plotting StreamFunction %%%%%%%%%%%%%%%%%%%%%%
h = contour(x,y,phi,50);
hold on

% Defition of dividing streamlines (phi = 0)
tht_vec = linspace(0,2*pi,500);
count = 1;
for rr = linspace(R,R*2,500)
    tht_temp = asin((T*log(rr/R)/(2*pi))/(U_inf*rr*(1-(R^2/(rr^2)))));
    x_div(count) = rr*cos(tht_temp);
    y_div(count) = rr*sin(tht_temp);
    
    count = count + 1;
end

%%%%%%%%%%%%%%%%%%%%%% Plotting Dividing Streamlines %%%%%%%%%%%%%%%%%%%%%%
plot(x_div,y_div,'color','k','LineWidth',3)
plot(-x_div,y_div,'k','LineWidth',3)

inc = 1; %Plotting Circle of Radius R
for tt = tht_vec
    x_circ(inc) = R*cos(tt);
    y_circ(inc) = R*sin(tt);
    inc = inc + 1;
end
plot(x_circ,y_circ,'k','LineWidth',3)

%%%%%%%%%%%%%%%%%%%%%%%%% Drawing Arrows on dividing Streamlines
hold on
x1 = [x_div(200) x_div(300)];
y1 = [y_div(200) y_div(300)];

hold on
x2 = [-x_div(300) -x_div(200)];
y2 = [y_div(300) y_div(200)];

if T <= 4*pi
    drawArrow(x1,y1,{'linewidth',2,'color',[rgb2],'MaxHeadSize',0.1/norm(x_div)});
end
drawArrow(x2,y2,{'linewidth',2,'color',[rgb2],'MaxHeadSize',0.1/norm(x_div)});

%%%%%%%%%%%%%%%%%%%%%%%%% Drawing Arrows on Circle of Radius R
x3 = [x_circ(381) x_circ(391)];
y3 = [y_circ(381) y_circ(391)];

x4 = [x_circ(381) x_circ(391)];
y4 = [-y_circ(381) -y_circ(391)];
hold on

if T < 4*pi
    drawArrow(x4,y4,{'linewidth',2,'color',[rgb2],'MaxHeadSize',0.1/norm(x_div)});
end
drawArrow(x3,y3,{'linewidth',2,'color',[rgb2],'MaxHeadSize',0.1/norm(x_div)});

%%%%%%%%%%%%%%%%%%%%%%%%% Calculating Velocity
u_r = U_inf*cos(tht_var).*(1-R^2./(r_var.^2));
u_t = -U_inf*sin(tht_var).*(1+R^2./(r_var.^2))+T./(2*pi*r_var);
%
u=u_r.*cos(tht_var)-u_t.*sin(tht_var);
v=u_r.*sin(tht_var)+u_t.*cos(tht_var);

%%%%%%%%%%%%%%%%%%%%%%%%% Plotting Arrows at Points on flow field
hold on

st = 50;
en = 100;
x_q = x([st en],[st en]);
y_q = y([st en],[st en]);
u_q = u([st en],[st en]);
v_q = v([st en],[st en]);
quiver(x_q,y_q,u_q,v_q,'linewidth',2,'color',[rgb2],'MaxHeadSize',0.1/norm(x_div))

st = 600;
en = 650;
sizex = size(x);
if st < sizex(1) && en < sizex(2)   
    x_q = x([st en],[st en]);
    y_q = y([st en],[st en]);
    u_q = u([st en],[st en]);
    v_q = v([st en],[st en]);
    quiver(x_q,y_q,u_q,v_q,'linewidth',2,'color',[rgb2],'MaxHeadSize',0.1/norm(x_div))
end
%%%%%%%%%%%%%%%%%%%%%%%%% Mark Stagnation Point

%Stagnation Points (u_r = u_t = 0)
stagx = R*cosd(tht_s);
stagy = R*sind(tht_s);

plot(stagx,stagy,'ok','MarkerSize',8,'MarkerFaceColor',rgb2)
plot(-stagx,stagy,'ok','MarkerSize',8,'MarkerFaceColor',rgb2)

%%%%%%%%%%%%%%%%%%%%%%%% Format Plot %%%%%%%%%%%%%%%%%%%%%%%%%%%
grid off
axis square

hYLabel = ylabel('y','Interpreter','LaTex');
hXLabel = xlabel('x','Interpreter','LaTex');
if T < 4*pi*U_inf*R
    hTitle = title('${\psi}: \frac{{\tau}}{UR} < 4{\pi}$');
elseif  T == 4*pi*U_inf*R
    hTitle = title('${\psi}: \frac{{\tau}}{UR} = 4{\pi}$');
else
    hTitle = title('${\psi}: \frac{{\tau}}{UR} > 4{\pi}$');
end

set(hTitle,'Interpreter','Latex');

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
print -painters -dpdf -r600 optional1.pdf



