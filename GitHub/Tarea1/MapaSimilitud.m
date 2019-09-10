% Function to display a similarity matrix where each column of the input
% matrix is taken as a high dimentional vector
              %[]=MapaSimilitud(Matriz)
                  
%Input:
    %Matriz: Data matrix of n*m where each m is a high dimentional vector

function []=MapaSimilitud(Matriz)
Rasterbin=Matriz;

Magnitude=zeros(size(Rasterbin,2),1)';
for i=1:size(Rasterbin,2)
  Magnitude(1,i)=norm(Rasterbin(:,i));
end

AngleMatrix=zeros(size(Rasterbin,2));
for j=1:size(Rasterbin,2)
    for ii=1:size(Rasterbin,2)
        AngleMatrix(j,ii)=(sum((Rasterbin(:,j).*(Rasterbin(:,ii)))))/(Magnitude(1,j)*Magnitude(1,ii));
    end

end

imagesc(AngleMatrix)
colorbar
colormap('jet') 
title('Mapa de similitud vectores poblacionales')
xlabel('Angulo entre vectores')
ylabel('Angulo entre vectores')