function [extreme] = extreme(timp, semnal, trecere0)
    y=semnal-mean(semnal);
    t=timp;
    Te=t(2)-t(1);
    extreme=zeros(length(trecere0)-1, 1);
    trecere0=trecere0-timp(1);
    for i=1:length(trecere0)-1
        if(y(fix(trecere0(i)/Te+2))>0)
            extreme(i)=max(y(fix(trecere0(i)/Te+2):fix(trecere0(i+1)/Te+1)));
        else
            extreme(i)=min(y(fix(trecere0(i)/Te+2):fix(trecere0(i+1)/Te+1)));
        end
    end
end