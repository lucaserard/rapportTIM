%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Squelette de programme pour tp de reco de formes 	%%%%%
%%%%%   Cl�ment Chatelain          janvier 2013		%%%%%
%%%%%   D�partement ASI - INSA de Rouen 		%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all;
clear all;

Xapp=[];
Yapp=[];

%%%%%%%%%%%%%%%%%%%% apprentissage %%%%%%%%%%%%%%%%%%%%%%%%%
im = imread('app.tif'); % lecture fichier image d'apprentissage
coordImages = extractionImages(im); 
nbImageBaseApp = length(coordImages);
sprintf('APPRENTISSAGE detection images OK : %d images detectees\n', nbImageBaseApp);

for (iImage=1 : nbImageBaseApp)
    iImage;
    % localisation et extraction des imagettes
    largeur = coordImages(iImage, 2) - coordImages(iImage, 1) - 2;
    hauteur = coordImages(iImage, 4) - coordImages(iImage, 3) - 2;
    x0 = coordImages(iImage, 1);
    y0 = coordImages(iImage, 3);
    imageChiffre = subimage(im, largeur, hauteur, x0, y0);
  
    % crop (supprimer les bords blancs)
    imageChiffreCroppee = crop(imageChiffre);    
    imagesc(imageChiffreCroppee); %afficher les imagettes de chiffres    
    
    %%%%%% ICI c'est � vous de Jouer !!!%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % extraire des caractéristiques ...
    d = extraitProfils(imageChiffreCroppee,20);
    
    Xapp=[Xapp;d];
    Yapp = [Yapp;fix((iImage-1)/20)]
    
    % faire un mod�le ...
    % le sauvegarder ...
    
    % Astuce : la classe de l'image courante est donnee par : iClasse = fix((iImage-1)/20)
    sprintf('classe de l image %d : %d\n', iImage, fix((iImage-1)/20))
    
    
    %%%%%%%%%%%%%%%%%%%%%%
end
save modele.dat Xapp -ascii
save classes.dat Yapp -ascii
%[YPeval, MatDist]=kppv(Xeval,Xapp,Yapp,K,[]);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% decision %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
load('modele.dat');
load('classes.dat');

imTest = imread('test.tif'); % lecture fichier image test
coordImagesTest = extractionImages(imTest);
length(coordImagesTest)
nbImageBaseTest = length(coordImagesTest);
K=1;
resultats=[];
for (iImage=1 : nbImageBaseTest)
    largeur = coordImagesTest(iImage, 2) - coordImagesTest(iImage, 1) - 2;
    hauteur = coordImagesTest(iImage, 4) - coordImagesTest(iImage, 3) - 2;
    
    % extraction image
    imageChiffre = subimage(imTest, largeur, hauteur, coordImagesTest(iImage, 1), coordImagesTest(iImage, 3));
    
    % crop
    imageChiffreCroppee = crop(imageChiffre);    
    imagesc(imageChiffreCroppee); %afficher les imagettes de chiffres
    
    %%%%%% ICI c'est � vous de Jouer !!!%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    d= extraitProfils(imageChiffreCroppee,20);
    %[YPeval,MatDist]=kppv(d,modele,classes,K,[]);
    YPeval = kppvPerso(d,modele,classes);
    resultats=[resultats,YPeval];

    
    
    
    
end



%%%%%%%%% Calcul des performances %%%%%%%%

matriceRes=reshape(resultats,10,10)
perf=tauxDeHit(resultats);


matConf = confusions(resultats)


