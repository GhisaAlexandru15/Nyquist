Ghisa=readmatrix("Ghisa.csv");
t=Ghisa(3:end,1);
u=Ghisa(3:end,2);
y=Ghisa(3:end,3);

t_id=t(15:length(t));
u_id=u(15:length(t));
y_id=y(15:length(t));

t_vd=t(15:length(t));
u_vd=u(15:length(t));
y_vd=y(15:length(t));

data_id = iddata(y_id, u_id, t(2)-t(1));
data_vd = iddata(y_vd, u_vd, t(2)-t(1));

m_armax = armax(data_id, [2, 2, 2, 1])
figure(1), subplot(2,1,1), compare(data_vd, m_armax)
figure(2), subplot(2,1,1), resid(data_vd, m_armax)

m_armax_x0 = idpoly(m_armax.A, sum(m_armax.B), m_armax.C, 1, 1, 1, t(2)-t(1));
%data_vdd = iddata(y_vd(2:end), u_vd(1:end-1), t(2)-t(1));
data_vdd = iddata(y_vd(1:end), u_vd(1:end), t(2)-t(1));

figure(1), subplot(2,1,2), compare(data_vdd, m_armax_x0)
figure(2), subplot(2,1,2), resid(data_vdd, m_armax_x0)
Hd_oe=tf(m_armax);
Hc_armax=d2c(Hd_oe,'zoh')
[num,den]=tfdata(Hc_armax,'v');
Hc_armaxx0=tf(num(3),den)
%%
m_oe = oe(data_id, [2, 2, 1])
figure(1), subplot(2,1,1), compare(data_vd, m_oe)
figure(2), subplot(2,1,1), resid(data_vd, m_oe)

oe_model = idpoly(1, sum(m_oe.B), 1, 1, m_oe.F, 1, t(2)-t(1));
figure(1), subplot(2,1,2), compare(data_vdd, oe_model)
figure(2), subplot(2,1,2), resid(data_vdd, oe_model)
Hd_oe=tf(m_oe);
Hc_oe=d2c(Hd_oe,'zoh')
[num,den]=tfdata(Hc_oe,'v');
Hc_oex0=tf(num(3),den)