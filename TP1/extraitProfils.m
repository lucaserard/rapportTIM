function v = extraitProfils(im,nb)
    [n,p]=size(im);
    j=1;
    i=1;
    ligne=int64(linspace(1,n,nb))
    
    pas = int64(n/nb);
    g=[];
    d=[];
    for i=1:nb
        while(j<=p && im(ligne(i),j)==255)
           j=j+1;
        end
        g=[g j];
        j=p;
        while(j>0 && im(ligne(i),j)==255)
           j=j-1;
        end
        d=[d j];
    end
    v = [d/p g/p]
end