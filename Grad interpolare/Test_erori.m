nume=["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","24","25","26","27"];
%%
addpath(genpath("../Functii"))
eroare1=zeros(15,length(nume));
eroare2=zeros(15,length(nume));
for i=5:15
    for j=1:length(nume)
        [~, eroare1(i,j), eroare2(i,j)]=Test_identificare("Date/"+nume(j),i);
    end
end
%%
er1=zeros(1,length(nume));
for i=5:15
    er1=eroare1(i,:);
    [i,min(er1),mean(er1),max(er1)] 
end
er2=zeros(1,length(nume));
for i=5:15
    er2=eroare2(i,:);
    [i,min(er2),mean(er2),max(er2)] 
end
%%
eroare1=zeros(length(nume),1);
eroare1p=zeros(length(nume),1);
eroare2=zeros(length(nume),1);
for j=1:length(nume)
        [eroare1(j), eroare1p(j), eroare2(j)]=Test_identificare("Date/"+nume(j),8);
end
eroare1
eroare1p
eroare2