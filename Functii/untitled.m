t=0.1:0.001:5;
u=sin(2*pi*(2*t).^2)+3+0.05*rand(length(t),1)';
k=1;
Mr=1.2;
wn=80;
zeta=0.4;
A=[0,1;-wn^2,-2*zeta*wn];
B=[0;k*wn^2];
C=[1,0];
D=0;
sys=ss(A,B,C,D);
y=lsim(sys,u,t,[3, 0])'+0.05*rand(length(t),1)';
%%
k=mean(y)/mean(u);
[Mpi, ~, wpi]=nyquistE(t,u,y,'p'); 
wn=wpi;
zeta=k/(2*Mpi);
H=tf(k*wn^2, [1 2*zeta*wn wn^2]);
A=[0,1;-wn^2,-2*zeta*wn];
B=[0;k*wn^2];
C=[1,0];
D=0;
sys=ss(A,B,C,D);
ysim=lsim(sys,u-mean(u),t,[y(1)-mean(y), (y(2)-y(1))/(t(2)-t(1))])'+mean(y);
nyquist(H,'g');
figure
plot(t,u,t,y); hold on;
plot(t,ysim);
legend('Intrare', 'Iesire', 'Simulare')
empn=norm(y-ysim)/norm(y-mean(y))*100