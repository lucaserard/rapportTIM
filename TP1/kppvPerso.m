function c = kppvPerso(Xapp,Yapp,Xeval,k)

  %On initialise les variables	 
  [n,p]=size(Xapp);
  voisins = [];
  count=zeros(1,10);
  
  %On calcule les distances pour chaque point de la base d'apprentissage
  for i=1:n
    voisins = [voisins;distance(Xeval,Xapp(i,:)) Yapp(i)];
  end

  %On trie les voisins selon la distance
  voisins = sort(voisins,1)
  
  %On récupère les classes des k plus proches
  classes=voisins(1:k,2);

  %On compte le nombre d'occurences de chaque classe dans les kppv
  for i=1:k
    count(classes(i)+1)=count(classes(i)+1)+1;
  end

  %On récupère la ou les classes avec le maximum d'occurences 
  c=find(max(count));
  
  %On retourne une des classes (à améliorer ...)
  c=c(1);

end
