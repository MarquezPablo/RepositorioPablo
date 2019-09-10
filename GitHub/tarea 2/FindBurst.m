%Function to find burst of signal defined as the signal that comes 500ms
%after a certain threshold, compute correlation between burst, make bins
%for each burst and compute correlation between bins.

%Inputs=[signal matrix,channel from that matrix]
%Output=[Correlation matrix between bins,Correlation matrix between burst]


function [MatrizCorrelacionBines,MatrizCorrelacionRafagas]=FindBurst(jCanales,canal)
signal=jCanales(canal,:);

PromedioCanal=mean(signal);
DesvEstandarCanal=std(signal);
% Find points above threshold
PointsAboveThreshold=find(signal>(PromedioCanal+DesvEstandarCanal*3));

StartingPoints=[1 find(diff(PointsAboveThreshold)>12500)+1];

windowsize=25000/2;
c=1;
for i=StartingPoints
    Rafagas(c,:)=signal(PointsAboveThreshold(i):(PointsAboveThreshold(i))+windowsize-1);
    c=c+1;
end

MatrizCorrelacionRafagas=corr(Rafagas');

startBinPoints=1:(25000*0.025):12500;

cc=1;
ccc=1;
for ii=1:size(Rafagas,1)
    for iii=startBinPoints
        MatrizBin{cc,ccc}=Rafagas(cc,iii:iii+624);
        ccc=ccc+1;
    end
    cc=cc+1;
    ccc=1;
end

contador=1;
for fila=1:size(MatrizBin,1)
    for columna=1:size(MatrizBin,2)
        MatrizCov(:,contador)=MatrizBin{fila,columna}';
        contador=contador+1;
    end
end

MatrizCorrelacionBines=corr(MatrizCov);
imagesc(MatrizCorrelacionBines)
colormap('jet')
title('Correlacion Bines 25ms')
figure
imagesc(MatrizCorrelacionRafagas)
colormap('jet')
title('Correlacion Rafagas 500ms')