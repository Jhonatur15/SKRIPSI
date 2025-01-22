function [x1,x2]= isegitiga(y, a, b, c)
    % creator: Jhonatur Stheven S
    % email: jhonatur15@students.unnes.ac.id
    % date: 12/08/2023
if or(a>b,a>c)
    error('Ingat bahwa a<=b, b<=c');
elseif b>c
    error('Ingat bahwa a<=b, b<=c');
end
% Invers segitiga
x1 = ((b-a)*y)+a; % lereng kiri segitiga
x2 = c-(y*(c-b)); % lereng kanan segitiga 

if y==1
    x1 = a;
    x2 = b;
end
