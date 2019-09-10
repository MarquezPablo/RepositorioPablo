%Function to perform cross-correlations between a matrix were each row is a
%burst and each column is an observation in time. [Needs ploting optimization >:v]
     %function [X,Y,Z]=Motivos(control,post)
%Input:
     %control:n*m matrix were n are defined burst and m data points
     %post:n*m matrix were n are defined burst and m data points

%Output:
     %MatrizSimilitudPre: matrix i*j where each datapoint X(i,j) is the
     %maximum normalized value of the crosscorrelation between pairwise bin
     %element of control matrix. Each bin corresponds to 0.25ms at 25000Hz
     %sampling rate.
     
     %MatrizSimilitudPost: matrix i*j where each datapoint X(i,j) is the
     %maximum normalized value of the crosscorrelation between pairwise bin
     %element of post matrix. Each bin corresponds to 0.25ms at 25000Hz 
     %sampling rate.
     
     %MatrizSimilitudAmbas: matrix i*j where each datapoint X(i,j) is the
     %maximum normalized value of the crosscorrelation between pairwise bin
     %element(i,j) of control matrix and pairwise bin element(i,j) of post
     %matrix. Each bin corresponds to 0.25ms at 25000Hz sampling rate.
     
     %Figures 1-3:image of the similarity matrices in color scale.
     %Figures 4-6:plot of the crosscorrelation between pairwise rows of 
     %control, post and control-post.
     
function [MatrizSimilitudPre,MatrizSimilitudPost,MatrizSimilitudAmbos]=Motivos(control,post)
%Data bining
c=1;
for h=1:5
    for hh=1:500/25
        BinControl(hh,:,h)=control(h,c:c+624);
        c=length(BinControl(hh,:,h))*hh+1;
    end
    c=1;
end

BinControl=[BinControl(:,:,1); BinControl(:,:,2); BinControl(:,:,3);...
            BinControl(:,:,4); BinControl(:,:,5)];
        
MatrizSimilitud=zeros(size(BinControl,1));
for i=1:size(BinControl,1)
    for ii=1:size(BinControl,1)
        MatrizSimilitud(i,ii)=max(xcorr(BinControl(i,:),BinControl(ii,:),500));
    end
end

for i=1:size(MatrizSimilitud,1)
    MatrizSimilitud(i,:)=MatrizSimilitud(i,:)/max(MatrizSimilitud(i,:));
end
MatrizSimilitudPre=MatrizSimilitud;
imagesc(MatrizSimilitud)
title('Matriz similitud bines condicion control')
colorbar

cc=1;
for h1=1:5
    for hh2=1:500/25
        BinControl1(hh2,:,h1)=post(h1,cc:cc+624);
        cc=length(BinControl1(hh2,:,h1))*hh2+1;
    end
    cc=1;
end

BinControl1=[BinControl1(:,:,1); BinControl1(:,:,2); BinControl1(:,:,3);...
            BinControl1(:,:,4); BinControl1(:,:,5)];

MatrizSimilitud1=zeros(size(BinControl1,1));
for i=1:size(BinControl1,1)
    for ii=1:size(BinControl1,1)
        MatrizSimilitud1(i,ii)=max(xcorr(BinControl1(i,:),BinControl1(ii,:),500));
    end
end

for i=1:size(MatrizSimilitud1,1)
    MatrizSimilitud1(i,:)=MatrizSimilitud1(i,:)/max(MatrizSimilitud1(i,:));
end
MatrizSimilitudPost=MatrizSimilitud1;
figure;
imagesc(MatrizSimilitud1)
title('Matriz similitud bines condicion post')
colorbar

MatrizSimilitud2=zeros(size(BinControl1,1));
for i=1:size(BinControl1,1)
    for ii=1:size(BinControl1,1)
        MatrizSimilitud2(i,ii)=max(xcorr(BinControl(i,:),BinControl1(ii,:),500));
    end
end

for i=1:size(MatrizSimilitud2,1)
    MatrizSimilitud2(i,:)=MatrizSimilitud2(i,:)/max(MatrizSimilitud2(i,:));
end
MatrizSimilitudAmbos=MatrizSimilitud2;
figure;
imagesc(MatrizSimilitud2)
title('Matriz similitud bines ambas condiciones')
colorbar

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Crosscorrelations between matrices rows
for i=1:size(control,1)
    for ii=1:size(control,1)
        CorrelacionesControl(ii,:,i)=xcorr(control(ii,:),control(i,:),'normalized');
    end
