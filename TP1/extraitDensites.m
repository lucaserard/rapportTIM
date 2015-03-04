function d= extraitDensites(image,nb,mb)
  [n,p]=size(image);
  ligne=int64(linspace(1,n,nb));
  colonne = int64(linspace(1,p,mb));
  d=zeros(nb,mb);
  
  for l=1:nb      
    for c=1:mb
      for i=ligne(l):ligne(l+1)
        for j=colonne(c):colonne(c+1)
	  if(image(i,j)==0)
	    d(l,c)=d(l,c)+1;
	  end	
        end 
      end  
      d(l,c)=d(l,c)/((ligne(l+1)-ligne(l))*(colonne(c+1)-colonne(c)));
    end
  end
  
  
end
