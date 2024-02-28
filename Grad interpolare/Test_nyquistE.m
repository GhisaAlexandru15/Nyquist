function [modul_max, faza_max, omega_max] = Test_nyquistE(timp, intrare, iesire,metoda, grad)
    warning ('off','all');
    t=timp(15:end-150);
    u=intrare(15:end-150);
    y=iesire(15:end-150);
    trecere0u=trecere0(t,u);
    trecere0y=trecere0(t,y);
    if(trecere0u(1)-trecere0y(1)>10*(t(2)-t(1)))
        trecere0y=trecere0y(2:end);
    end
    extremeu=extreme(t,u,trecere0u);
    extremey=extreme(t,y,trecere0y);
    [modul, faza] = modulfaza(trecere0u, extremeu, trecere0y, extremey);

    %%%figure('NumberTitle', 'off', 'Name', 'Modul+Fază');
    %plot(1:length(modul), modul, 'xr', 1:length(faza),faza, 'xr'); 
    hold on;
    
    grad_polinom=grad;
    coefficients = polyfit(1:length(modul), modul, grad_polinom);
    x_finer = linspace(1, length(modul), 1000);
    modul_fitted = polyval(coefficients, x_finer);
    coefficients = polyfit(1:length(faza), faza, grad_polinom);
    x_finer = linspace(1, length(faza), 1000);
    faza_fitted = polyval(coefficients, x_finer);

    %plot(linspace(1,length(modul), 1000), modul_fitted, 'b')
    %plot(linspace(1,length(faza), 1000), faza_fitted, 'g')

    omega=zeros(length(modul),1);
    for i=1:length(modul)
        omega(i)=pi/(trecere0u(i+1)-trecere0u(i));
    end

    coefficients = polyfit(1:length(omega), omega, grad_polinom);
    x_finer = linspace(1, length(omega), 1000);
    omega_fitted = polyval(coefficients, x_finer); 

    re_fitted=zeros(length(modul_fitted));
    im_fitted=zeros(length(modul_fitted));
    maxim=max(modul_fitted);
     if metoda=='r'
    for i=1:length(modul_fitted)
        re_fitted(i)=modul_fitted(i)*cos(faza_fitted(i));
        im_fitted(i)=modul_fitted(i)*sin(faza_fitted(i));
        if(modul_fitted(i)==maxim)
            re_max=re_fitted(i);
            im_max=im_fitted(i);
            omega_max=omega_fitted(i);
            modul_max=modul_fitted(i);
            faza_max=faza_fitted(i);
        end
    end
    elseif metoda=='p'
        for i=1:length(modul_fitted)
        re_fitted(i)=modul_fitted(i)*cos(faza_fitted(i));
        im_fitted(i)=modul_fitted(i)*sin(faza_fitted(i));
        if(re_fitted(i)>0)
            re_max=re_fitted(i);
            im_max=im_fitted(i);
            omega_max=omega_fitted(i);
            modul_max=modul_fitted(i);
            faza_max=faza_fitted(i);
        end
        end
    end
    %%%figure('NumberTitle', 'off', 'Name', 'Nyquist');
    datacursormode on; hold on
    assetData = struct('Re', re_fitted,...
                   'Im',im_fitted,...
                   'Modul',modul_fitted,...
                   'Faza',faza_fitted/pi*180,...
                   'Omega',omega_fitted);
    setappdata(gca,'AssetData',assetData); 
    %plot(re_fitted,im_fitted, 'b');
    %plot(re_max,im_max,'rx')
    dcmObj = datacursormode(gcf);
    set(dcmObj,'UpdateFcn',@data_cursor,'Enable','on');
    warning ('on','all'); 
    %%%%figure('NumberTitle', 'off', 'Name', 'Bode');
    %sub%plot(2,1,1)
    %semilogx(omega,20*log(modul))
    %semilogx(omega_fitted,20*log(modul_fitted))
    %sub%plot(2,1,2)
    %semilogx(omega,faza*180/pi)
    %semilogx(omega_fitted,faza_fitted*180/pi)
end