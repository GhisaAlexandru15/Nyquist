function [] = identificare(fisier)  
    clc
    close all
    Ghisa=readmatrix(fisier+".csv");
    t=Ghisa(3:end,1);
    u=Ghisa(3:end,2);
    y=Ghisa(3:end,3);
    z=Ghisa(3:end,4);
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
    ysim=lsim(sys,u-mean(u),t,[y(1)-mean(y), (y(2)-y(1))/(t(2)-t(1))])+mean(y);
    nyquist(H,'g');
    figure
    plot(t,u,t,y); hold on;
    plot(t,ysim);
    legend('Intrare', 'Iesire', 'Simulare')
    empn=norm(y-ysim)/norm(y-mean(y))*100
    %%
    k=mean(z)/mean(u);
    [Mr, phir, wr]=nyquistE(t,u,z,'r');
    opts = optimset('Diagnostics','off', 'Display','off');
    zeta=abs(fsolve(@(ze)ecuatiiD(ze, Mr, phir, k), 0.5, opts));
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
    zsim=lsim(sys_FCO,u,t,[z(1), ((z(2)-z(1))/(t(2)-t(1))-A_FCO(1,1)*(z(1))-B_FCO(1)*(u(1)))/A_FCO(1,2)]);
    nyquist(H,'g')
    figure
    plot(t,u,t,z); hold on;
    plot(t,zsim);
    legend('Intrare', 'Iesire', 'Simulare')
    H=zpk(H)
    eroare=norm(z-zsim)/norm(z-mean(z))*100
end