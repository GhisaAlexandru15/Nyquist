Ghisa=readmatrix("Ghisa.csv");
t=Ghisa(15:end-150,1);
u=Ghisa(15:end-150,2);
y=Ghisa(15:end-150,3);
i1=77; i2=103;
Te=t(2)-t(1);
plot(t(i1:i2),y(i1:i2),'bx')
ts=t(i1):Te/10:t(i2);
ys=interp1(t(i1:i2),y(i1:i2),ts,'spline');
hold on;
plot(ts,ys,'r')
%%
figure
ts2=t(1):Te/10:t(end);
ys2=interp1(t,y,ts2,'spline');
us2=interp1(t,u,ts2,'spline');
hold on;
plot(t,y,'bx')
plot(ts2,ys2,'r')
