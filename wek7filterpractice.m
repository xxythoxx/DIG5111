x = randn (1,200);
b = Hd.Numerator;
%b = Hd.Denominator
a = 1;
y = filter(b,a,x);
figure(1);
subplot(211), plot (x, 'DisplayName', 'x', 'YDataSource','x');
subplot(212), plot (y, 'DisplayName', 'x', 'YDataSource', 'y');
