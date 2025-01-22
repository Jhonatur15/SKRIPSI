function y = segitiga(x,a,b,c)
% creator: Jhonatur Stheven S
% email: jhonatur15@students.unnes.ac.id
% date: 27/11/2023
if or(a>b,a>c)
    error('Ingat bahwa a<=b, b<=c');
elseif b>c
    error('Ingat bahwa a<=b, b<=c');
end
% nilai default
y = zeros(size(x));
for i=1:length(y)
    if or(x(i)<=a, x(i)>=c)
        y(i)=0;
    end
    if ((a~=b)&& (a<x(i) && x(i)<b))% lereng kiri segitiga
        y(i)= (x(i)-a)/(b-a);
    end
    if x(i)==b% di tengah segitiga
        y(i)= 1;
    end
    if (b~=c)&&(b<x(i) && x(i)<c)% lereng kanan segitiga
        y(i)= (c-x(i))/(c-b);
    end
end