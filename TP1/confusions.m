function m = confusions(resultats)
    mat = reshape(resultats,10,10);
    m=zeros(10);
    for i=1:10
        for j=1:10
            m(i,mat(j,i)+1)= m(i,mat(j,i)+1)+1;
        end
    end