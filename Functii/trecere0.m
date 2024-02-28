function [trecere0] = trecere0(timp, semnal)
    y=semnal;
    ym=mean(y);
    t=timp;
    Te=t(2)-t(1);
    lungime=0;
    for i=2:length(y)
        if y(i)>ym && y(i-1)<ym || y(i)<ym && y(i-1)>ym || y(i)==ym
            lungime=lungime+1;
        end
    end

    trecere0=zeros(lungime, 1); 
    lungime=0;
    for i=2:length(y)
        if y(i)>ym && y(i-1)<ym || y(i)<ym && y(i-1)>ym || y(i)==ym
            a=(y(i)-y(i-1))/Te;
            b=y(i)-a*t(i);
            x=(ym-b)/a;
            lungime=lungime+1;
            trecere0(lungime)=x;
        end
    end
end