end


for i=1:size(post,1)
    for ii=1:size(post,1)
        CorrelacionesPost(ii,:,i)=xcorr(post(ii,:),post(i,:),'normalized');
    end
end

for i=1:size(post,1)
    for ii=1:size(post,1)
        CorrelacionesPostControl(ii,:,i)=xcorr(control(ii,:),post(i,:),'normalized');
    end
end

CorrelacionesTodas{1}=CorrelacionesControl;
CorrelacionesTodas{2}=CorrelacionesPost;
CorrelacionesTodas{3}=CorrelacionesPostControl;


for ii=1:3
    figure
    subplot(3,5,1)
    plot(CorrelacionesTodas{ii}(1,:,1))
    title('Rafaga 1 vs Rafaga 1')
    xlabel('Lags')
    ylabel('Correlacion')
    ylim([0 1])
    subplot(3,5,2)
    plot(CorrelacionesTodas{ii}(2,:,1))
    title('Rafaga 2 vs Rafaga 1')
    xlabel('Lags')
    ylabel('Correlacion')
    ylim([0 1])
    subplot(3,5,3)
    plot(CorrelacionesTodas{ii}(3,:,1))
    title('Rafaga 3 vs Rafaga 1')
    xlabel('Lags')
    ylabel('Correlacion')
    ylim([0 1])
    subplot(3,5,4)
    plot(CorrelacionesTodas{ii}(4,:,1))
    title('Rafaga 4 vs Rafaga 1')
    xlabel('Lags')
    ylabel('Correlacion')
    ylim([0 1])
    subplot(3,5,5)
    plot(CorrelacionesTodas{ii}(5,:,1))
    title('Rafaga 5 vs Rafaga 1')
    xlabel('Lags')
    ylabel('Correlacion')
    ylim([0 1])
    subplot(3,5,6)
    plot(CorrelacionesTodas{ii}(2,:,2))
    title('Rafaga 2 vs Rafaga 2')
    xlabel('Lags')
    ylabel('Correlacion')
    ylim([0 1])
    subplot(3,5,7)
    plot(CorrelacionesTodas{ii}(3,:,2))
    title('Rafaga 3 vs Rafaga 2')
    xlabel('Lags')
    ylabel('Correlacion')
    ylim([0 1])
    subplot(3,5,8)
    plot(CorrelacionesTodas{ii}(4,:,2))
    title('Rafaga 4 vs Rafaga 2')
    xlabel('Lags')
    ylabel('Correlacion')
    ylim([0 1])
    subplot(3,5,9)
    plot(CorrelacionesTodas{ii}(5,:,2))
    title('Rafaga 5 vs Rafaga 2')
    xlabel('Lags')
    ylabel('Correlacion')
    ylim([0 1])
    subplot(3,5,10)
    plot(CorrelacionesTodas{ii}(3,:,3))
    title('Rafaga 3 vs Rafaga 3')
    xlabel('Lags')
    ylabel('Correlacion')
    ylim([0 1])
    subplot(3,5,11)
    plot(CorrelacionesTodas{ii}(4,:,3))
    title('Rafaga 4 vs Rafaga 3')
    xlabel('Lags')
    ylabel('Correlacion')
    ylim([0 1])
    subplot(3,5,12)
    plot(CorrelacionesTodas{ii}(5,:,3))
    title('Rafaga 5 vs Rafaga 3')
    xlabel('Lags')
    ylabel('Correlacion')
    ylim([0 1])
    subplot(3,5,13)
    plot(CorrelacionesTodas{ii}(4,:,4))
    title('Rafaga 4 vs Rafaga 4')
    xlabel('Lags')
    ylabel('Correlacion')
    ylim([0 1])
    subplot(3,5,14)
    plot(CorrelacionesTodas{ii}(5,:,4))
    title('Rafaga 5 vs Rafaga 4')
    xlabel('Lags')
    ylabel('Correlacion')
    ylim([0 1])
    subplot(3,5,15)
    plot(CorrelacionesTodas{ii}(5,:,5))
    title('Rafaga 5 vs Rafaga 5')
    xlabel('Lags')
    ylabel('Correlacion')
    ylim([0 1])
    if ii==1
    sgtitle('Rafagas control')
    elseif ii==2
    sgtitle('Rafagas post')
    else
    sgtitle('Rafagas control vs rafagas post')
    end
end