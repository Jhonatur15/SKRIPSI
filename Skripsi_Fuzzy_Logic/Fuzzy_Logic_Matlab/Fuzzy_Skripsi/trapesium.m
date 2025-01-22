function y = trapesium(x,a,b,c,d)
% creator: Jhonatur Stheven S
% email: jhonatur15@students.unnes.ac.id
% date: 27/11/2023
if or(or(a>b,b>c),c>d)
    error('Ingat bahwa a<=b, b<=c, c<=d');
elseif or(b>c, b>d)
    error('Ingat bahwa a<=b, b<=c, c<=d');
end
% nilai default
y = zeros(size(x));
for i=1:length(y)
    if or(x(i)<=a, x(i)>=d)
        y(i)=0;
    end
    if ((a~=b)&& (a<x(i) && x(i)<b))% lereng kiri trapesium
        y(i)= (x(i)-a)/(b-a);
    end
    if (b<=x(i) && x(i)<=c)% di tengah trapesium
        y(i)= 1;
    end
    if (d~=c)&&(c<x(i) && x(i)<d)% lereng kanan trapesium
        y(i)= (d-x(i))/(d-c);
    end
end