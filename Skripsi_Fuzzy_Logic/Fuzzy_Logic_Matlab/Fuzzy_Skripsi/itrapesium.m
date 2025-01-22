function [x1,x2] = itrapesium(y,a,b,c,d)
% creator: Jhonatur Stheven S
% email: jhonatur15@students.unnes.ac.id
% date: 27/11/2023
if or(or(a>b,a>c),a>d)
    error('Ingat bahwa a<=b, b<=c, c<=d');
elseif or(b>c, b>d)
    error('Ingat bahwa a<=b, b<=c, c<=d');
end
% Invers trapesium
x1 = ((b-a)*y)+a; % lereng kiri trapesium
x2 = d-(y*(d-c)); % lereng kanan trapesium 

if y==1
    x1 = b;
    x2 = c;
end
    