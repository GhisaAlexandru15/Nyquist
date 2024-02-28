Ghisa=readmatrix("Ghisa.csv");
t=Ghisa(3:end,1);
u=Ghisa(3:end,2);
y=Ghisa(3:end,4);
%%
addpath(genpath("Functii"))
nyquistE(t,u,y,'r');
%%
Mr= 1.4517
phir=-42.31*pi/180;
wr=23947.83;
k=mean(y)/mean(u);
zeta=abs(fsolve(@(z)ecuatiiD(z, Mr, phir, k), 0.5));
Mr2=1/(2*zeta*sqrt(1-zeta^2));
wn=wr/(sqrt(1-2*zeta^2));
Tz=sqrt(Mr^2/(k*Mr2)^2-1)/wr;
H=tf(k*wn^2*[Tz 1], [1 2*zeta*wn wn^2]);
[num, den]=tfdata(H,'v');
[A_FCC, B_FCC, C_FCC, D]= tf2ss(num,den);
A_FCO=A_FCC';
B_FCO=C_FCC';
C_FCO=B_FCC';
sys_FCO = ss(A_FCO, B_FCO, C_FCO, D);
ysim=lsim(sys_FCO,u(2:end)-mean(u),t(2:end),[y(2)-mean(y), ((y(3)-y(1))/(t(3)-t(1))-A_FCO(1,1)*(y(2)-mean(y))-B_FCO(1)*(u(2)-mean(u)))/A_FCO(1,2)]);
ysim=ysim+mean(y);
figure
plot(t,u,t,y);
hold on;
plot(t(2:end),ysim);
empn=norm(y(2:end)-ysim)/norm(y(2:end)-mean(y))*100