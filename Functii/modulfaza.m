function [modul, faza] = modulfaza(trecere0u, extremeu, trecere0y, extremey)
    modul=zeros(length(extremey),1);
    faza=zeros(length(extremey),1);
    for i=1:min(length(extremey))
        modul(i)=extremey(i)/extremeu(i);
        faza(i)=-(trecere0y(i)-trecere0u(i))/(trecere0u(i+1)-trecere0u(i))*pi;
    end
end