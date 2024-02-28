Ghisa=readmatrix("Ghisa"+".csv");
t=Ghisa(3:end,1);
u=Ghisa(3:end,2);
y=Ghisa(3:end,4);

%%
t_id=t(15:length(t));
u_id=u(15:length(t));
y_id=y(15:length(t));

t_vd=t(15:length(t));
u_vd=u(15:length(t));
y_vd=y(15:length(t));

data_id = iddata(y_id, u_id, t(2)-t(1));
data_vd = iddata(y_vd, u_vd, t(2)-t(1));

m_arx = armax(data_id, [2, 2, 5, 1])
figure, compare(data_vd, m_arx)
figure, resid(data_vd, m_arx)


Hd_arx=tf(m_arx)
zpk(Hd_arx)
Hc_arx=d2c(Hd_arx, 'zoh')
%%
m_iv4 = oe(data_id, [2, 2, 1])
figure, compare(data_vd, m_iv4)
figure, resid(data_vd, m_iv4)
Hd_iv4=tf(m_iv4);
Hc_iv4=d2c(Hd_iv4, 'zoh')