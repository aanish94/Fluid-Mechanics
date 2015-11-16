% MAE 150A: Homework #6
% Aanish Patel Sikora
% 804028077

clc; close all; clear all;

%%%%%%%%%%%%%%%%%%%%%%% OPTIONAL QUESTION #6 %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Numerical Integration of Falkner-Skan Equation
% Obtain Velocity Profile of laminar boundary layer over flat plate

% ODE-> f''' + f * f'' + beta * (1-f'^2) = 0
% B.C: f'(0) = f(0) = 0 && f'(inf) = 1

% g = df/dn & h = dg/dn
% System of ODE -> g = f' & h = g' = f'' & h' = -f*h - beta*(1-g^2)
% B.C: g(0) = f(0) = 0 & h(0) = ? such that g(inf) = 1

global beta
m = 0;
% m = 0 => Blasius Solution
% 0 < m < 1 => wedge with angle < 180
% 1 < m < 2 => wedge with angle > 180
beta = (2*m)/(m+1);

% Range of eta such that max eta can be considered infinity
eta = [0 5];

% Begin Shooting Method by guessing f''(0)
a(1) = 1;
init = [0 0 a(1)]; % [f(0) f'(0) f''(0)]

% Solve ODE with f''(0) guess
[x,y] = ode45(@Falkner_Skan_Solver,eta,init); % y = [f f' f'']
% Check if f'(inf) == 1 is satisfied (unlikely)
fdot(1) = y(end,2);

if abs(fdot(1) - 1) < 0.001
    disp('Spectacular Guess!')
end
% We will probably have over or undershot f'(0) == 1. So we need a better
% guess for f''(0). Use SECANT METHOD.

%Second Guess
i = 2;
a(i) = 2;
while abs(a(i)-a(i-1))>0.000001 % Arbitrary Tolerance
    % Repeat above steps
    init = [0 0 a(i)];
    [x,y] = ode45(@Falkner_Skan_Solver,eta,init);
    fdot(i) = y(end,2);
    
    if abs(fdot(i) - 1) < 0.001
        % This is the correct value --> f''(0) = a(i)
    end
    
    % Adjust f''(0) guess using Secant Method
    a(i+1) = a(i) - ((a(i)-a(i-1))/(fdot(i)-fdot(i-1)))*(fdot(i)-1);
    
    i = i+1;
end

% For f''(0) = a(i) --> f'(inf) = 1
% y = [f f' f''] is solution
% u/Ue = f'

% plot(x,y(:,2))

ysize = size(y(:,2));
eta = linspace(0,5,ysize(1));
eta = eta';
plot(y(:,2),eta)

hold on