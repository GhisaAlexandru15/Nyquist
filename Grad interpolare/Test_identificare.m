function [empn, empn1p, empn2] = Test_identificare(fisier, grad)  
    Ghisa=readmatrix(fisier+".csv");
    t=Ghisa(3:end,1);
    u=Ghisa(3:end,2);
    y=Ghisa(3:end,3);
    [Mr, ~, wr]=Test_nyquistE(t,u,y, 'r',grad); 
    k=mean(y)/mean(u);
    zeta=min(sqrt(roots([-4*Mr^2, 4*Mr^2, -1])));
    wn=wr/(sqrt(1-2*zeta^2));
    H=tf(k*wn^2, [1 2*zeta*wn wn^2]);
    A=[0,1;-wn^2,-2*zeta*wn];
    B=[0;k*wn^2];
    C=[1,0];
    D=0;
    sys=ss(A,B,C,D);
    ysim=lsim(sys,u-mean(u),t,[y(1)-mean(y), (y(2)-y(1))/(t(2)-t(1))])+mean(y);
    %nyquist(H,'g');
    %figure
    %plot(t,u,t,y); hold on;
    %plot(t,ysim);
    p=1;
    empn=norm(y(p:end)-ysim(p:end))/norm(y(p:end)-mean(y))*100;
    %%
    [Mpi, ~, wpi]=Test_nyquistE(t,u,y,'p',grad); 
    k=mean(y)/mean(u);
    wn=wpi;
    zeta=k/(2*Mpi)
    H=tf(k*wn^2, [1 2*zeta*wn wn^2]);
    A=[0,1;-wn^2,-2*zeta*wn];
    B=[0;k*wn^2];
    C=[1,0];
    D=0;
    sys=ss(A,B,C,D);
    ysim=lsim(sys,u-mean(u),t,[y(1)-mean(y), (y(2)-y(1))/(t(2)-t(1))])+mean(y);
    %nyquist(H,'g');
    %figure
    %plot(t,u,t,y); hold on;
    %plot(t,ysim);
    p=1;
    empn1p=norm(y(p:end)-ysim(p:end))/norm(y(p:end)-mean(y))*100;
    %%
    y=Ghisa(3:end,4);
    [Mr, phir, wr]=Test_nyquistE(t,u,y,'r',grad);
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
    ysim=lsim(sys_FCO,u,t,[y(1), ((y(2)-y(1))/(t(2)-t(1))-A_FCO(1,1)*(y(1))-B_FCO(1)*(u(1)))/A_FCO(1,2)]);
    %nyquist(H,'g')
    %figure;
    %plot(t,u,t,y); hold on;
    %plot(t,ysim);
    H=zpk(H);
    empn2=norm(y(p:end)-ysim(p:end))/norm(y(p:end)-mean(y))*100;
end

