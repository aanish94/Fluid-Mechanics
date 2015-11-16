function f = Falkner_Skan_Solver(x,fo)

%f = [f f' f'']
%g = df/dn
%h = dg/dn

global beta

f(1,1) = fo(2); %g = f'
f(2,1) = fo(3); %h = g' = f''
f(3,1) = -fo(1)*fo(3) - beta*(1-fo(2)^2); %h' = -f*h - beta(1-g^2)

end
