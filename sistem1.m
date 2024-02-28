Ghisa=readmatrix("Ghisa.csv");
t=Ghisa(3:end,1);
u=Ghisa(3:end,2);
y=Ghisa(3:end,3);
%%
addpath(genpath("Functii"))
nyquistE(t,u,y,'r');
%%
figure,plot(t,u,t,y);
hold on;
k=mean(y)/mean(u);
Mr=1.2703;
wr=22244.72;
zeta=min(sqrt(roots([-4*Mr^2, 4*Mr^2, -1])));
wn=wr/(sqrt(1-2*zeta^2));
A=[0,1;-wn^2,-2*zeta*wn];
B=[0;k*wn^2];
C=[1,0];
D=0;
sys=ss(A,B,C,D);
ysim=lsim(sys,u-mean(u),t,[y(1)-mean(y), (y(2)-y(1))/(t(2)-t(1))])+mean(y);
plot(t,ysim)
empn=norm(y-ysim)/norm(y-mean(y))*100


