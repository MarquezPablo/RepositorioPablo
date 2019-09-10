%Function to perform dimentional reduction and clusterization with two
%different methods.
    %[]=ReduccionCluster(Matriz,reduccion,cluster)

%Input:
    %Matriz=Data matrix where each column represents a high dimentional data
    %vector.
    
    %reduccion: set 1 for PCA dimentional reduction.
                %set 2 for t-SNE dimentional reduction.
    
    %cluster: set 1 for k-means clusterization.
              %set 2 for agglomerative hierarchical clustering.
 
%Output: No outputs are retrieved from this function

function []=ReduccionCluster(Matriz,reduccion,cluster)
Spikes=Matriz';
if reduccion==1
    %Componentes principales
    [coeff,datosPCA,latent]=pca(Spikes);
    sumEigenValores=cumsum(latent);
    sumEigenValores=sumEigenValores./sumEigenValores(end);
    var80=find(sumEigenValores>0.8);
    var80=var80(1);
elseif reduccion==2
    %t-Distributed Stochastiic Neighbor Embbeding
    tSNE=tsne(Spikes);
end
% Clusterizacion 
if cluster==1 && reduccion==1
    %k-means
    eva = evalclusters(datosPCA,'kmeans','CalinskiHarabasz','KList',[1:5]);
    idxKmeans=kmeans(datosPCA(:,1:var80),eva.OptimalK);
    scatter3(datosPCA(:,1),datosPCA(:,2),datosPCA(:,3),100,idxKmeans,'filled');
elseif cluster==1 && reduccion==2
    eva = evalclusters(tSNE,'kmeans','CalinskiHarabasz','KList',[1:2]);
    idxKmeans=kmeans(tSNE(:,1:2),eva.OptimalK);
    scatter(tSNE(:,1),tSNE(:,2),100,idxKmeans,'filled');
elseif cluster==2 && reduccion==1
    %Clusterizacion aglomerativa
    eva1 = evalclusters(datosPCA,'linkage','CalinskiHarabasz','KList',[1:5]);
    idxAglomerative=clusterdata(datosPCA(:,1:var80),eva1.OptimalK);
    scatter3(datosPCA(:,1),datosPCA(:,2),datosPCA(:,3),100,idxAglomerative,'filled');
elseif cluster==2 && reduccion==2
    eva1 = evalclusters(tSNE,'linkage','CalinskiHarabasz','KList',[1:2]);
    idxAglomerative=clusterdata(tSNE(:,1:2),eva1.OptimalK);
    scatter(tSNE(:,1),tSNE(:,2),100,idxAglomerative,'filled');
end
% clearvars